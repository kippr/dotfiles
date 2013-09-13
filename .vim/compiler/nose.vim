" Compiler:CompilerUnit testing for Python using nose
" Maintainer:MaintainerOlivier Le Thanh Duong &lt;olivier@lethanh.be&gt;
" Contributor: Marcus Carlsson &lt;carlsson.marcus@gmail.com&gt;
" Last Change: 2011 Mar 23

" Based on pyunit.vim distributed with vim
" Compiler:CompilerUnit testing tool for Python
" Maintainer:MaintainerMax Ischenko &lt;mfi@ukr.net&gt;
" Last Change: 2004 Mar 27

if exists("current_compiler")
  "finish
endif
let current_compiler = "nose"

" Modified from pyunit, remove other lines from quickfix window
CompilerSet efm=%-C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m,%-G%.%#
"CompilerSet errorformat=%f:%l:\ fail:\ %m,%f:%l:\ error:\ %m


" Set nose as default compiler
" for :Make
CompilerSet makeprg=source\ ~/ac/MIS/.ENV/bin/activate;REUSE_DB=1\ ~/ac/MIS/misweb/manage.py\ test\ -s\ -m'((?:^\\|[_.-])(:?[tT]est[s]?\\|When\\|should))'\ --with-fixture-bundling\ $*
"CompilerSet makeprg=REUSE_DB=1\ ~/ac/MIS/misweb/manage.py\ test\ -s\ -m'((?:^\\|[_.-])(:?[tT]est[s]?\\|When\\|should))'\ --with-machineout\ --with-fixture-bundling\ $*
"--debug=nose.selector&&\ read
" for :make
"CompilerSet makeprg=REUSE_DB=1\ ~/ac/MIS/misweb/manage.py\ test\ -s\ -m'((?:^\\\|[_.-])(:?[tT]est[s]?\\\|When\\\|should))'\

