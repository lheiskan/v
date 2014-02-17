if has('win32') || has('win64')
  " Make windows use ~/.vim too, I don't want to use _vimfiles
  set runtimepath^=~/.vim
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" utf-8 default encoding
set encoding=utf-8

" setup find with tabcompletion
if has('win32') || has('win64')
    set path=.\**
else
    set path=$PWD/**
endif
set wildmode=longest,list,full
set wildmenu

"  gui options  (no toolbar, autoselect on)
set go-=T
set go+=a

syntax on
"set background=light
"set background=dark

" backup and swap files
set nobackup
set nowritebackup
set noswapfile

" wait 0,5 sec for mappings to finish 
set timeoutlen=500

" save modifed buffer, when changing
" set autowriteall
" set hidden on

" non-us keyboard
let mapleader=","
let maplocalleader="-"

" enable loading plugin specific filetypes
filetype indent plugin on

" global indentation options
set tabstop=4    
set softtabstop=4    
set shiftwidth=4 
set expandtab      
set autoindent
set textwidth=79
set shiftround

set nohlsearch 
set incsearch
set matchtime=2


" HTML  ----{{{
augroup html
    autocmd!
    autocmd FileType html setlocal sw=2
    autocmd FileType html setlocal ts=2
    autocmd FileType html setlocal sts=2
    autocmd FileType html setlocal textwidth=0
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html iabbrev <buffer> l" &ldquo;
    autocmd FileType html iabbrev <buffer> &ldquo; NONONONONOONO
    autocmd FileType html iabbrev <buffer> --- &mdash;
    autocmd FileType html nnoremap <buffer> <leader>f Vatzf
    autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
augroup END
"}}}

" XHTML  ----{{{
augroup xhtml
    autocmd!
    autocmd FileType xhtml setlocal sw=2
    autocmd FileType xhtml setlocal ts=2
    autocmd FileType xhtml setlocal sts=2
    autocmd FileType xhtml setlocal textwidth=0
    autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
augroup END
"}}}

" CSS  ----{{{
augroup css
autocmd!
autocmd FileType css setlocal sw=2
autocmd FileType css setlocal ts=2
autocmd FileType css setlocal sts=2
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
augroup END
"}}}

" Python ----{{{
augroup python
autocmd!
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python nnoremap <localleader>c I#
autocmd FileType python nnoremap <localleader>w :execute "match Error " . '/\s\+$/'<cr>    " highlight trailing whitespace
autocmd FileType python nnoremap <localleader>W :match none<cr>
autocmd FileType python iabbrev <buffer> iff if:<left>
autocmd FileType python onoremap <buffer> p i(
autocmd FileType python onoremap <buffer> b /return<cr>
autocmd FileType python onoremap <buffer> in( :<c-u>normal! f(vi(<cr>
autocmd FileType python onoremap <buffer> il( :<c-u>normal! F(vi(<cr>
autocmd FileType python onoremap <buffer> in{ :<c-u>normal! f{vi{<cr>
autocmd FileType python onoremap <buffer> il{ :<c-u>normal! F{vi{<cr>
autocmd FileType python onoremap <buffer> in@ :<c-u>normal! /.*@.*vW<cr>
augroup END
"}}}

" Javascript ----{{{
augroup javascript
autocmd!
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript nnoremap <localleader>c I//
autocmd FileType javascript iabbrev <buffer> iff if(){}<left><left><left>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
augroup end
"}}}
    
" Coffeescript  ----{{{
augroup coffee
autocmd!
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType coffee setlocal foldmethod=indent nofoldenable
autocmd FileType coffee nnoremap <localleader>c I//
autocmd FileType coffee noremap <buffer>  <c-f> :call JsBeautify()<cr>
augroup end
"}}}



" Vimscript -----------------{{{
augroup vim
    autocmd!
    autocmd FileType vim nnoremap <localleader>c I"
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup end
" }}}

" Markdown ----{{{
augroup markdown
autocmd!
autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^\[=,-\][=,-]\\+\r:nohlsearch\rg_k0"<cr>
augroup end
" }}}
    
" jk exits insert/visual/command modes, writes the file after insert
" inoremap jk <esc>:w<cr>
" cnoremap jk <c-c> " kj exits insert mode without writing the file 

nnoremap <silent> <Leader>p :NERDTreeToggle<CR>

" arrow keys switch buffers
nnoremap <Right> :bn<Enter>
nnoremap <Left> :bp<Enter>

" space toggles folds
nnoremap <space> za

" statusline
set ruler
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" quick edit .vimrc
nnoremap <leader>ev :vsplit $VIM/.vimrc<CR>
nnoremap <leader>sv :source $VIM/.vimrc<CR>
nnoremap <leader>ep :execute "rightbelow vsplit ". bufname("#")<CR>

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

let OS='windows'
if OS=='osx'
    nnoremap <silent><D-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent><D-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
else
    nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
en

" enable line numbering
" set number
set relativenumber

" move lines up and down with +/-
nnoremap ,+ ddkP
nnoremap ,- ddp

" upcase current word in insert/normal mode
" inoremap <c-u> <esc>viwUi
" nnoremap <c-u> viwU

" typos and other abbreviations ----{{{
iabbrev adn and
iabbrev tehn then
iabbrev autocnd autocmd
"}}}

" wrap current word /selection in ",'
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>' x<esc>i' '<esc>hvpgv
vnoremap <leader>" x<esc>i" "<esc>hvpgv

" . in Visual selection, applies the previous command to selection
vnoremap . :norm.<CR>

" H to begining of line
" nnoremap H 0
" L to end of line
" nnoremap L $
" inoremap <esc> <nop>

" common miss spellings
iabbrev iabbrew iabbrev
iabbrev autocomd autocmd

" add ; to the end of current line, maintain cursor position
nnoremap <leader>a :execute "normal! mqA;\e'q"<cr>
" ??
" nnoremap <leader>a :execute "normal! mqA;\\<esc>'q"<cr>

" 'verymagic' for search
nnoremap / /\v
nnoremap ? ?\v

" toggle hlsearch and incsearch
nnoremap <leader>H :set hlsearch! hlsearch?<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>i :set incsearch! incsearch?<cr>

" delete buffer
nnoremap <leader>d :bd<cr>
nnoremap <leader>D :bd!<cr>

" quick write
nnoremap <leader>w :write<cr>
nnoremap <leader>W :write!<cr>

" quick only
nnoremap <leader>o :only<cr>
nnoremap <leader>O :only!<cr>

" window navigation
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

" quicfix window navigation
nnoremap <leader>n :cnext<cr>
nnoremap <leader>P :cprevious!<cr>
nnoremap <leader>N :cnext!<cr>
nnoremap <leader>p :cprevious<cr>

" grep shortcut
" nnoremap <leader>g :execute "grep! -R " . shellescape("<cword>") . " ."<cr>:copen<cr>

" quick access to bufferlist
nnoremap <leader>b :buffers<cr>

" change between dark and light color schemes
function! ToggleBackground()
    if (w:solarized_style=="dark")
     let w:solarized_style="light"
     colorscheme solarized
 else
     let w:solarized_style="dark"
     colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()
nnoremap <F5> :call ToggleBackground()<CR>
inoremap <F5> <ESC>:call ToggleBackground()<CR>a
vnoremap <F5> <ESC>:call ToggleBackground()<CR>

" copy current file parent path unnamed register  (paste with p)
:nnoremap <leader>cp :let @"=expand('%:p:h')<cr>
" copy current file parent path to system clipboard
:nnoremap <leader>CP :let @*=expand('%:p:h')<cr>
" copy current file full path to unnamed register  (paste with p)
:nnoremap <leader>cf :let @"=expand('%:p')<cr>
" copy current file full path to system clipboard
:nnoremap <leader>CF :let @*=expand('%:p')<cr>

" quick change working directory to current files director
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" UltiSnips configurations
" let g:UltiSnipsJumpForwardTrigger="<tab>"


