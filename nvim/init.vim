call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'airblade/vim-gitgutter'
if has('nvim')
  Plug 'f-person/git-blame.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'folke/tokyonight.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
endif
call plug#end()

" Spacing and general vim settings
set ts=2
set sw=2
set et
set cindent
set belloff=all
set number
set guicursor=n-v-c-i:block

" Make autocompletion work like an IDE
set completeopt=longest,menuone

set wildmenu " Show completions in status.
set modeline
set rnu

" Colors
syntax enable
set t_Co=256
set background=dark
colorscheme tokyonight-moon

" always leave the diagnostics gutter open
set signcolumn=yes
highlight signcolumn none

" cscope settings
let g:cscope_silent = 1

" Airline settings
let g:airline_powerline_fonts = 1

if has('nvim')
" LSP and CMP
  luafile ~/.config/nvim/random.lua
  luafile ~/.config/nvim/cmp_config.lua
  luafile ~/.config/nvim/ts_config.lua
  luafile ~/.config/nvim/telescope_config.lua
  luafile ~/.config/nvim/lsp_config.lua
  luafile ~/.config/nvim/bufferline.lua
endif

" vim-go
filetype plugin indent on

set autowrite

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

"au filetype go inoremap <buffer> . .<C-x><C-o>

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: bfor building, rfor running and bfor running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" Mappings
map <tab> :NERDTreeFind<cr>
map <leader><tab> :NERDTreeToggle<cr>
map <C-n> :bnext<cr>
map <C-p> :bprev<cr>
map <leader>s :mks!<cr>
map <leader>I :IndentLinesToggle<cr>
map <leader>F :copen<CR>
map <leader>f :cclose<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Revert yank behavior back to regular vim
nnoremap Y Y

" Clean up whitespace (https://idie.ru/posts/vim-modern-cpp#removing-trailing-whitespaces)
highlight ExtraWhitespace ctermbg=white guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Continue where you left off.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" NERDTree config
let NERDTreeQuitOnOpen=0

" Make the debugger not suck
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }

let g:go_term_enabled = 1
let g:go_term_mode = "silent keepalt rightbelow 15 split"
let g:go_def_reuse_buffer = 1

" https://www.reddit.com/r/neovim/comments/f0qx2y/automatically_reload_file_if_contents_changed/
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
