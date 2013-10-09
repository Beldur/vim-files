" VIM Config
set nocompatible

execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin indent on

set bg=dark

colorscheme mustang
highlight clear SignColumn

set t_Co=256
set showmode
set nowrap
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set showmatch
set ignorecase
set smartcase
set smarttab
set scrolloff=4
set hlsearch
set mouse=a
set nobackup
set encoding=utf-8
set ttyfast                       " Assume fast terminal connection

"set cursorline
set title
set showcmd

set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Statusline
set laststatus=2 " Always show the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l%h " Format the status line
set statusline+=%=%{fugitive#statusline()}

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" autocmd Filetype go compiler golang
let g:golang_goroot = "/home/alex/local/go"

" Trick to enable ALT key
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>

map <A-n> :lnext<CR>
map <A-p> :lprevious<CR>

" Move a line of text using ALT+[jk]
nmap <A-j> mz:m+<cr>`z
nmap <A-k> mz:m-2<cr>`z
vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" smash escape
inoremap jk <esc>
inoremap kj <esc>

" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" Syntastic Settings
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

" Startify Settings
let g:startify_session_dir = '~/.vim/.cache/sessions'
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
let g:startify_custom_header = map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

" Unite Settings
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

nmap <space> [unite]
nnoremap [unite] <Nop>

nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    nmap <buffer> <ESC>      <Plug>(unite_exit)
endfunction"}}}
