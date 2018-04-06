" #############################################################
" Vundle plugins
" #############################################################

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible.git'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'
Plugin 'gregsexton/gitv'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go.git'
Plugin 'python-mode/python-mode.git'
Plugin 'Chiel92/vim-autoformat'
Plugin 'tpope/vim-dispatch.git'
if has("unix" ) && !has("win32unix")
    "" YCM on cygwin introduce delay and clang is not working
    Plugin 'Valloric/YouCompleteMe.git'
    "Use for generating config for YouCompleteMe when cmake
    "compile_commands.json file is not available
    "Plugin 'rdnetto/YCM-Generator.git'
endif
 "use when YCM syntax checking isn't enough
"Plugin 'scrooloose/syntastic.git'
 "useful in python
"Plugin 'Yggdroot/indentLine.git'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" #############################################################
" Settings
" #############################################################

syntax on
set cindent
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

" backspace goes to previous buffer
nnoremap <BS> <C-^>

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
if filereadable($HOME . "/.vim/bundle/vim-colors-solarized/colors/solarized.vim")
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
" unicode symbols - use if no powerline fonts are used
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'


" NERDTree
" ctrl+n shortcut
map <F2> :NERDTreeToggle<CR>
" close vim when the only window open is NERDTRee
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.pyc$', '\~$']


" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :Ag! "\b<C-R><C-W>\b" --ignore tags --ignore cscope.out<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag --ignore tags<SPACE>


" CtrlP
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
            \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0 " not using nearest .(.git|hg|svn) folder as the root
nnoremap <leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>. :CtrlPTag<CR>


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
