"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" lamflam's .vimrc file
"

" ----------------------------------------------------------------------------
" KEY MAPS
" ----------------------------------------------------------------------------

" Useful macros I use the most

" Navigate windows quickly
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nmap <leader>p :ALEFix<cr>                                                        " \p to prettify
nmap <leader>q :bw<cr>                                                            " \q to close current window
nmap <leader>t :Files<cr>                                                         " Search for files
nmap <leader>r :Buffers<cr>                                                       " Search open buffers

" ----------------------------------------------------------------------------
" CUSTOM COMMANDS AND FUNCTIONS
" ----------------------------------------------------------------------------

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w

" Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL


" ----------------------------------------------------------------------------
" OPTIONS
" ----------------------------------------------------------------------------

set autoindent                                                                     " carry over indenting from previous line
set autoread                                                                       " read file when written externally
set backspace=2                                                                    " allow backspace
set clipboard=unnamed                                                              " use mac clipboard
set cmdheight=2                                                                    " The commandbar height
set cul                                                                            " highlight current line
set hlsearch                                                                       " highlight search
set ignorecase                                                                     " Case insensitive
set incsearch                                                                      " Move forward while typing search
set laststatus=2                                                                   " always have a status bar
set mouse=a                                                                        " enable mouse
set ttymouse=xterm2                                                                " enable mouse
set nobackup                                                                       " no backups
set noerrorbells                                                                   " no beeping
set nohidden                                                                       " dont unload my buffer
set nolazyredraw                                                                   " Don't redraw while executing macros
set nowritebackup                                                                  " no backups
set noshowmode                                                                     " lightline handles this
set noswapfile                                                                     " no backups
set number                                                                         " show line numbers
set ruler                                                                          " Always show current position
set showmatch                                                                      " Show matching bracets when text indicator is over them
set showcmd                                                                        " show information about the current command
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab                                 " no tabs
set textwidth=120                                                                  " 120 max line length
set visualbell t_vb="."                                                            " no beeping, visual only

" ----------------------------------------------------------------------------
" PLUGIN SETTINGS
" ----------------------------------------------------------------------------

set nocompatible                                                                   " Required for Vundle, be iMproved, required
filetype off                                                                       " required for Vundle

                                                                                   "  Vundle bootstrap
set rtp+=~/.vim/bundle/Vundle.vim                                                  " set the runtime path to include Vundle and initialize
let s:bootstrap = 0
try
        call vundle#begin()
catch /E117:/
        let s:bootstrap = 1
         !unset GIT_DIR && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        redraw!
        call vundle#begin()
endtry

Plugin 'VundleVim/Vundle.vim'                                                      " let Vundle manage Vundle, required
Plugin 'w0rp/ale'                                                                  " Linter
Plugin 'junegunn/fzf.vim'
Plugin 'morhetz/gruvbox'                                                           " Main colorscheme
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" Plugin 'itchyny/lightline.vim'                                                   " Status line
" Plugin 'altercation/vim-colors-solarized'                                        " A really nice colorscheme

" ALE Settings
let g:ale_linters = { 'javascript': [ 'eslint', 'prettier' ] }
let g:ale_fixers = { 'javascript': [ 'prettier' ] }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" fzf/ack settings
let g:ackprg = 'ag --vimgrep'
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

" Airline
let g:airline_powerline_fonts = 1
" Don't show the format if it's just a standard file
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_extensions = ['branch', 'ale']
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
    let a:parts = split(a:name, '/')
    if len(a:parts) == 3
        return a:parts[0][0] . '/' . strpart(a:parts[1], 2) . '/' . a:parts[2]
    else
        return a:name
    endif
endfunction

                                                                                   " All of your Plugins must be added before the following line
call vundle#end()                                                                  " required for Vundle
filetype plugin indent on                                                          " required for Vundle

" ----------------------------------------------------------------------------
" COLORS
" ----------------------------------------------------------------------------

syntax enable
set background=dark
colorscheme gruvbox










" Lightline
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
