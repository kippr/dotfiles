#!/usr/bin/env python3
"""Always-on, read-only Markdown+Mermaid viewer.

Serves ONLY *.md files located under $HOME, rendered as HTML with mermaid
diagrams drawn client-side. GET-only by construction: no PUT/POST/DELETE
handlers exist, so it can never write or modify a file.

Endpoints:
  /?dir=<relpath>        directory browser (subfolders + *.md), one level deep
  /view?file=<relpath>   the viewer page for one markdown file
  /raw?file=<relpath>    raw markdown text (only *.md, only under $HOME)
"""
import html
import json
import os
import posixpath
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs, quote

HOME = os.path.realpath(os.path.expanduser("~"))
PORT = int(os.environ.get("MD_VIEWER_PORT", "8137"))
# directories we never descend into when building the index
SKIP = {".git", "node_modules", ".venv", "venv", "__pycache__", ".Trash",
        "Library", ".cache", ".npm", ".pyenv", "site-packages"}

VIEWER_HTML = r"""<!DOCTYPE html><html lang="en"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>__TITLE__</title>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/svg-pan-zoom@3.6.1/dist/svg-pan-zoom.min.js"></script>
<style>
 :root{color-scheme:light dark}
 body{font:16px/1.6 -apple-system,system-ui,sans-serif;max-width:980px;margin:0 auto;padding:2rem 3rem}
 table{border-collapse:collapse}th,td{border:1px solid #8884;padding:4px 8px}
 pre{background:#8881;padding:12px;border-radius:6px;overflow-x:auto}
 code{background:#8881;padding:1px 4px;border-radius:3px}
 .mwrap{position:relative}
 .mermaid{background:#fff;border-radius:6px;padding:8px;margin:1rem 0}
 .fsbtn{position:absolute;top:10px;right:10px;z-index:5;cursor:pointer;border:none;
        background:#0007;color:#fff;border-radius:6px;padding:3px 8px;font-size:13px;opacity:.5}
 .mwrap:hover .fsbtn{opacity:1}
 #bar{position:fixed;top:0;right:0;padding:4px 10px;font-size:12px;background:#8882;border-bottom-left-radius:6px}
 #bar a{margin-left:10px}
 h1,h2,h3{border-bottom:1px solid #8883;padding-bottom:.2em}
 /* yaml frontmatter metadata box */
 .fm{margin:0 0 1.5rem;border:1px solid #8883;border-radius:8px;overflow:hidden;font-size:14px}
 .fm table{border-collapse:collapse;width:100%}
 .fm td{border:none;border-bottom:1px solid #8882;padding:6px 12px;vertical-align:top}
 .fm tr:last-child td{border-bottom:none}
 .fm .k{font-weight:600;color:#888;white-space:nowrap;width:1%;text-transform:capitalize}
 /* fullscreen overlay */
 #ov{position:fixed;inset:0;z-index:1000;background:#fff;display:none}
 #ov.on{display:block}
 #ovsvg{width:100vw;height:100vh}
 #ovsvg svg{width:100%!important;height:100%!important;max-width:none!important}
 #ovbar{position:fixed;top:12px;right:16px;z-index:1001;display:flex;gap:6px}
 #ovbar button{cursor:pointer;border:none;background:#0008;color:#fff;border-radius:6px;
               width:34px;height:34px;font-size:16px}
 #ovhint{position:fixed;bottom:12px;left:16px;z-index:1001;font-size:12px;color:#666}
</style></head><body>
<div id="bar"><a href="__DIR__">▤ index</a> · read-only · auto-refresh</div>
<div id="content">Loading…</div>

<div id="ov">
  <div id="ovbar">
    <button data-z="in" title="Zoom in">+</button>
    <button data-z="out" title="Zoom out">&minus;</button>
    <button data-z="reset" title="Reset / fit">&#9633;</button>
    <button data-z="close" title="Close (Esc)">&times;</button>
  </div>
  <div id="ovsvg"></div>
  <div id="ovhint">scroll = zoom · drag = pan · Esc = close</div>
</div>

<script>
 const FILE="__FILE__";
 mermaid.initialize({startOnLoad:false,theme:"default"});
 let last=null, spz=null;
 const ov=document.getElementById("ov"), ovsvg=document.getElementById("ovsvg");

 function closeOv(){
   ov.classList.remove("on");
   if(spz){try{spz.destroy()}catch(e){}; spz=null;}
   ovsvg.innerHTML="";
 }
 function openOv(svgEl){
   ovsvg.innerHTML="";
   const clone=svgEl.cloneNode(true);
   clone.removeAttribute("style");          // drop mermaid's max-width cap
   ovsvg.appendChild(clone);
   ov.classList.add("on");
   // svg-pan-zoom needs the element in the DOM and sized
   spz=svgPanZoom(clone,{zoomEnabled:true,controlIconsEnabled:false,fit:true,center:true,
                         minZoom:0.2,maxZoom:40,zoomScaleSensitivity:0.4});
 }
 document.getElementById("ovbar").onclick=e=>{
   const z=e.target.dataset.z; if(!z||!spz&&z!=="close")return;
   if(z==="in")spz.zoomBy(1.4);
   else if(z==="out")spz.zoomBy(1/1.4);
   else if(z==="reset"){spz.resetZoom();spz.center();spz.fit();}
   else if(z==="close")closeOv();
 };
 document.addEventListener("keydown",e=>{if(e.key==="Escape")closeOv()});

 async function render(){
   if(ov.classList.contains("on"))return;   // don't redraw under an open overlay
   let md; try{md=await (await fetch("/raw?file="+encodeURIComponent(FILE)+"&t="+Date.now())).text()}catch(e){return}
   if(md===last)return; last=md;
   // pull off a leading YAML frontmatter block (--- ... ---) and render it as a table
   let fmHtml="";
   const fm=md.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?/);
   if(fm){
     md=md.slice(fm[0].length);
     const rows=[];
     for(const line of fm[1].split(/\r?\n/)){
       const m=line.match(/^([A-Za-z0-9_-]+)\s*:\s*(.*)$/);
       if(!m)continue;
       const key=m[1].replace(/_/g," ");
       let val=m[2].trim().replace(/^["']|["']$/g,"");   // strip surrounding quotes
       if(!val)continue;
       const esc=s=>s.replace(/[&<>"]/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
       const cell=/^https?:\/\//.test(val)?`<a href="${esc(val)}" target="_blank" rel="noopener">${esc(val)}</a>`:esc(val);
       rows.push(`<tr><td class="k">${esc(key)}</td><td>${cell}</td></tr>`);
     }
     if(rows.length)fmHtml=`<div class="fm"><table>${rows.join("")}</table></div>`;
   }
   const blocks=[];
   md=md.replace(/```mermaid\n([\s\S]*?)```/g,(_,c)=>{blocks.push(c);return `\n<div class="mph" data-i="${blocks.length-1}"></div>\n`});
   document.getElementById("content").innerHTML=fmHtml+marked.parse(md);
   document.querySelectorAll(".mph").forEach(el=>{const d=document.createElement("div");d.className="mermaid";d.textContent=blocks[+el.dataset.i];el.replaceWith(d)});
   try{await mermaid.run({querySelector:".mermaid"})}catch(e){console.warn("mermaid:",e)}
   // wrap each rendered diagram and add a fullscreen button
   document.querySelectorAll(".mermaid").forEach(m=>{
     if(m.parentElement.classList.contains("mwrap"))return;
     const w=document.createElement("div");w.className="mwrap";
     m.parentNode.insertBefore(w,m);w.appendChild(m);
     const b=document.createElement("button");b.className="fsbtn";b.textContent="⛶ fullscreen";
     b.onclick=()=>{const svg=m.querySelector("svg");if(svg)openOv(svg)};
     w.appendChild(b);
   });
 }
 render(); setInterval(render,1500);
</script></body></html>"""


def safe_md_path(rel):
    """Resolve rel under HOME; return abs path iff it's a *.md inside HOME."""
    if not rel:
        return None
    # normalise and block traversal
    rel = posixpath.normpath(rel.lstrip("/"))
    abs_path = os.path.realpath(os.path.join(HOME, rel))
    if not abs_path.startswith(HOME + os.sep):
        return None
    if not abs_path.lower().endswith(".md"):
        return None
    if not os.path.isfile(abs_path):
        return None
    return abs_path


def safe_dir(rel):
    """Resolve a directory rel-path under HOME; return abs path iff valid."""
    rel = posixpath.normpath((rel or "").lstrip("/"))
    if rel == ".":
        rel = ""
    abs_path = os.path.realpath(os.path.join(HOME, rel))
    if abs_path != HOME and not abs_path.startswith(HOME + os.sep):
        return None
    if not os.path.isdir(abs_path):
        return None
    return abs_path


def browse_dir(rel):
    """List immediate subdirs and *.md files in one directory under HOME.

    Subdirs in SKIP / dotdirs are hidden. Returns (subdirs, mdfiles) as
    rel-to-HOME paths, sorted. Cheap: one os.scandir, no recursion.
    """
    base = safe_dir(rel)
    if base is None:
        return None, None
    subdirs, mdfiles = [], []
    try:
        with os.scandir(base) as it:
            for e in it:
                if e.name.startswith(".") or e.name in SKIP:
                    continue
                relpath = os.path.relpath(e.path, HOME)
                if e.is_dir():
                    subdirs.append(relpath)
                elif e.is_file() and e.name.lower().endswith(".md"):
                    mdfiles.append(relpath)
    except PermissionError:
        pass
    subdirs.sort(key=str.lower)
    mdfiles.sort(key=str.lower)
    return subdirs, mdfiles


class Handler(BaseHTTPRequestHandler):
    def _send(self, body, ctype="text/html; charset=utf-8", code=200):
        if isinstance(body, str):
            body = body.encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):  # the ONLY verb implemented → server is read-only
        u = urlparse(self.path)
        q = parse_qs(u.query)
        if u.path == "/":
            rel = (q.get("dir") or [""])[0]
            subdirs, mdfiles = browse_dir(rel)
            if subdirs is None:
                return self._send("Not a directory under $HOME", code=404)
            cur = posixpath.normpath(rel.lstrip("/")) if rel else ""
            cur = "" if cur == "." else cur
            # breadcrumb: ~ / a / b
            crumbs = ['<a href="/">~</a>']
            acc = ""
            for part in [p for p in cur.split("/") if p]:
                acc = f"{acc}/{part}" if acc else part
                crumbs.append(f'<a href="/?dir={quote(acc)}">{html.escape(part)}</a>')
            # parent ".." link
            up = ""
            if cur:
                parent = posixpath.dirname(cur)
                up = f'<li>📁 <a href="/?dir={quote(parent)}">..</a></li>' if parent \
                     else '<li>📁 <a href="/">..</a></li>'
            dir_items = "".join(
                f'<li>📁 <a href="/?dir={quote(p)}">{html.escape(os.path.basename(p))}/</a></li>'
                for p in subdirs)
            file_items = "".join(
                f'<li>📄 <a href="/view?file={quote(p)}">{html.escape(os.path.basename(p))}</a></li>'
                for p in mdfiles)
            empty = "" if (subdirs or mdfiles) else "<li><em>(no subfolders or .md files here)</em></li>"
            self._send(
                f"<!DOCTYPE html><meta charset=utf-8><title>{html.escape(cur or '~')} — md browser</title>"
                f"<style>body{{font:15px/1.6 system-ui;max-width:900px;margin:2rem auto;padding:0 2rem}}"
                f"li{{list-style:none;margin:2px 0}}ul{{padding-left:0}}"
                f"#bc{{font-size:13px;color:#888;margin-bottom:1rem}}#bc a{{margin:0 2px}}</style>"
                f"<div id=bc>{' / '.join(crumbs)}</div>"
                f"<ul>{up}{dir_items}{file_items}{empty}</ul>")
        elif u.path == "/view":
            rel = (q.get("file") or [""])[0]
            if not safe_md_path(rel):
                return self._send("Not a viewable .md under $HOME", code=404)
            # link back to the file's containing directory in the index
            parent = posixpath.dirname(posixpath.normpath(rel.lstrip("/")))
            dir_url = f"/?dir={quote(parent)}" if parent else "/"
            page = (VIEWER_HTML.replace("__FILE__", html.escape(rel))
                              .replace("__DIR__", html.escape(dir_url))
                              .replace("__TITLE__", html.escape(rel)))
            self._send(page)
        elif u.path == "/raw":
            p = safe_md_path((q.get("file") or [""])[0])
            if not p:
                return self._send("Not found", "text/plain", 404)
            with open(p, "r", encoding="utf-8", errors="replace") as fh:
                self._send(fh.read(), "text/plain; charset=utf-8")
        else:
            self._send("Not found", "text/plain", 404)

    def log_message(self, *a):  # quiet
        pass


if __name__ == "__main__":
    # bind localhost only — never exposed to the network
    ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
