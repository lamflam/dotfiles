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
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Alt j/k moves line up or down
nnoremap ˚ :m -2<cr>
nnoremap ∆ :m +1<cr>

nnoremap <leader>s :Ag<cr>                                                            "\s to search files
nnoremap <leader>f :ALEFix<cr>                                                        " \f to format
nnoremap <leader>q <C-w>q                                                             " \q to close current window
nnoremap <leader>d :bp\|bd #<cr>                                                      " \d delete current buffer but leave window open
nnoremap <leader>da :%bdelete<cr>                                                     " \da to close all buffers
nnoremap <leader>t :Files<cr>                                                         " Search for files
nnoremap <leader>r :Buffers<cr>                                                       " Search open buffers
nnoremap <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<cr>                  " Increase vertical split window
nnoremap <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<cr>                  " Decrease vertical split window
nnoremap <leader>\| <C-w>=                                                            " auto resize splits
nnoremap <leader>m :Magit<cr>                                                         " Open magit window
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>                   " got to definiton
nnoremap <leader>l :Extradite!<cr>                                                    " Open git commit viewer
nnoremap  :vsp<cr>                                                                  " Vertical split
nnoremap  :sp<cr>                                                                   " horizontal split
nnoremap <leader>b :Gblame<cr>                                                        " Git blame


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
set cmdheight=1                                                                    " The commandbar height
set cul                                                                            " highlight current line
set exrc                                                                           " allow project .vimrc
set hlsearch                                                                       " highlight search
set ignorecase                                                                     " Case insensitive
set incsearch                                                                      " Move forward while typing search
set laststatus=2                                                                   " always have a status bar
if has("mouse_sgr")                                                                " enable mouse
    set mouse=a ttymouse=sgr
else
    set mouse=a ttymouse=xterm2
endif
set nobackup                                                                       " no backups
set nocursorline                                                                   " cursorline can really slow down perf because it redraws the whole screen
set noerrorbells                                                                   " no beeping
set nohidden                                                                       " dont unload my buffer
set nolazyredraw                                                                   " Don't redraw while executing macros
set nowritebackup                                                                  " no backups
set noshowmode                                                                     " lightline handles this
set noswapfile                                                                     " no backups
set number                                                                         " show line numbers
set ruler                                                                          " Always show current position
set secure                                                                         " Be safe with project specific vimrcs
set showmatch                                                                      " Show matching bracets when text indicator is over them
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab                                 " no tabs
set textwidth=120                                                                  " 120 max line length
set ttimeoutlen=50                                                                 " Escape faster 
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
Plugin 'airblade/vim-gitgutter'                                                    " Show git +/- on left of editor
Plugin 'tpope/vim-eunuch.git'                                                      " Unix shell commands, :Delete, :Move, :Rename
Plugin 'sheerun/vim-polyglot'                                                      " Language packs
Plugin 'jiangmiao/auto-pairs'                                                      " Bracket completion
Plugin 'alvan/vim-closetag'                                                        " HTML/React tag closing
Plugin 'Valloric/YouCompleteMe'                                                    " Auto completetion
Plugin 'Valloric/MatchTagAlways'                                                   " HTML/React tag context highlighting
Plugin 'tpope/vim-surround'                                                        " better bracket commands
Plugin 'christoomey/vim-tmux-navigator'                                            " better nav for vim+tmux
Plugin 'jreybert/vimagit'                                                          " Git helper
Plugin 'int3/vim-extradite'                                                        " Git commit browser
Plugin 'scrooloose/nerdcommenter'                                                  " Commenting
Plugin 'shime/vim-livedown'                                                        " Live markdown preview - requires 'npm install -g livedown'
" Plugin 'vim-airline/vim-airline-themes'
" Plugin 'itchyny/lightline.vim'                                                   " Status line
" Plugin 'altercation/vim-colors-solarized'                                        " A really nice colorscheme

" ALE Settings
let g:ale_linters = {
\   'javascript': [ 'eslint', 'prettier' ],
\   'markdown': [ 'prettier' ],
\   'python': [ 'autopep8', 'flake8' ]
\}

let g:ale_fixers = {
\   'javascript': [ 'prettier' ], 
\   'scss': [ 'prettier', 'stylelint' ], 
\   'markdown': [ 'prettier' ], 
\   'json': [ 'prettier' ], 
\   'python': [ 'black', 'autopep8' ],
\   'html': [ 'prettier' ]
\}

let g:ale_python_flake8_executable = 'python3'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" fzf/ack settings
let g:ackprg = 'ag --vimgrep'
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  call insert(tokens, '--hidden')
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction

autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

" vim-closetag auto close tags for js and md files
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.jsx,*.html.erb,*.md,*.jinja'

" vim-jsx settings (included with polyglot)
let g:jsx_ext_required = 0

" auto pairs settings
" Don't jump to next line on closing tag
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0

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

" YouCompleteMe Settings
" let g:ycm_autoclose_preview_window_after_completion=1

" Magit settings
" Unset GPG_TTY to suppress Kryptonite messages on git commits within magit
let g:magit_git_cmd="GPG_TTY= git"

                                                                                   " All of your Plugins must be added before the following line
call vundle#end()                                                                  " required for Vundle
filetype plugin indent on                                                          " required for Vundle

" ----------------------------------------------------------------------------
" COLORS
" ----------------------------------------------------------------------------

syntax enable
set background=dark
silent! colorscheme gruvbox
let g:is_bash=1                                                                    " treat shell as bash by default


" ----------------------------------------------------------------------------
" NO LONGER USED
" ----------------------------------------------------------------------------

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


set showcmd                                                                        " show information about the current command
