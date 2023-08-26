call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'gruvbox-community/gruvbox'
Plug 'airblade/vim-gitgutter'
if has('nvim')
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
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }
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

" Colors
syntax enable
set t_Co=256
set background=dark
colorscheme gruvbox
"colorscheme NeoSolarized
" always leave the diagnostics gutter open
set signcolumn=yes
highlight signcolumn none

" Syntastic settings
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" cscope settings
let g:cscope_silent = 1

" autocomplete
let g:deoplete#enable_at_startup = 1

" IndentLines settings
let g:indentLine_enabled = 1

" Airline settings
let g:airline_powerline_fonts = 1

if has('nvim')
" LSP and CMP
  luafile ~/.config/nvim/cmp_config.lua
  luafile ~/.config/nvim/ts_config.lua
  "luafile ~/.config/nvim/solarized_config.lua
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
map <tab> :NERDTreeToggle<cr>
map <leader>T :TagbarOpenAutoClose<cr>
map <C-n> :tabnext<cr>
map <C-p> :tabprev<cr>
map <leader>s :mks!<cr>
map <leader>I :IndentLinesToggle<cr>
map <leader>F :copen<CR>
map <leader>f :cclose<CR>

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
"let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
let NERDTreeQuitOnOpen=0

" Make the debugger not suck
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }
