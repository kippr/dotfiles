
" Based on Bram Molenaar's example, added to quite a bit since then

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" use system clipboard by default
set clipboard=unnamed
"
syntax enable

" set display options
" I don't know what this is about but without flipping I don't get syntax highlighting
"set background=dark
set background=light
"
"let g:solarized_termcolors=256
colorscheme solarized

set shell=bash

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
    set backupdir=$TEMP
    set undodir=$TEMP
    set directory=$TEMP
endif
set history=200		" keep lines of command line history

set winwidth=134
set winheight=30
set winminheight=8
" no idea why I can't just set this to 999 up front :(
set winheight=999
set scrolloff=3


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set wildignore+=*.pyc,.git,dojo-1.8.1

function! QfMakeCopy()
  let cmd = ":!~/bin/cp_build_file.sh " . &errorfile
  exec cmd
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  autocmd BufNewFile,BufRead *.py compiler nose
  autocmd QuickFixCmdPost * call QfMakeCopy()

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           KP's options
"                           mainly from:
"                           http://stevelosh.com/blog/2010/09/coming-home-to-vim/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



set nocompatible

set fileformats=unix,dos

" treatment for RSI
"inoremap jj <ESC>j
"inoremap kk <ESC>k
let mapleader = "\\"
nnoremap ; :

" general improvements
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
if version >= 703
  set numberwidth=3
  set relativenumber
  set number
  set undofile
endif



" searching/ replacing
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
"nnoremap <cr> :nohlsearch<cr>
" remapping enter to above breaks enter on quickfix - way to avoid that?
nmap <space> :nohlsearch<cr>zz
nnoremap <tab> %
vnoremap <tab> %

"inoremap <C-Space> <C-O>za
"nnoremap <C-Space> za
"onoremap <C-Space> <C-C>za
"vnoremap <C-Space> zf
"map <C-@> <C-Space>

" long line handling
set wrap
set textwidth=120
set formatoptions=qrn1
if version >= 703
  set colorcolumn=121
endif

" For all text files set 'textwidth' 
autocmd FileType text setlocal textwidth=120

autocmd FileType sql setlocal shiftwidth=4 tabstop=4 noexpandtab

"set statusline=%{fugitive#statusline()}

set foldlevel=99

" whitespace handling
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list
set listchars=tab:▸\ ,eol:¬

" jump around using ctrl-mv keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l




" stop using the cursor keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" disable f1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" save on switch window
if has('mac')
  au FocusLost * !silent wa
endif

" save on switch buffer
:set autowriteall


if has("win32") || has("win64")
    set guifont=lucida_sans_typewriter:h9:cANSI
endif
"
" using Source Code Pro
set anti enc=utf-8
set guifont=Source\ Code\ Pro\ 11

" map ctrl-space to autocomplete - wont' work :( "inoremap <C-Space> <C-p>
"inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
"\ "\<lt>C-n>" :
"\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
"\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
"\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
"imap <C-@> <C-Space>


if has("win32") || has("win64")
    set guioptions-=m
    set guioptions-=T
end

set tags=~/.ctags-data
"au BufWritePost *.py,*.rb silent! !nice ctags -R ~/ac/* ~/code/* &




" enable Gary Bernhardt's python complexity gutter by default
"let g:complexity_always_on = 1


"" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
" Sudo to write
cmap w!! w !sudo tee % >/dev/null



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   Random stuff      """"""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   Run tests/ specs  """"""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let g:RspecBin="zsh -c '. ~/.zshrc && rspec"
function! RunRspec(args)
 " shame this is required but can't get rvm working otherwise
 let spec = "zsh -c '. ~/.zshrc && rspec"
 let cmd = ":w!\n! " . spec . a:args . "'"
 execute cmd
 if v:shell_error
   call RedBar()
 else
   call GreenBar()
 end
endfunction

function! RunSingleDjangoTest(use_make)
    let in_test_file = match(expand("%"), '\([Tt]est\(s\)\?.py\)$') != -1
    if in_test_file
        let t:test_file=@%
    elseif !exists("t:test_file")
        return
    end
    call RunDjangoTests(t:test_file, 0)
endfunction

function! RunDjangoTests(test_file, use_make)
    " add -s to make stdout print
    " Switch to nose compiler file
    if (match(a:test_file, 'creditqb') == -1 || a:use_make == 0)
        echo "Using Dispatch, value of make: " . a:use_make . ", value of test_file: " . a:test_file
        "let cmd = ":wa! | Dispatch . ~/ac/Environments/trialanderror/bin/activate && REUSE_DB=1 ~/ac/trialanderror/manage.py test -m\"((?:^\|[_.-])(:?[tT]est[s]?\|When\|should))\" " . a:test_file
        "let cmd = ":wa! | Dispatch . ~/ac/Environments/CreditQB/bin/activate && REUSE_DB=1 nosetests -s -m\"((?:^\|[_.-])(:?[tT]est[s]?\|When\|should))\" " . a:test_file
        let cmd = ":wa! | Dispatch REUSE_DB=1 nosetests -s -m\"((?:^\|[_.-])(:?[tT]est[s]?\|When\|should))\" " . a:test_file
    else
        echo "Using Make"
        let cmd = ":wa! | Make " . a:test_file
    end
    "sleep 3
    execute cmd
endfunction

function! RunPythonTests(test_file, use_make)
    " add -s to make stdout print
    " Switch to nose compiler file
    if (a:use_make == 0)
        echo "Using Dispatch, value of make: " . a:use_make . ", value of test_file: " . a:test_file
        let cmd = ":wa! | Dispatch . ~/ac/Environments/MIS/bin/activate && nosetests -m \"((?:^\|[_.-])(:?[tT]est\|When\|should))\" " . a:test_file
        "let cmd = ":wa! | Dispatch . ~/ac/Environments/CreditMon/bin/activate && REUSE_DB=1 ~/ac/CredtMon/misweb/manage.py test -m\"((?:^\|[_.-])(:?[tT]est[s]?\|When\|should))\" --with-fixture-bundling " . a:test_file
    else
        let cmd = ":wa!\n!nosetests -m \"((?:^\|[_.-])(:?[tT]est\|When\|should))\" " . a:test_file
    end
    "sleep 3
    execute cmd
endfunction

function! RunSinglePythonTest(use_make)
    let in_test_file = match(expand("%"), '\([Tt]est\(s\)\?.py\)$') != -1
    if in_test_file
        let t:test_file=@%
    elseif !exists("t:test_file")
        return
    end
    call RunPythonTests(t:test_file, a:use_make)
endfunction

" and this from Gary Bernhardt
function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=lightgreen guibg=lightgreen
    echohl GreenBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   Leader defs  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      \
"open up new window
nnoremap <leader>w :vsplit<cr><c-w>l
nnoremap <leader>W :split<cr><c-w>j
nnoremap <leader>x :quit<cr>

nnoremap <leader>c :cclose<cr><cr>

" run one rspec example or describe block based on cursor position
"nnoremap <leader>S :call RunRspec(" % -l " . <C-r>=line('.')<CR>)<cr>
" run full rspec file
"nnoremap <leader>s :call RunRspec(" % ")<cr>
"nnoremap <leader>a :call RunRspec("")

nnoremap <leader>s :call RunSinglePythonTest(0)<cr><cr>
nnoremap <leader>S :call RunPythonTests("", 0)<cr><cr>


nnoremap <leader>r :call RunSingleDjangoTest(0)<cr><cr>
nnoremap <leader><c-r> :call RunSingleDjangoTest(0)<cr><cr>
nnoremap <leader>R :call RunDjangoTests("", 1)<cr><cr>

nnoremap <leader>s :call RunSinglePythonTest(0)<cr><cr>
nnoremap <leader><c-s> :call RunSinglePythonTest(1)<cr><cr>
nnoremap <leader>S :call RunPythonTests("", 0)<cr><cr>

"nnoremap <leader>f :set fullscreen!<cr>
nnoremap <leader>f :FixWhitespace<cr>
nnoremap <leader>c :w<cr>:SyntasticCheck<cr>
nnoremap <leader>C :SyntasticReset<cr>


" quickfix nav
nnoremap <leader>n :cn<cr>
nnoremap <leader>p :cp<cr>
nnoremap <c-c> :cn<cr>
nnoremap <c-g> :cp<cr>

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

" jedi-vim remaps
"let g:jedi#rename_command = "<leader>N"


" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaEdit(choice_command, selecta_args)
  try
    let selection = fnameescape(substitute(system(a:choice_command . " | selecta " . a:selecta_args), '\n$', '', 'g'))
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec ":e " . selection
endfunction


function! SelectaBuffer()
  try
    redir => bufs
      silent buffers
    redir END
    let selection = system("vim-selecta-buffer", bufs)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  if selection
    exec ":b " . selection
  endif
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>t :call SelectaEdit("/Users/kip/bin/selecta-src-files", "")<cr>
nnoremap <leader>m :call SelectaEdit("/Users/kip/bin/selecta-python-path", "")<cr>
nnoremap <leader>T :call SelectaEdit("find * -type f", "")<cr>
nnoremap <leader>b :call SelectaBuffer()<cr>
nnoremap <leader>g :call SelectaEdit("git status --short \| sed 's/\"//g' \| tee /tmp/thu \| cut -c 4- ", "")<cr>


" large file options
let g:LargeFile = 1024 * 1024 * 100
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction


" use ag instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

source /Users/kip/code/Tools/private-dotfiles/dbext-config.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   Plugin defs  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Pathogen makes anything in vim/bundle work as plugin
call pathogen#infect()

filetype plugin indent on


let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_python_checkers = ['python', 'pep8']
"
" vimwiki stuff
let g:vimwiki_list = [{'path': '~/Personal/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
