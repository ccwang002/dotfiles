" vim: foldlevel=0 foldmethod=marker sts=4 sw=4 smarttab et ai textwidth=0

" use ',' instead of '\' as <Leader>
let mapleader = ','
let maplocalleader = ','

" Editing {{{
set hidden                      " hide buffer insted of closing to preserve undo history
set switchbuf=useopen           " use opend buffer insted of create new buffer
set autoread                    " auto read change out of vim
set listchars=tab:»\ ,trail:·   " show hidden symbols
set list                        " show problematic characters
nnoremap <leader>. :set invlist<CR>

" Turn backup off, since most stuff is in version control anyway
set nowritebackup
set nobackup
set noswapfile

" Ignore general compilation artifacts and CVS internal folders
set wildignore+=*~,*.pyc,.git\*,.hg\*,.svn\*

" Encoding
set encoding=utf8       " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac    " Use Unix as the standard file type

" Shortkey to toggle and untoggle paste mode (stop auto-indentation)
nnoremap <leader>pp :set invpaste<CR>

" Redo global syntax highlighting
nnoremap <c-s> :syntax sync fromstart<cr>

" }}}

" Navigation {{{
" Make easier movement between display lines
nnoremap j      gj
nnoremap <Down> g<Down>
nnoremap k      gk
nnoremap <Up>   g<Up>

" Restore the original function of , and <Tab>
nnoremap <Leader>, ,
nnoremap <Leader><Tab> <Tab>

" Select till a end of a line
vnoremap v $h

" Navigation between panels
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Searching {{{
set ignorecase          " Ignore case when searching
set smartcase           " When searching try to be smart about cases
set hlsearch            " Highlight search results
set incsearch           " Makes search act like search in modern browsers
set lazyredraw          " Don't redraw while executing macros (good performance config)
set magic               " For regular expressions turn magic on
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" remove highlight with pressing ESC twice or <leader><cr>
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nmap <silent> <Leader><cr> :noh<cr>

" }}}

" Tab and indent {{{
set expandtab           " Use spaces instead of tabs
set smarttab            " Be smart when using tabs ;)
set shiftwidth=4        " 1 tab == 4 spaces
set tabstop=4
set autoindent          " Auto indent
set smartindent         " Smart indent
set copyindent
" }}}

" Folding {{{
" Fold a HTML tag
nnoremap <leader>zt zfat
" }}}

" Spell checking {{{
" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=
" }}}

" User Interface {{{
set ruler               " always show current position
set number              " show line number
set laststatus=2        " always display statusline
set mouse=a             " use mouse for navigation
set scrolloff=0         " minimum line above/below the cursor
set tm=500              " Time (ms) to wait for a mapping sequence to complete

set linebreak
let &showbreak = '+++ '
set breakat=\ ;:,!?
set display=lastline            " always show part of the long line
set cpoptions+=n                " use linenumber column for wrapping
set report=0                    " report for number of lines being changed everytime
set wrap                        " turn up wrapping
set whichwrap+=<,>,[,],b,s,~
set textwidth=0                 " never add a newline for some number of chars
set formatoptions+=j            " make joining comments easier
set formatexpr=autofmt#japanese#formatexpr()

set showmatch                   " Show matching brackets when text indicator is over them
set matchpairs& matchpairs+=<:> " add <>
set matchtime=2                 " How many tenths of a second to blink when matching brackets

" No annoying sound on errors
set noerrorbells
set visualbell

" Turn on wild menu
set wildmenu
set wildmode=longest:full
set wildoptions=tagfile
" }}}

" A custom function to trim trailing white spaces {{{
func DeleteTrailingWhiteSpace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
nnoremap <leader>dw :call DeleteTrailingWhiteSpace()<CR>
" }}}

" Neovim specific settings
" Install python dependencies by creating a venv:
"
"     cd ~/.local/share/nvim
"     python3 -m venv pyvenv
"     . pyvenv/bin/activate.fish
"     pip install pynvim neovim
" {{{
let g:loaded_python_provider = 1  " Disable Python 2 support
let g:python3_host_prog = "~/.local/share/nvim/pyvenv/bin/python3"
set guicursor=a:block
" }}}

" Plugins managed by vim-plug
" After installing vim-plug, run :PlugInstall or :PlugUpdate
" to install or update the plugins
"
" Then run :UpdateRemotePlugins to link the external plugins
" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" Color theme
Plug 'michalbachowski/vim-wombat256mod'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'powerlineish'

" Denite.nvim (former Unite.vim)
" {{{
Plug 'Shougo/denite.nvim', {
            \ 'on': ['Denite', 'DeniteBufferDir'],
            \ 'do': ':UpdateRemotePlugins'
            \}
nnoremap [denite] <Nop>
nmap U [denite]
nmap <Leader>u [denite]
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir file_rec directory_rec<CR>
nnoremap <silent> [denite]g :<C-u>DeniteBufferDir grep<CR>
nnoremap <silent> [denite]j :<C-u>Denite jump<CR>
nnoremap <silent> [denite]k :<C-u>Denite command<CR>
nnoremap <silent> [denite]m :<C-u>Denite file_mru directory_mru<CR>
nnoremap <silent> [denite]o :<C-u>Denite outline<CR>

autocmd User denite.nvim call s:denite_settings()
function! s:denite_settings()
    " Because the denite input prompt is at the bottom
    " See https://github.com/Shougo/denite.nvim/issues/179
    " call denite#custom#option('default', 'direction', 'topleft')
    call denite#custom#map(
                \ 'insert', '<Down>',
                \ '<denite:move_to_next_line>', 'noremap'
                \)
    call denite#custom#map(
                \ 'insert', '<Up>',
                \ '<denite:move_to_previous_line>', 'noremap'
                \)
    " Use ripgrep to grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endfunction
" }}}

" Recently accessed files/directories
" Enable the file_mru and directory_mru sources in denite.nvim to record the
" neomru.vim {{{
Plug 'Shougo/neomru.vim'
" To track long mru history (number of files/directories).
let g:neomru#file_mru_limit = 3000
let g:neomru#directory_mru_limit = 3000
" Time to update MRU list (now for evey half minute)
let g:neomru#update_interval = 30
" }}}

" Language specific syntax highlighting {{{
" A bundle of language packs
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['css', 'tex', 'plaintex', 'latex', 'python']
let g:vim_markdown_conceal = 0   " Disable markdown conceal

" CSS3 syntax
Plug 'hail2u/vim-css3-syntax', {'for': ['css'] }

" Render colors in CSS
Plug 'ap/vim-css-color', {
    \ 'for': [
    \       'html', 'djangohtml',
    \       'css', 'stylus', 'less', 'scss',
    \       'javascript', 'coffee', 'coffeescript'
    \ ] }

" HTML shorcut expansion
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }

" Python {{{
" Syntax
Plug 'vim-python/python-syntax', {'for': ['python', 'pyrex']}
let g:python_highlight_builtin_objs = 1
let g:python_highlight_builtin_funcs = 1
let g:python_highlight_exceptions = 1
let g:python_highlight_string_formatting = 1
let g:python_highlight_string_format = 1
let g:python_highlight_string_templates = 1
" Indentation
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python', 'pyrex']}
" }}}

" Snakemake
Plug 'ccwang002/vim-snakemake'
" }}}

" File explorer (defx.nvim; replacing vimfiler.vim) {{{
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
nnoremap <Leader>f :Defx -toggle <CR>
nnoremap <Leader>b :Defx -toggle -direction=topleft -split=vertical -winwidth=50<CR>
" Change current folder (pwd) to the folder of the current file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <BS>
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
" }}}

" Editing support {{{
" Completion
" deoplete.nvim {{{
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
let g:deoplete#enable_smart_case = 1   " Use smartcase.

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction
" }}}

" Better text wrapping for asian wide characters
Plug 'vim-jp/autofmt'

" Configure gneral FileType setting by EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Align multiple rows
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign', 'LiveEasyAlign'] }

call plug#end() " Initialize plugin system
" }}}
" }}}

" Set the color theme
colorscheme wombat256mod
