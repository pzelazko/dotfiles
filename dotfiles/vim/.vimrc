" #############################################################
" Vundle plugins
" #############################################################

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jremmen/vim-ripgrep'
Plug 'majutsushi/tagbar'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go'
Plug 'python-mode/python-mode', { 'do': 'pip3 install GitPython' }
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'ryanoasis/vim-devicons'
if has("unix" ) && !has("win32unix")
    "" YCM on cygwin introduce delay and clang is not working
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
    "Use for generating config for YouCompleteMe when cmake
    "compile_commands.json file is not available
    "Plug 'rdnetto/YCM-Generator.git'
endif

" Initialize plugin system
call plug#end()

" #############################################################
" Settings
" #############################################################

syntax on
filetype indent on
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set number
set relativenumber
set encoding=utf-8
set hlsearch " search highlighting
set ignorecase
set smartcase " use case if any caps used
set hidden
set showcmd
set noswapfile
set pastetoggle=<F9>
set cursorline
set list listchars=tab:»·,trail:· " show extra space characters
set clipboard=unnamed " use the system clipboard
set nostartofline " avoid jumping to the start of line
set history=200 " default command line history length is only 20
set shell=bash
set autoread
set ttymouse=xterm2
set noerrorbells visualbell t_vb= " disable beep and flash with autocmd
autocmd GUIEnter * set vb t_vb=
set wildignore+=*/.git/*,*/tmp/*,*.swp,cscope.out,tags
set nofixendofline " don't add new line at the end automatically


" #############################################################
" Mappings
"   Plugins Mappings are in "Plugin settings" section
" #############################################################

let mapleader = ","

nnoremap <leader>c :nohl<CR>

imap jj <ESC>

" close buffer without closing split
nnoremap <C-c> :bp\|bd # <CR>

" save all buffers and run Make without going to first error
noremap <F5> <ESC>:wa<CR>:Make <CR>
inoremap <F5> <ESC>:wa<CR>:Make <CR>
noremap <leader>co :wa<CR>:Make <CR>

" toggle spell check with <F12>
map <F12> :setlocal spell! spelllang=en_us<CR>
imap <F12> <ESC>:setlocal spell! spelllang=en_us<CR>

map <C-n> :call NumberToggle()<CR>
map <leader>n :call RenameFile()<CR>
map <F8> :call ToggleMouse()<CR>
map <F7> :call ToggleBackground()<CR>

" print full current file path
nnoremap <Leader>i :echo @%<CR>
" write file
nnoremap <leader>w :w<CR>

" backspace goes to previous buffer
nnoremap <BS> <C-^>

map <C-p> :Files<cr>
map <leader>m :FZFMru<cr>

" #############################################################
" Functions
" #############################################################

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

" rename current file, via Gary Bernhardt
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" mouse toggle
function! ToggleMouse()
    if &mouse == 'a' " check if mouse is enabled
        set mouse= " disable mouse
        echo "mouse disabled"
    else " enable mouse everywhere
        set mouse=a
        echo "mouse enabled"
    endif
endfunc

" background toggle
function! ToggleBackground()
    if &background == 'light'
        set background=dark
    else
        set background=light
    endif
    AirlineTheme solarized
endfunc


" #############################################################
" Colorscheme
" #############################################################

set t_Co=16 "16 for solarized palette, 256 for others
set background=light " solarized theme - dark/light
" setting for cygwin without mintty-colors-solarized ~\.minttyrc setting
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1 " set this when background is dark
let g:solarized_contrast="high"
if filereadable($HOME . "/.vim/plugged/vim-colors-solarized/colors/solarized.vim")
    colorscheme solarized
endif


" #############################################################
" Plugins settings
" #############################################################

" vim-airline
set laststatus=2 " status bar enabled when one file is opened
set ttimeoutlen=50
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod=':t' " show just the filename
let g:airline#extensions#tmuxline#enabled = 1 " let the tmuxline plugin work
let g:airline#extensions#hunks#enabled=1 " enable hunks
let g:airline#extensions#branch#enabled=1 " show branch name
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" NERDTree
" ctrl+n shortcut
map <F2> :NERDTreeToggle<CR>
" close vim when the only window open is NERDTRee
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.pyc$', '\~$']


" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  " Use Rg in CtrlP for listing files
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  " Rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  " bind K to grep word under cursor
  nnoremap K :Rg "<C-R><C-W>"
  " bind \ (backward slash) to grep shortcut
  nnoremap \ :Rg<SPACE>
endif


" ctags and cscope
set nocscopeverbose
set tags=./tags,tags,.git/tags;
nnoremap <F4> :!ctags --languages=c++ --tag-relative=no --file-scope=no --fields=+l -R -f tags && cscope -R -b<CR>:cs reset<CR><CR>
cscope add cscope.out


" Tagbar
nnoremap <F3> :TagbarToggle<CR>


" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" disable checking by default. Run :SyntasticCheck to run checking
let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetypes": [] }

" indentLine
let g:indentLine_faster = 1
let g:indentLine_indentLevel = 100


" YouCompleteMe
" collect tags from ctags
let g:ycm_collect_identifiers_from_tags_files = 1
" start autocompletion after X characters typed
"let g:ycm_min_num_identifier_candidate_chars = 3
" turn off preview window after completion
let g:ycm_autoclose_preview_window_after_completion = 1
"default config file for c languages
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" speed-up gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0


" go-vim
let g:go_doc_keywordprg_enabled = 0 " disable 'K' mapping


" ultisnips trigger - TAB is reserved for YCM
let g:UltiSnipsExpandTrigger="<c-b>"


" python-mode
let g:pymode_python='python3'
let python_highlight_all=1
let g:pymode_folding=0
let g:pymode_rope_goto_definition_cmd = 'e'
" avoid K mapping overlap
let g:pymode_doc_bind = ''


" fzf
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
