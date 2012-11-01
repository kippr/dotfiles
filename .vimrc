
" Based on Bram Molenaar's example, added to quite a bit since then

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  colorscheme kip
  set hlsearch
endif

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

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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
inoremap jj <ESC>
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
  set relativenumber
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
nnoremap <cr> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" long line handling
set wrap
set textwidth=129
set formatoptions=qrn1
if version >= 703
  set colorcolumn=131
endif



" whitespace handling
set tabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:▸\ ,eol:¬

syntax on

" jump around using ctrl-mv keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <space> zz


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

" set display options
if has('transparency')
  set transparency=20
  set fullscreen
endif
set background=light

if has("win32") || has("win64")
    set guifont=lucida_sans_typewriter:h9:cANSI
endif

" map ctrl-space to autocomplete - wont' work :( "inoremap <C-Space> <C-p>
"inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
"\ "\<lt>C-n>" :
"\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
"\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
"\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
"imap <C-@> <C-Space>


if has("win32") || has("win64")
   set directory=$TMP
else
   set directory=/tmp
end

if has("win32") || has("win64")
    set guioptions-=m
    set guioptions-=T
end

map <Leader>b :MiniBufExplorer<cr>

" enable Gary Bernhardt's python complexity gutter by default
let g:complexity_always_on = 1

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


function! RunPythonTest(args)
    let cmd = ":wa!\n!nosetests -m \"((?:^\|[_.-])(:?[tT]est\|When\|should))\"" . a:args
    execute cmd
    if v:shell_error
        call RedBar()
    else
        call GreenBar()
    end
endfunction

" and this from Gary Bernhardt
function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=green guibg=green
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


" run one rspec example or describe block based on cursor position
nnoremap <leader>S :call RunRspec(" % -l " . <C-r>=line('.')<CR>)<cr>
" run full rspec file
nnoremap <leader>s :call RunRspec(" % ")<cr>
nnoremap <leader>a :call RunRspec("")

nnoremap <leader>g :call GreenBar()


nnoremap <leader>t :call RunPythonTest(" % ")<cr>
nnoremap <leader>T :call RunPythonTest("")<cr>

nnoremap <leader>f :set fullscreen!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   Plugin defs  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Pathogen makes anything in vim/bundle work as plugin
call pathogen#infect()

filetype plugin indent on


"NERD Tree explorer
nmap <silent> <c-n> :NERDTreeToggle<CR>



