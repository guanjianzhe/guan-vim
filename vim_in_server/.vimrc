"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Amix - http://amix.dk/
"
" Maintainer: guan 
" Version: 0.1
" Last Change:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" preview windows在下方出现，这样不会时整个画面下移
" http://vim.1045645.n5.nabble.com/Preview-window-on-the-bottom-td1179295.html
function! PreviewDown() 
   if !&previewwindow 
       silent! wincmd P 
   endif 
   if &previewwindow 
       silent! wincmd J 
       silent! wincmd p 
   endif 
endf 

au BufWinEnter * call PreviewDown() 

    " Rainbow {
            let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    "}

    " signify {
	" 默认不开启，通过快捷键<leader>gg开启
    "let g:signify_disable_by_default = 1

		nmap <leader>gj <plug>(signify-next-hunk)
    	nmap <leader>gk <plug>(signify-prev-hunk)
    	nmap <leader>gJ 9999<leader>gj
    	nmap <leader>gK 9999<leader>gk
    " }

    " indent_guides {
    "    if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1

    "" indent
    "" <leader>ig to trigger
    "let g:indent_guides_start_level = 2
    "let g:indent_guides_guide_size = 1
    let g:indent_guides_auto_colors = 1
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
    "    endif
    " }

    " NerdTree {
        "if isdirectory(expand("~/.vim/bundle/nerdtree"))
            "map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['order','builtin',  'tags', '\.cmd$', '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.o$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0

    " s/v 分屏打开文件
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'

    " nerdtreetabs
    map <Leader>e <plug>NERDTreeTabsToggle<CR>
    map <Leader>nt <plug>NERDTreeTabsToggle<CR>
    " 关闭同步
    let g:nerdtree_tabs_synchronize_view=0
    let g:nerdtree_tabs_synchronize_focus=0
    " 是否自动开启nerdtree
    " thank to @ListenerRi, see https://github.com/wklken/k-vim/issues/165
    let g:nerdtree_tabs_open_on_console_startup=0
    let g:nerdtree_tabs_open_on_gui_startup=0
       "endif
    " }

    " Fugitive {
        "if isdirectory(expand("~/.vim/plugin/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        "endif
    "}

    " ctrlp {
       " if isdirectory(expand("~/.vim/plugin/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <leader>ru :CtrlPMRU<CR>

            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }
			" guan
			let g:ctrlp_max_files=0
			"let g:ctrlp_max_depth=40 

            "if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            "endif
       " endif
    "}

" cscope.vim(brookhong) {{{
"Below is the minimum key mappings.

    nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
    nnoremap <leader>l :call ToggleLocationList()<CR>

"Some optional key mappings to search directly.

    " s: Find this C symbol
    nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
    " g: Find this definition
    nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
    " d: Find functions called by this function
    nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
    " c: Find functions calling this function
    nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
    " t: Find this text string
    nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
    " e: Find this egrep pattern
    nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
    " f: Find this file
    nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
    " i: Find files #including this file
    nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
	" 不再提示更新 
	let g:cscope_silent=1
" }}}

" easymotion {{{
	" <Leader>f{char} to move to {char}
	map  <Leader>f <Plug>(easymotion-bd-f)
	nmap <Leader>f <Plug>(easymotion-overwin-f)
	
	" s{char}{char} to move to {char}{char}
	nmap s <Plug>(easymotion-overwin-f2)
	
	" Move to line
	map <Leader>L <Plug>(easymotion-bd-jk)
	nmap <Leader>L <Plug>(easymotion-overwin-line)
	
	" Move to word
	map  <Leader>w <Plug>(easymotion-bd-w)
	nmap <Leader>w <Plug>(easymotion-overwin-w)
" }}}
"
" ################### 显示增强 ###################
" airline {{{
	let g:airline_powerline_fonts = 1
	" take care don't change it later
	set t_Co=256 
"	" symbols
"    if !exists('g:airline_symbols')
"        let g:airline_symbols = {}
"    endif
"	let g:airline_symbols.space = "\ua0"
"    let g:airline_left_sep = '▶'
"    let g:airline_left_alt_sep = '❯'
"    let g:airline_right_sep = '◀'
"    let g:airline_right_alt_sep = '❮'
"    "let g:airline_symbols.linenr = '¶'
"    let g:airline_symbols.linenr = ' '
"    "let g:airline_symbols.branch = '-b'
"    let g:airline_symbols.branch = ''
"    "let g:airline_symbols.branch = '⎇'
	
	" See `:echo g:airline_theme_map` for some more choices
    " Default in terminal vim is 'dark'
    " if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
    let g:airline_theme = 'solarized'

	"set ambiwidth=double
	"set noshowmode
	"set timeoutlen=50
    " 是否打开tabline
    let g:airline#extensions#tabline#enabled = 1
	" tab序号的类型
	let g:airline#extensions#tabline#tab_nr_type = 1 
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	" configure separators for the tabline only.
	let g:airline#extensions#tabline#left_sep = '|'
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#right_sep = '|'
	let g:airline#extensions#tabline#right_alt_sep = '|'
	" set ttimeoutlen=50
" }}}

"    " vim-airline {
"        " Set configuration options for the statusline plugin vim-airline.
"        " Use the powerline theme and optionally enable powerline symbols.
"        " To use the symbols , , , , , , and .in the statusline
"        " segments add the following to your .vimrc.before.local file:
"        "   let g:airline_powerline_fonts=1
"        " If the previous symbols do not render for you then install a
"        " powerline enabled font.
"
"        " See `:echo g:airline_theme_map` for some more choices
"        " Default in terminal vim is 'dark'
"        if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
"            if !exists('g:airline_theme')
"                let g:airline_theme = 'solarized'
"            endif
"            if !exists('g:airline_powerline_fonts')
"                " Use the default set of separators with a few customizations
"                let g:airline_left_sep='›'  " Slightly fancier than '>'
"                let g:airline_right_sep='‹' " Slightly fancier than '<'
"            endif
"        endif
"    " }

" 标签导航
" tagbar {{{
	let g:tagbar_width = 40
	nmap <silent> <leader>tb :TagbarToggle<cr>
	"nmap <silent> <leader>wm :WMToggle<cr>
    let g:tagbar_autofocus = 1
    " let g:tagbar_autoshowtag = 1
    " let g:tagbar_show_visibility = 1
	
	" for Makefile
	let g:tagbar_type_make = {
            \ 'kinds':[
                \ 'm:macros',
                \ 't:targets'
            \ ]
	\}
" }}}
 
 "==========================================
" others 其它设置
"==========================================
" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Find merge conflict markers
" go to merge conflict markers
map <leader>gc /\v^[<\|=>]{7}( .*\|$)<CR>

"Set mapleader
let mapleader = ","
let g:mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 搜索相关
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>


" tab/buffer相关

" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>
" 使用方向键切换c
noremap <up> :tp<CR>
noremap <down> :tn<CR>

" tab 操作
" http://vim.wikia.com/wiki/Alternative_tab_navigation

" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim


    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

" tab切换
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

"" 新建tab  Ctrl+t
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-t>     <Esc>:tabnew<CR>

" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" F1 - F8 设置

" F1 NERDTree开关
map <F1> <plug>NERDTreeTabsToggle<CR>
" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
" noremap <F1> <Esc>"

" F2 行号开关，用于鼠标复制代码用
set pastetoggle=<F2>            "    when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" F3 为方便复制，用<F3>开启/关闭行号显示:
function! HideNumber()
	if(&relativenumber == &number)
		set relativenumber! number!
	elseif(&number)
		set number!
	else  
	    set relativenumber!
	endif 
	set number?
endfunc
nnoremap <F3> :call HideNumber()<CR>

function! ToggleMouse()
	if(&mouse == 'a')
		set mouse=
		echo "Mouse usage \"Disabled\""
	else
		set mouse=a
		echo "Mouse usage \"Enabled\""
	endif
endfunc
nnoremap <F4> :call ToggleMouse()<CR>

" F5 Grep
nnoremap <silent> <F5> :Rgrep<CR>

 " F Gdiff
"nnoremap <silent> <F7> :Rgrep<CR>
nnoremap <silent> <F6> :Gdiff<CR>
nnoremap  <silent> <C-g>  :Gdiff<CR>
" Fast Gdiff
nmap <C-1> :Gdiff<CR>
"vmap <silent> <leader> :Gdiff<CR>

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste
 
" F2 set paste问题已解决, 粘贴代码前不需要按F2了
" F2 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"A
nnoremap <silent> <F12> :A<CR>

"Quickfix
"nnoremap <silent> <F6> :cn<CR>
"nnoremap <silent> <F5> :cp<CR>

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F7>
"you also can :set paste, :set paste!

"EnhancedCommentify
"vmap <F8> <Esc><Esc>:call EnhancedCommentify('yes','comment',line("'<"),line("'>"))<CR>
"vmap <C-F8> <Esc><Esc>:call EnhancedCommentify('yes','decomment',line("'<"),line("'>"))<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Get out of VI's compatible mode..
set nocompatible

" Platform
function! MySys()
    return "linux"
endfunction

"Sets how many lines of history VIM har to remember
set history=1000

set encoding=utf-8
set fileencodings=utf-8,chinese,gb2312,gbk,gb18030,big5,latin-1

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

"Fast Ex command
nnoremap ; :

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term=="xterm"
	set t_Co=8
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

syntax enable

"set term=xterm-256color
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    "Enable syntax hl
    " color scheme
    if has("gui_running")
        set guioptions-=T
        set guioptions-=m
        set guioptions-=L
        set guioptions-=r
        "colorscheme solarized
        colorscheme molokai
        "colorscheme desert_my
        "hi normal guibg=#294d4a
    else
		let g:molokai_original = 1
		"colorscheme solarized
		colorscheme molokai
		"colorscheme desert_my
    endif " has
endif " exists(...)

"" for solarized
"set background=dark
""set background=light
"let g:solarized_termcolors=256
""let g:solarized_termtrans=0
""let g:solarized_degrade=1
"set t_Co=256
"colorscheme solarized
" from spf13
    " if !exists('g:override_spf13_bundles') && filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
		set background=dark
        "let g:solarized_termcolors=256
        "let g:solarized_termtrans=1
        "let g:solarized_contrast="normal"  "改 solarized.vim 304行
        "let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    "endif

" 修改主题颜色
" 高亮光标所在行
set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear CursorLineNr    " Remove highlight color from current line number
"hi Directory       ctermfg=112               cterm=none
"hi PreCondit       ctermfg=112               cterm=bold

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5

" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

"The commandbar is 2 high
set cmdheight=1

    set splitright                  " Puts new vsplit windows to the right of the current

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    "if !exists('g:override_spf13_bundles')
    "    set statusline+=%{fugitive#statusline()} " Git Hotness
    "endif
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" 00x增减数字时使用十进制
set nrformats=

"Show line number
set nu

" 缩进配置      
" Smart indent  
set smartindent 
" 打开自动缩进  
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent  
                
" tab相关变更   
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4   
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab    
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab   
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround  
                                                                                                                    
" A buffer becomes hidden when it is abandoned
set hidden      
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set number
"set relativenumber number
"set relativenumber
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
"" 插入模式下用绝对行号, 普通模式下用相对
"autocmd InsertEnter * :set norelativenumber number
"autocmd InsertLeave * :set relativenumber
" 关闭nerdtree 和 taglist的行号. 
"autocmd BufEnter * set relativenumber
autocmd FileType nerdtree set norelativenumber
autocmd FileType taglist set norelativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set number
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"Do not redraw, when running macros.. lazyredraw
"set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>

"Ignore case when searching
set ignorecase
" 有一个或以上大写字母时仍大小写敏感                      
set smartcase

"Include search
set incsearch

"Highlight search things
set hlsearch

"Set magic on
"set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
"set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to buffer according to file name
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Open a dummy buffer for paste
map <leader>es :tabnew<cr>:setl buftype=nofile<cr>
if MySys() == "linux"
map <leader>ec :tabnew ~/tmp/scratch.txt<cr>
else
map <leader>ec :tabnew $TEMP/scratch.txt<cr>
endif

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile
"set bufhidden=hide

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile * setfiletype txt 
au FileType txt setl lbr
au FileType txt setl tw=120
set iskeyword+=_,$,@,%,#,-

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"set formatoptions=tcrqn
"set smarttab
"set smartindent
set autoindent
set cindent
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""
"IDE
""""""""""""""""""""""""""""""
" file explorer setting
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=35

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some files
let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0

""""""""""""""""""""""""""""""
" minibuffer setting
""""""""""""""""""""""""""""""
"let loaded_minibufexplorer = 1         " *** Disable minibuffer plugin
"let g:miniBufExplorerMoreThanOne = 2   " Display when more than 2 buffers
"let g:miniBufExplSplitToEdge = 1       " Always at top
"let g:miniBufExplMaxSize = 3           " The max height is 3 lines
"let g:miniBufExplMapWindowNavVim = 1   " map CTRL-[hjkl]
"let g:miniBufExplUseSingleClick = 1    " select by single click
"let g:miniBufExplModSelTarget = 1      " Dont change to unmodified buffer
"let g:miniBufExplForceSyntaxEnable = 1 " force syntax on
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow = 0
"
"let g:miniBufExplorerMoreThanOne=0
"autocmd BufRead,BufNew :call UMiniBufExplorer

""""""""""""""""""""""""""""""
" bufexplorer setting
""""""""""""""""""""""""""""""
"let g:bufExplorerDefaultHelp=1       " Do not show default help.
"let g:bufExplorerShowRelativePath=1  " Show relative paths.
"let g:bufExplorerSortBy='mru'        " Sort by most recently used.
"let g:bufExplorerSplitRight=0        " Split left.
"let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
"let g:bufExplorerUseCurrentWindow=1  " Open in new window.
"let g:bufExplorerMaxHeight=13        " Max height


""""""""""""""""""""""""""""""
" taglist setting
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Process_File_Always=1
nmap <silent> <leader>tl :Tlist<cr>

"TODO
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

""""""""""""""""""""""""""""""
" winmanager setting
""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
"let g:winManagerWidth = 30
"let g:defaultExplorer = 0
"nmap <C-W><C-F> :FirstExplorerWindow<cr>
"nmap <C-W><C-B> :BottomExplorerWindow<cr>
""nmap <silent> <leader>wm :WMToggle<cr>
"autocmd BufWinEnter \[Buf\ List\] setl nonumber

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
"let g:netrw_winsize = 30
"nmap <silent> <leader>fe :Sexplore!<cr>


""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
"let g:LookupFile_MinPatLength = 2
"let g:LookupFile_PreserveLastPattern = 0
"let g:LookupFile_PreservePatternHistory = 0
"let g:LookupFile_AlwaysAcceptFirst = 1
"let g:LookupFile_AllowNewFiles = 0
"if filereadable("./filenametags")
"let g:LookupFile_TagExpr = '"./filenametags"'
"endif
"nmap <silent> <leader>lk <Plug>LookupFile<cr>
"nmap <silent> <leader>ll :LUBufs<cr>
"nmap <silent> <leader>lw :LUWalk<cr>
"
"" lookup file with ignore case
"function! LookupFile_IgnoreCaseFunc(pattern)
"let _tags = &tags
"try
"   let &tags = eval(g:LookupFile_TagExpr)
"   let newpattern = '\c' . a:pattern
"   let tags = taglist(newpattern)
"catch
"   echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
"   return ""
"finally
"   let &tags = _tags
"endtry
"
"" Show the matches for what is typed so far.
"let files = map(tags, 'v:val["filename"]')
"return files
"endfunction
"let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fencview Autodetect multiple encodings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fencview_autodetect = 1 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function echo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ctags -R --fields=+lS
set foldmethod=syntax
set foldlevel=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M - :%s/<C-V><cr>//ge

set updatetime=50


""""""""""""""""""""""""""""""
" Programing
""""""""""""""""""""""""""""""
" Visual
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Fast grep
nmap <silent> <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
vmap <silent> <leader>lv :lv /<c-r>=<sid>GetVisualSelection()<cr>/ %<cr>:lw<cr>

" Fast diff
cmap @vd vertical diffsplit 
set diffopt+=vertical

"ctags
"nmap <silent> <leader>tg :!ctags -R --c-kinds=+px --fields=+lS<cr><cr>
"vmap <silent> <leader>tg :!ctags -R --c-kinds=+px --fields=+lS<cr><cr>
nmap <silent> <leader>tg :!ctags -R  --fields=+lS<cr><cr>
vmap <silent> <leader>tg :!ctags -R  --fields=+lS<cr><cr>

"time
nmap <silent> <leader>tm :<ESC>i<C-R>=strftime("%Y-%m-%d")<ESC><ESC>
vmap <silent> <leader>tm :<ESC>i<C-R>=strftime("%Y-%m-%d")<ESC><ESC>

"omni
filetype plugin indent on 
set completeopt=longest,menu
"TODO
"in file omni
"inoremap <C-p> <C-x><C-n>

"txtbrowser



"set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent

set csto:0
set cscopetag
set nocsverb
"cs add $ANDROID_SRC/cscope/cscope.out $ANDROID_SRC/cscope
"set csverb
"set tags:./tags,tags ",$ANDROID_SRC/cscope/tags

     " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("cscope")
" set csprg=/usr/bin/cscope
" set csto=1
" set cst
" set nocsverb
" " add any database in current directory
" if filereadable("cscope.out")
"   cs add cscope.out
" endif
" set csverb
"endif


