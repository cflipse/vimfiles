let mapleader=','
runtime! debian.vim
runtime macros/matchit.vim
set nocompatible

" all my terminals are full color....
set t_Co=256


call plug#begin('~/.vim/plugged')
Plug 'kana/vim-textobj-user'

Plug 'tpope/vim-projectionist'

Plug 'direnv/direnv.vim'

" Plug 'tpope/vim-dispatch'
" Plug 'christoomey/vim-tmux-navigator'

Plug 'janko-m/vim-test'
Plug 'skywind3000/asyncrun.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

Plug 'godlygeek/tabular'

" Plug 'majutsushi/tagbar'
" Plug 'ludovicchabant/vim-gutentags'

" GIT
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'


" Ruby
Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-bundler'
" Plug 'tpope/vim-rake', { 'for': ['ruby', 'erb'] }
"Plug 'tpope/vim-rails', { 'for': ['ruby', 'erb'] }
"Plug 'tpope/gem-browse', { 'for': ['ruby', 'erb'] }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby', 'erb'] }

" GOlang
Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-easy-align'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
endif

" Color schemes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

set lcs=tab:»\ ,trail:· list

set foldmethod=syntax
set foldlevelstart=5
set foldminlines=3
set foldnestmax=10
set foldenable
set guioptions-=T

set et sw=2 ts=2 ai
set ruler
set laststatus=2

" set relativenumber
set number
set colorcolumn=80
set autoread

set ic sc
set noshowmatch

set lazyredraw

" search recursively
set path+=**
set wildmenu

set viewdir="~/.vim/view"

let g:netrw_banner=0

let test#strategy = 'vimterminal'
if has('nvim')
  let test#strategy = 'neovim'
endif
if exists('$TMUX')
  " let test#strategy = 'vtr'
endif

map <leader>ss :TestFile<cr>
map <leader>sa :TestSuite<cr>
map <leader>sk :TestNearest<cr>
map <leader>sl :TestLast<cr>
map <leader>sn :TestSuite --next-failure<cr>
map <leader>sf :TestSuite --only-failure<cr>

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" command! ProjectFiles execute 'Files' s:find_git_root()
" let g:rooter_patterns = ['Rakefile', 'Gemfile', '.git/']

" keep consistent with fzf
noremap <leader>t :Files<cr>
nnoremap <leader>fg :Ag<cr>
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>fC :Commits<cr>
nnoremap <leader>fc :BCommits<cr>

nnoremap <leader>b :Buffer<cr>

"set grepprg=ag\ --vimgrep
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

map <leader>g :grep -r <cword><cr>


command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)


" configure jekyll
let g:jekyll_post_extension = '.md'

let g:neocomplcache_enable_cursor_hold_i=1
let g:neocomplcache_enable_at_startup = 1

hi! Normal cterm=NONE term=NONE ctermfg=12 ctermbg=NONE

let g:solarized_termtrans = 1

let g:go_fmt_command = "goimports"
let g:go_gopls_enabled = 1

let g:airline_powerline_fonts = 1  " use  the powerline fonts
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

if has('nvim')
  " let test#strategy = 'neoterm'

  " leave terminal mode with escape
  tnoremap <Esc> <C-\><C-n>
endif

if has('vim')
  tnoremap <Esc> <C-W>N
endif

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:ale_sign_error = "◊"
let g:ale_sign_warning = "•"
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning
let g:ale_fix_on_save = 0
let g:ale_echo_cursor = 0
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_ruby_rubocop_executable='bundle'
let g:ale_ruby_rubocop_options='--server'
let g:ale_ruby_standardrb_executable = 'bundle'

let g:airline#extensions#ale#enabled = 1

map <leader>af :ALEFix<cr>
map <leader>ai :ALEDetail<cr>
map <leader>ac :ALEComplete
map <leader>adb :ALEDisableBuffer
map <leader>adg :ALEDisable
map <leader>aeb :ALEEnableBuffer
map <leader>aeg :ALEEnable
map <leader>ag :ALEGoToDefinitionInSplit<cr>

let g:ale_fixers = { 'ruby': ['rubocop'] }
let g:ale_linters = { 'ruby': [ 'rubocop', 'ruby', 'sorbet' ] }
" let g:gutentags_ctags_tagfile = '.tags'

" Plug 'dense-analysis/ale'

syntax on

" Include tags
" set tags^=.tags;

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.ex,*.exs set filetype=elixir

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType qf setlocal norelativenumber colorcolumn&

set mouse=a

" When mouse highlighting, copy to xsel buffer
" vmap <LeftRelease> "*ygv
" Copy unidentified buffers to system clipboard

set clipboard=unnamedplus

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10})
endfunction
nnoremap z= :call FzfSpell()<CR>

autocmd BufNewFile,BufRead .envrc set syntax=sh

let g:rails_projections = {
      \ "app/controllers/*_controller.rb": {
      \   "test": [
      \     "spec/controllers/{}_controller_spec.rb",
      \     "spec/requests/{}_spec.rb"
      \   ],
      \ },
      \ "spec/requests/*_spec.rb": {
      \   "alternate": [
      \     "app/controllers/{}_controller.rb",
      \   ],
      \ }}

if $TERM_PROFILE == 'dark'
  set background=dark
elseif $TERM_PROFILE == 'light'
  set background=light
endif


call plug#end()

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif


if has('nvim')

lua <<EOF
  local lspconfig = require("lspconfig")
  lspconfig.ruby_ls.setup({})

  -- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

EOF

endif
