source ~/.vim/bundles.vim

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030

" enable filetype dectection and ft specific plugin/indent
filetype plugin indent on

" enable syntax hightlight and completion
syntax on

let mapleader = "\<Space>"

set clipboard=unnamed

"--------------------------------
" Vim UI
"--------------------------------
set background=dark

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" editor settings
set history=10000
set nocompatible
set nofoldenable                 " disable folding "
set foldmethod=indent            " default fold method = indent."
set confirm                      " prompt when existing from an unsaved file "
set backspace=indent,eol,start   " More powerful backspacing "
set t_Co=256                     " Explicitly tell vim that the terminal has 256 colors
set report=0                     " always report number of lines changed
set nowrap                       " dont wrap lines
set scrolloff=5                  " 5 lines above/below cursor when scrolling
set mouse=a                      " use mouse in all modes"
set number                       " show line numbers
set relativenumber               " show line numbers
set showmatch                    " show matching bracket (briefly jump)
set showcmd                      " show typed command in status bar
set title                        " show file in titlebar
set laststatus=2                 " use 2 lines for the status bar
set matchtime=2                  " show matching bracket for 0.2 seconds

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set smarttab
set expandtab       " expand tab to space

autocmd FileType php,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby,cpp,c,cu,cuda setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=80
autocmd FileType coffee,javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120

"--------------------------------
" Plugin settings
"--------------------------------
" tabbar
let g:Tb_MaxSize = 2
let g:Tb_TabWrap = 1

hi Tb_Normal guifg=white ctermfg=white
hi Tb_Changed guifg=green ctermfg=green
hi Tb_VisibleNormal ctermbg=252 ctermfg=235
hi Tb_VisibleChanged guifg=green ctermbg=252 ctermfg=white

" tabline start
hi TabLine      guifg=Blue guibg=Black ctermfg=251 ctermbg=black cterm=none
hi TabLineSel   guifg=Blue guibg=Black ctermfg=Black ctermbg=39  cterm=bold
hi TabLineFill  guifg=Blue guibg=Black ctermfg=251 ctermbg=black cterm=none

function! MyTabLine()
	let s = ''
	let t = tabpagenr()
	let i = 1

	while i <= tabpagenr('$')
	  let buflist = tabpagebuflist(i)
	  let winnr = tabpagewinnr(i)
	  let s .= '%' . i . 'T'
	  let s .= (i == t ? '%1*' : '%2*')
	  let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
	  let s .= ' '
      " Add '+' if one of the buffers in the tab page is modified
      for bufnr in buflist
        if getbufvar(bufnr, "&modified")
          let s .= '* '
          break
        endif
      endfor

	  let s .= i . ':'
	  " let s .= winnr . '/' . tabpagewinnr(i,'$')
	  " let s .= ' '
	  let bufnr = buflist[winnr - 1]
	  let file = bufname(bufnr)
	  let buftype = getbufvar(bufnr, 'buftype')
	  if buftype == 'nofile'
		if file =~ '\/.'
		  let file = substitute(file, '.*\/\ze.', '', '')
		endif
	  else
		let file = fnamemodify(file, ':p:t')
	  endif
	  if file == ''
		let file = '[No Name]'
	  endif
	  let s .= file
	  let s .= ' %*'

	  let i = i + 1
	endwhile

	let s .= '%T%#TabLineFill#%='
	let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')

	return s

endfunction

set stal=2
set tabline=%!MyTabLine()

nnoremap <leader>t :tabnext<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" tabline end

" Tagbar
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" autocmd VimEnter * nested :TagbarOpen
" autocmd Vimenter * 2wincmd w

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"

" nerdcommenter
let NERDSpaceDelims=1
let NERDCompactSexyComs=1

" powerline
" let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'short'

" NeoComplCache
let g:neocomplcache_enable_at_startup=1
let g:neoComplcache_disableautocomplete=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

" Enable omni completion.
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.erlang = '[a-zA-Z]\|:'

" SuperTab
let g:SuperTabDefultCompletionType='context'
let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
let g:SuperTabRetainCompletionType=2

" ctrlp
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" gundo
nnoremap <leader>h :GundoToggle<CR>

" ease-align
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" if !exists('g:easy_align_delimiters')
  " let g:easy_align_delimiters = {}
" endif
" let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" " multi-cursor
" let g:multi_cursor_use_default_mapping=0
" " Default mapping
" let g:multi_cursor_next_key='<C-m>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" vim-visual-multi
let g:VM_theme = "spacegray"
let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'        " start selecting up

" gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=1 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 ctermfg=1 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=0
highlight clear SignColumn
let g:gitgutter_max_signs=9999

let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

" hightlight current words
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>

nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>

"-----------------------------------------
" Key Mapping
"-----------------------------------------
" Keybindings for plugin toggle
nnoremap <F8> :set invpaste paste?<CR>
nnoremap <F3> :set wrap! wrap?<cr>
nnoremap <F4> :IndentGuidesToggle<cr>
nnoremap <F5> :TagbarToggle<cr>
nnoremap <F6> :NERDTreeToggle<cr>
nnoremap <F7> :set rnu! rnu?<cr>
set pastetoggle=<F8>

nnoremap <leader>a :Ack
nnoremap <leader>v V`]
nnoremap <leader>q :q<CR>
nnoremap <leader>w :up<CR>
" nnoremap <leader>e :wq<CR>
nnoremap U <C-r>

map <Leader>sa ggVG"
" map sort function to a key
vnoremap <Leader>s :sort<CR>

"Reselect visual bolck after indent/outdent.
vnoremap < <gv
vnoremap > >gv
nnoremap ; :
nnoremap : ;
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

"------------------
" Useful Functions
"------------------
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" eggcache vim
:command! W w
:command! WQ wq
:command! Wq wq
:command! Q q
:command! Qa qa
:command! QA qa

" for macvim
if has("gui_running")
    set go=aAce  " remove toolbar
    "set transparency=30
    set guifont=Monaco:h13
    set showtabline=2
    set columns=140
    set lines=40
    noremap <D-M-Left> :tabprevious<cr>
    noremap <D-M-Right> :tabnext<cr>
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    map <D-0> :tablast<CR>
endif
if ! has("gui_running")
    set t_Co=256
endif

" vim-maximizer
let g:maximizer_set_default_mapping = 1
let g:maximizer_set_mapping_with_bang = 0
let g:maximizer_default_mapping_key = '<F2>'
nnoremap <F2> :MaximizerToggle<CR>
vnoremap <F2> :MaximizerToggle<CR>gv
inoremap <F2> <C-o>:MaximizerToggle<CR>

"--------------------------------------------
" 补充
"--------------------------------------------
" vimdiff
if &diff
    colorscheme apprentice
endif

set updatetime=300
let g:go_version_warning = 0
let g:syntastic_cpp_compiler_options = ' -std=c++11'        " support c++11

"----------------------------------
"" status line
"----------------------------------
" function! InsertStatuslineColor(mode)
  " if a:mode == 'i'
    " hi statusline guibg=Cyan ctermfg=13 guifg=Black ctermbg=0
  " elseif a:mode == 'r'
    " hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  " else
    " hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  " endif
" endfunction

" au InsertEnter * call InsertStatuslineColor(v:insertmode)
" au InsertLeave * hi statusline guibg=DarkGrey ctermfg=240 guifg=White ctermbg=86
" hi statusline guibg=DarkGrey ctermfg=240 guifg=White ctermbg=86
" hi statuslinenc guibg=DarkGrey ctermfg=8 guifg=White ctermbg=30

" " Formats the statusline
" set statusline=%{getcwd()}\ \|\                 " modified flag
" set statusline+=F:%f\                           " file name
" set statusline+=\ %=                            " align left
" set statusline+=%h\                             " help file flag
" set statusline+=%m\                             " modified flag
" set statusline+=%r\                             " read only flag
" set statusline+=%{strlen(&fenc)?&fenc:'none'}   " file encoding
" set statusline+=\ \|\ %y\ \|\                         " filetype
" set statusline+=Line:%02l/%L\ [%03p%%]\         " line X of Y [percent of file]
" set statusline+=\|\ Col:%02v\                   " current column

