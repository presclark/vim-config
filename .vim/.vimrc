"------------------------------------------------------------------------------
" File: $HOME/.vimrc
" Author: Uwe Hermann <uwe@hermann-uwe.de>
" URL: http://www.hermann-uwe.de/files/vimrc
" $Id: .vimrc 331 2005-09-07 21:09:32Z uh1763 $
"------------------------------------------------------------------------------

version 6.3

execute pathogen#infect()


"------------------------------------------------------------------------------
" Standard stuff.
"------------------------------------------------------------------------------
set nocompatible        " disable vi compatibility.
set nobackup            " do not keep a backup file.
set history=100         " Number of lines of command line history.
set undolevels=200      " Number of undo levels.
set textwidth=0         " Don't wrap words by default.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set ignorecase          " Case insensitive matching.
set incsearch           " Incremental search.
set autoindent
set nowrap
"set nocindent           " I indent my code myself.
set scrolloff=5         " Keep a context when scrolling.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set tabstop=4           " Number of spaces <tab> counts for.
set shiftwidth=4
set noexpandtab
set ttyscroll=5         " Turn off scrolling (this is faster).
set ttyfast             " We have a fast terminal connection.
set hlsearch            " Highlight search matches.
set autowrite           " Automatically save before :next, :make etc.

set nostartofline       " Do not jump to first character with page commands,
                        " i.e., keep the cursor in the current column.
set viminfo='20,\"50    " Read/write a .viminfo file, don't store more than
                        " 50 lines of registers.

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set lz " Do not redraw when running macros... lazy redraw
  
"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c
set laststatus=2

"Turn backup off
set nobackup
set nowb
set noswapfile

" Tell vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:>-,trail:·,eol:$

" Path/file expansion in colon-mode.
set wildmode=list:longest
"set wildignore=*.o,obj,*.exe,*.pyc,*.swp,*.zip,*.dll,concrete*
set wildignore=*.o,obj,*.exe,*.pyc,*.swp,*.zip,*.dll
set wildchar=<TAB>

" Enable syntax-highlighting.
syntax enable
"set gfn=Consolas
set gfn=Consolas:h8

let g:filetype_asp = "javascript"

if has("gui_running")
  "colorscheme fu
  set background=dark
  colorscheme solarized
  au GUIEnter * simalt ~x

  "set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=L  "remove left-hand scroll bar
else
  set t_Co=256
  set background=dark
  colorscheme solarized
endif

"Highlight current
if has("gui_running")
  set cursorline
  "hi cursorline guibg=#333333
  "hi CursorColumn guibg=#333333
endif

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

"------------------------------------------------------------------------------
" Function keys.
"------------------------------------------------------------------------------

map <F10> <Esc>:setlocal spell spelllang=en_us<CR>
"map <F11> <Esc>:setlocal nospell<CR>
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar


""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

   """"""""""""""""""""""""""""""
   " Minibuffer
   """"""""""""""""""""""""""""""
   let g:miniBufExplModSelTarget = 1
   let g:miniBufExplorerMoreThanOne = 2
   let g:miniBufExplModSelTarget = 0
   let g:miniBufExplUseSingleClick = 1
   let g:miniBufExplMapWindowNavVim = 1
   let g:miniBufExplVSplit = 25
   let g:miniBufExplSplitBelow=1

   let g:bufExplorerSortBy = "name"

   autocmd BufRead,BufNew :call UMiniBufExplorer

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''
map <F12> <esc>:NERDTreeToggle<cr>
map <S-F12> <esc>:Bufferlist<cr>
map <Leader>t <esc>:CtrlP<cr>
let g:ctrlp_root_markers = ['.ctrlp', '.git', '.root']

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.git|.hg|.svn|bin|obj)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }


"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>


"------------------------------------------------------------------------------
" Correct typos.
"------------------------------------------------------------------------------

" English.
iab beacuse    because
iab becuase    because
iab acn        can
iab cna        can
iab centre     center
iab chnage     change
iab chnages    changes
iab chnaged    changed
iab chnagelog  changelog
iab Chnage     Change
iab Chnages    Changes
iab ChnageLog  ChangeLog
iab debain     debian
iab Debain     Debian
iab defualt    default
iab Defualt    Default
iab differnt   different
iab diffrent   different
iab emial      email
iab Emial      Email
iab figth      fight
iab figther    fighter
iab fro        for
iab fucntion   function
iab ahve       have
iab homepgae   homepage
iab logifle    logfile
iab lokk       look
iab lokking    looking
iab mial       mail
iab Mial       Mail
iab miantainer maintainer
iab amke       make
iab mroe       more
iab nwe        new
iab recieve    receive
iab recieved   received
iab erturn     return
iab retrun     return
iab retunr     return
iab seperate   separate
iab shoudl     should
iab soem       some
iab taht       that
iab thta       that
iab teh        the
iab tehy       they
iab truely     truly
iab waht       what
iab wiht       with
iab whic       which
iab whihc      which
iab yuo        you
iab databse    database
iab versnio    version
iab obnsolete  obsolete
iab flase      false
iab recrusive  recursive
iab Recrusive  Recursive

" Days of week.
iab monday     Monday
iab tuesday    Tuesday
iab wednesday  Wednesday
iab thursday   Thursday
iab friday     Friday
iab saturday   Saturday
iab sunday     Sunday

" Enable this if you mistype :w as :W or :q as :Q.
" nmap :W :w
" nmap :Q :q
nmap ;s :source ~/.vimrc<CR>
nmap ;e :edit ~/.vimrc<CR>

nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>


"------------------------------------------------------------------------------
" Abbreviations.
"------------------------------------------------------------------------------

" My name + email address.
ab rpc Robert Preston Clark <pres.clark@gmail.com>

"------------------------------------------------------------------------------
" HTML.
"------------------------------------------------------------------------------

" Print an empty <a> tag.
map! ;h <a href=""></a><ESC>5hi

" Wrap an <a> tag around the URL under the cursor.
map ;H lBi<a href="<ESC>Ea"></a><ESC>3hi
imap ;c {#  #}<ESC>2hi
imap ;d {{  }}<ESC>2hi
imap ;t {%  %}<ESC>2hi

nmap ,s <esc>:update<cr>
imap ,s <esc>:update<cr>
vmap ,s <esc>:update<cr>
nmap ;v <esc>:update<cr><esc>\ll<cr>\lv<cr>
imap ;v <esc>:update<cr><esc>\ll<cr>\lv<cr>

vmap <Leader>w <Esc>:call TagWrap()<CR>
function! TagWrap()
  let tag = input("Tag to wrap block: ")
  if len(tag) > 0
    normal `>
    if &selection == 'exclusive'
      exe "normal i</".tag.">"
    else
      exe "normal a</".tag.">"
    endif
    normal `<
    exe "normal i<".tag.">"
    normal `<
  endif
endfunction

vmap <Leader>p <Esc>:call PWrap()<CR>
function! PWrap()
    normal `>
    if &selection == 'exclusive'
      exe "normal i</p>"
    else
      exe "normal a</p>"
    endif
    normal `<
    exe "normal i<p>"
    normal `<
endfunction

vmap <Leader>l <Esc>:call LiWrap()<CR>
function! LiWrap()
	exe "'<,'>s!.*!<li>&</li> "
endfunction

"------------------------------------------------------------------------------
" LaTeX.
"------------------------------------------------------------------------------
" Force an empty tex file to have latex highlighting
let g:tex_flavor='latex'

"------------------------------------------------------------------------------
" Miscellaneous stuff.
"------------------------------------------------------------------------------

" ROT13 decode/encode the selected text (visual mode).
" Alternative: 'unmap g' and then use 'g?'.
vmap rot :!tr A-Za-z N-ZA-Mn-za-m<CR>

" Make p in visual mode replace the selected text with the "" register.
	vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
	vnoremap < <gv
	vnoremap > >gv

"------------------------------------------------------------------------------
" File-type specific settings.
"------------------------------------------------------------------------------
function! CHANGE_CURR_DIR()
exec "cd %:p:h" 
endfunction


if has("autocmd")

  " Enabled file type detection and file-type specific plugins.
  " filetype plugin on indent
  filetype plugin on

  autocmd VimEnter * set vb t_vb=

  autocmd BufEnter * call CHANGE_CURR_DIR() 

  " Python code.
  augroup python
    autocmd FileType,BufReadPre,FileReadPre      *.py set tabstop=4 |
    	\ set shiftwidth=4 | 
	\ set smarttab | 
	\ set expandtab | 
	\ set softtabstop=4 | 
	\ set autoindent |
	\ highlight overflow ctermbg=240 |
	\ exec 'match overflow /\%>80v.\+/' |
	\ source ~/.vim/scripts/python.vim

  augroup END

  " Ruby code.
  augroup ruby
    autocmd BufReadPre,FileReadPre      *.rb set tabstop=4
    autocmd BufReadPre,FileReadPre      *.rb set expandtab
  augroup END

  " PHP code.
  augroup php
    autocmd BufReadPre,FileReadPre      *.php set tabstop=4 |
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set softtabstop=4 |
    \ set noexpandtab
  augroup END

  " Java code.
  augroup java
    autocmd BufReadPre,FileReadPre      *.java set makeprg=javac\ % |
	 \ set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%# |
	 \ noremap <F9> :w<CR>:make<CR>:cwindow<CR> |
    \ noremap <F8> :!java %:t:r<CR>

  augroup END

  " ANT build.xml files.
  augroup xml
    autocmd BufReadPre,FileReadPre      *.xml,*.xsd,*.config set tabstop=2 |
	\ set expandtab |
	\ set softtabstop=2 |
	\ set shiftwidth=2
  augroup END

  " (J)Flex files.
  augroup lex
    " autocmd BufRead,BufNewFile          *.flex,*.jflex set filetype=lex
    autocmd BufRead,BufNewFile          *.flex,*.jflex set filetype=jflex
  augroup END 

  " Less(CSS) Code
  augroup less
    autocmd BufReadPre,FileReadPre      *.less set filetype=css
  augroup END

  " cshtml Code
  augroup cshtml
    autocmd BufReadPre,FileReadPre      *.cshtml set filetype=html |
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set softtabstop=4 |
    \ set noexpandtab
  augroup END

  augroup javascript
    autocmd BufReadPre,FileReadPre      *.json set filetype=javascript
  augroup END
  	

endif


