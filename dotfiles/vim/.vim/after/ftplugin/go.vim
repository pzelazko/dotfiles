"no need to highlight whitepaces thanks to Fmt tool
set nolist

nmap <leader>r :wa<CR> <Plug>(go-run)
nmap <leader>b :wa<CR> <Plug>(go-build)
nmap <leader>in :wa<CR> <Plug>(go-install)
nmap <leader>t :wa<CR> <Plug>(go-test)

nmap <Leader>ds <Plug>(go-def-split)
nmap <Leader>dv <Plug>(go-def-vertical)
nmap <Leader>dt <Plug>(go-def-tab)

nmap <Leader>gd <Plug>(go-doc)
nmap <Leader>gv <Plug>(go-doc-vertical)
nmap <Leader>gb <Plug>(go-doc-browser)

nmap <Leader>im <Plug>(go-implements)
nmap <Leader>re <Plug>(go-referrers)
nmap <Leader>i <Plug>(go-info)
nmap <Leader>e <Plug>(go-rename)

nmap <Leader>li :wa<CR> :GoMetaLinter<CR>

" :he go-mapping for other <Plug> mappings; create new with :he go-commands

let g:go_doc_keywordprg_enabled = 0 " disable 'K' mapping
let g:go_fmt_fail_silently = 1 " don't show fmt errors
let g:go_fmt_command = "goimports" " use goimports instead of fmt to enable automatic imports

" enable syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
