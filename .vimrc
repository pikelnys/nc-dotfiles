" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" Thanks to Max Cantor's .vimrc File for the folding
" "zo" to open folds, "zc" to close, "zn" to disable.

" {{{ Clear all autocommands

au!

" }}}

syntax on

"Map jj and jk to escape in insert mode
imap jj <ESC>
imap jk <ESC>


" Leader key
let mapleader = "\<Space>"

set hidden
set mouse=a
set encoding=utf-8
set ttyfast
set shiftwidth=2
set nowrap
set autoindent

"Use tabs
" set noexpandtab
"...or grudgingly conform to other people and use spaces
set expandtab
set number
set cursorline
set showmode
"Show buffer number and cursor position in ruler
set ruler 
set rulerformat=%=\:b%n\ %l,%c%V\ %P
"Show entered partial commands in ruler

"Allow more command history
set history=1000
"Improve external command tab completion

"Improve searching
set ignorecase
set smartcase
set hlsearch
set incsearch

"Improve scrolling and cursor movement
set scrolloff=3
set backspace=indent,eol,start 
set whichwrap=b,s,h,l,<,>,[,]
nnoremap <C-e> 3<C-e> 
nnoremap <C-y> 3<C-y> 

"Improve split behavior
set splitbelow
set splitright

"line number stuff
set number relativenumber
nnoremap <leader>n :set relativenumber!<CR>

" The colorscheme
" colorscheme coffee
" colorscheme molokai
"Reset colorscheme after a configuration reload to prevent weirdness

func! MatteScreen()
  silent! colorscheme solarized
  set background=dark
  let g:matteScreen=1
endfunc

func! GlossyScreen()
  set background=light
  try
    silent! colorscheme macvim
    highlight Normal guibg=#dfdfdf
    highlight StatusLineNC guibg=DarkSlateGray guifg=Gray70
  catch
  endtry
  let g:matteScreen=0
endfunc

func! SwitchScreenType()
  if g:matteScreen
    call GlossyScreen()
  else
    call MatteScreen()
  end
endfunc

if exists("g:mattescreen")

  if g:matteScreen
    call MatteScreen()
  else
    call GlossyScreen()
  endif
else
  "Set initial colorscheme based on configured screen type
  call MatteScreen()
  " call GlossyScreen()
endif

" Plugins and Settings {{{

" Run pathogen
execute pathogen#infect()
filetype plugin indent on

" Make sure color is being used
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

" Status Bar {{{

" Airline config
set laststatus=2
let g:Powerline_symbols = 'unicode'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" }}}


" Python IDE {{{

" python-mode
let ropevim_enable_shortcuts = 1
"let g:pymode = 0
let g:pymode_python = 'python3'
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_lint_ignore = ""
"E501,W"

" syntastic
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_pylint_post_args = '--additional-builtins=PUBLIC,public,clientside,executable,PostTxArgs,cvm,Any,Callable,CommitmentId,Decimal,Dict,Fraction,Identifier,ItemsView,KeysView,List,Optional,Set,ChannelName,Timestamp,Transaction,Tuple,Union,ValuesView,WalletId,Schema,Contract,ContractRef'
" flake8 config is located at ~/.config/flake8

" }}}

" }}}

" Basic Settings {{{

" fish has issues so let's use zsh
"set shell=zsh

" Buffers
set hidden
if exists("&undofile")
    set undofile
endif

" Spelling
set dictionary+=/usr/share/dict/words thesaurus+=$HOME/.thesaurus

" Typing behavior
set backspace=indent,eol,start

" Formatting
"set nowrap
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set foldlevelstart=2

" Set 80 character width indicator
set colorcolumn=100
highlight ColorColumn ctermbg=233

" Status line
set statusline=%{fugitive#statusline()}

" Word splitting
set iskeyword+=-

" Netrw (:Ex, :Vex, :Sex, :Tex)
let g:netrw_list_hide= '.*\.swp$,.*\.un\~$,.*\.swo$'

" Fuzzy File Search {{{

set rtp+=/usr/local/opt/fzf

" Ctrl+P
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" }}}

" }}}

" Autocommands {{{

" Auto source this file when saved
au bufwritepost .vimrc source %

" Other
au FileType python let b:python_highlight_all=1

" }}}

" Backups & .vimrc Editing {{{

if has('win32')
    " Windows filesystem
    set directory=$HOME\VimBackups\swaps,$HOME\VimBackups,C:\VimBackups,.
    set backupdir=$HOME\VimBackups\backups,$HOME\VimBackups,C:\VimBackups,.
    if exists("&undodir")
        set undodir=$HOME\VimBackups\undofiles,$HOME\VimBackups,C:\VimBackups,.
    endif
    if has("gui_running")
      set guifont=Inconsolata:h12:cANSI
    endif
else
    " POSIX filesystem
    set directory=$HOME/.backups/swaps,$HOME/.backups,$HOME/tmp,.
    set backupdir=$HOME/.backups/backups,$HOME/.backups,$HOME/tmp,.
    if exists("&undodir")
        set undodir=$HOME/.backups/undofiles,$HOME/.backups,$HOME/tmp,.
    endif
endif

" }}}

" Key Mappings {{{

" Line numbers
nnoremap <leader>l :setlocal number!<CR>

" Paste mode (maintains formatting)
nnoremap <leader>p :set paste!<CR>

" Clear search highlighting
nnoremap \\ :nohlsearch<CR>

nnoremap <C-e> :e#<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" Git
nnoremap <leader>b :Gblame<CR>

" Fuzzy file search
nnoremap <leader>f :Ag<CR>

" File Browser
nnoremap <leader>e :Ex<CR>
nnoremap <leader>s :Sex<CR>
nnoremap <leader>t :Tex<CR>
nnoremap <leader>v :Vex<CR>

" Tab/Space normalization
"nnoremap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
"nnoremap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
"nnoremap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
"nnoremap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

"opens file buffer with ;
nnoremap ; :CtrlPBuffer<CR>
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>

noremap <silent> <C-j> :call <SID>swap_down()<CR>
noremap <silent> <C-k> :call <SID>swap_up()<CR>

" Python support
nnoremap <Leader>d Oimport pdb; from pprint import pprint; pdb.set_trace() # BREAKPOINT<C-c>

" Insert the current date
nnoremap <F5> "=strftime("%m-%d-%Y")<CR>p
inoremap <F5> <C-R>=strftime("%m-%d-%Y")<CR>

" Editing vimrc
nnoremap <leader>, :tabedit $MYVIMRC<CR>

" Saving the current file
nnoremap <leader>w :w<CR>

" Quitting the current file
nnoremap <leader>q :q<CR>

" }}}

" Custom Functions {{{

" Move a line up or down
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

" }}}
