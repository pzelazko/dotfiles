" PEP8 compliance
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

"turn off auto folding
"set nofoldenable

"set vim-go like mappings
nmap <Leader>li :wa<CR> :PymodeLint<CR>
nmap <Leader>fi :wa<CR> :PymodeLintAuto<CR>
nmap gd <C-c>g
nmap <Leader>gd <C-c>d
nmap <Leader>re <C-c>f
nmap <Leader>r <C-c>rr
