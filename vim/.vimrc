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



nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Lines<cr>
nnoremap <leader>t :Files<cr>
nnoremap <leader>T :Buffers<cr>
nnoremap <leader>c :Commits<cr>
nnoremap <leader>g :GFiles?<cr>
nnoremap <leader>q :close<cr>                                                         " \q to close current window
nnoremap <leader>Q :close!<cr>                                                        " \Q to close current window
nnoremap <leader>d :bp\|bd #<cr>                                                      " \d delete current buffer but leave window open
nnoremap <leader>D :bp!\|bd! #<cr>                                                    " \D delete current buffer but leave window open
nnoremap <leader>da :%bdelete<cr>                                                     " \da to close all buffers
nnoremap <leader>DA :%bdelete!<cr>                                                    " \DA to force close all buffers
nnoremap <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<cr>                  " Increase vertical split window
nnoremap <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<cr>                  " Decrease vertical split window
nnoremap <leader>\| <C-w>=                                                            " auto resize splits
nnoremap <leader>m :Magit<cr>                                                         " Open magit window
nnoremap <leader>l :Extradite!<cr>                                                    " Open git commit viewer
nnoremap  :vsp<cr>                                                                  " Vertical split
nnoremap  :sp<cr>                                                                   " horizontal split
nnoremap <leader>b :Git blame<cr>                                                     " Git blame

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> gd :call CocAction('jumpDefinition', v:false)<CR>
nmap <silent> gy :call CocAction('jumpTypeDefinition', v:false)<CR>
nmap <silent> gi :call CocAction('jumpImplementation', v:false)<CR>
nmap <silent> gr :call CocAction('jumpReferences', v:false)<CR>

nmap <silent> <leader>e <Plug>(coc-diagnostic-next)
nmap <silent> <leader>E <Plug>(coc-diagnostic-prev)
nnoremap <silent> K :call <SID>show_documentation()<CR>

xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>n <Plug>(coc-rename)

nmap <leader>f :call CocAction('format')<cr>                                                        " \f to format
autocmd FileType javascript,typescript,javascriptreact,typescriptreact nmap <buffer> <leader>f :CocCommand eslint.executeAutofix<cr>:CocCommand prettier.formatFile<cr>
autocmd FileType solidity nmap <buffer> :CocCommand prettier.formatFile<cr>

autocmd BufEnter * :syntax sync minlines=2000

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
set completeopt=longest,menuone
set updatetime=300


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
set hidden                                                                         " dont unload my buffer
set lazyredraw                                                                     " Don't redraw while executing macros
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
call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'                                                           " Main colorscheme
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'                                                    " Show git +/- on left of editor
Plug 'tpope/vim-eunuch'                                                          " Unix shell commands, :Delete, :Move, :Rename
Plug 'sheerun/vim-polyglot'                                                      " Language packs
Plug 'jiangmiao/auto-pairs'                                                      " Bracket completion
Plug 'alvan/vim-closetag'                                                        " HTML/React tag closing
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'Valloric/MatchTagAlways'                                                   " HTML/React tag context highlighting
Plug 'tpope/vim-surround'                                                        " better bracket commands
Plug 'christoomey/vim-tmux-navigator'                                            " better nav for vim+tmux
Plug 'jreybert/vimagit'                                                          " Git helper
Plug 'int3/vim-extradite'                                                        " Git commit browser
Plug 'scrooloose/nerdcommenter'                                                  " Commenting
Plug 'shime/vim-livedown'                                                        " Live markdown preview - requires 'npm install -g livedown'
Plug 'ruanyl/vim-gh-line'                                                        " Generate github link for current line/selection
                                                                                 " All of your Plugins must be added before the following line
call plug#end()


" vim-gh-line settings
let g:gh_line_map = '<leader>h'
let g:gh_line_blame_map = '<leader>hh'
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" fzf/ack settings
let g:ackprg = 'ag --vimgrep'
set rtp+=/usr/local/opt/fzf
" set rtp+=~/.fzf

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
let g:airline_extensions = ['branch', 'coc']
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
    let l:parts = split(a:name, '/')
    if len(l:parts) == 3
        return l:parts[0][0] . '/' . strpart(l:parts[1], 2) . '/' . l:parts[2]
    else
        return a:name
    endif
endfunction


" YouCompleteMe Settings
" let g:ycm_autoclose_preview_window_after_completion=1

" Magit settings
" Unset GPG_TTY to suppress Kryptonite messages on git commits within magit
let g:magit_git_cmd="GPG_TTY= git"



" ----------------------------------------------------------------------------
" COLORS
" ----------------------------------------------------------------------------

syntax enable
set background=dark
silent! colorscheme gruvbox
let g:is_bash=1                                                                    " treat shell as bash by default

hi CocWarningSign ctermfg=Yellow guifg=#ff922b
hi CocErrorSign ctermfg=Red guifg=#ff0000

set showcmd                                                                        " show information about the current command
