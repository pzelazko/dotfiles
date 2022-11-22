" #############################################################
" Vundle plugins
" #############################################################

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" general
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

" text edition
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'

" navigation
Plug 'lambdalisue/fern.vim'
"Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'liuchengxu/vista.vim'

" search
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

" auto-completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-json'
  \ ]

" building
Plug 'tpope/vim-dispatch'

" formatting
Plug 'Chiel92/vim-autoformat'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'

" style
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'altercation/vim-colors-solarized'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Python
Plug 'python-mode/python-mode', { 'do': 'pip3 install GitPython' }

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
"set mouse=a


" #############################################################
" Mappings
"   Plugins Mappings are in "Plugin settings" section
" #############################################################

let mapleader = ","

nnoremap <leader>c :nohl<CR>

imap jj <ESC>

" save all buffers and run Make without going to first error
noremap <F5> <ESC>:wa<CR>:Make <CR>
inoremap <F5> <ESC>:wa<CR>:Make <CR>
noremap <leader>co :wa<CR>:Make <CR>

map <F12> :setlocal spell! spelllang=en_us<CR>
imap <F12> <ESC>:setlocal spell! spelllang=en_us<CR>

map <leader>tm :call ToggleMouse()<CR>
map <leader>n :call NumberToggle()<CR>
map <leader>r :call RenameFile()<CR>
map <F7> :call ToggleBackground()<CR>
map <leader>q :call ToggleQuickFix()<CR>

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

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction


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
let g:airline#extensions#branch#enabled=0 " show branch name
let g:airline#extensions#vista#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  " Use Rg in CtrlP for listing files
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  " Rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  " bind K to grep word under cursor
  nnoremap <leader>k :Rg "<C-R><C-W>"
  " bind \ (backward slash) to grep shortcut
  nnoremap \ :Rg<SPACE>
endif


" Fern
let g:fern#renderer = "nerdfont"
nnoremap <leader>e :Fern %:h<CR>
nnoremap <c-n> :Fern %:h -drawer -toggle<CR>
"nnoremap <c-n> :Fern . -reveal=% -drawer -toggle<CR>

" Vista
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
nnoremap <C-t> :Vista!!<CR>
nnoremap <leader>s :Vista finder coc<CR>
let g:vista#renderer#enable_icon = 1

" indentLine
let g:indentLine_fileType = ['typescript', 'javascript', 'json']
let g:indentLine_faster = 1
let g:indentLine_indentLevel = 100
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
nnoremap <leader>l :IndentLinesToggle<CR>


" git
nmap <leader>gb :Git blame<CR>
nmap <leader>gl :Git log -- %<CR>
nmap <leader>gh :0Gclog<CR>

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

" Autoformat
noremap <leader>fo :Autoformat <CR>



" Coc
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
