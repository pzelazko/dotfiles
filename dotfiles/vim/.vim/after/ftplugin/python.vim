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

" pymode_rope regenerate hang issue fix
" taken form https://github.com/python-mode/python-mode/issues/525#issuecomment-305157834
python3 << EOF
import vim
import git
def is_git_repo():
    try:
        _ = git.Repo('.', search_parent_directories=True).git_dir
        return "1"
    except:
        return "0"
vim.command("let g:pymode_rope = " + is_git_repo())
EOF
