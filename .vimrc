set nocompatible
" Encoding related
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
set t_Co=256
"colo desert
colorscheme wombat256mod
"colorscheme evening
filetype plugin indent on
set autochdir "自动切换当前目录为当前文件所在的目录
set autoindent cindent cinoptions=g0
set nocp "不与vi兼容
" Editing related
set autowrite
set autoread
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set mouse=a "设定在任何模式下鼠标都可用
set number "显示行号
set ruler "打开状态标尺
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive
set display=lastline
set linespace=0 "字符间插入的像素行数目
set iskeyword+=_,$,@,%,#,-
set foldenable              " 开始折叠
set foldmethod=syntax              "设置语法折叠
set formatoptions=tcqro "注释换行时自动加上前导的空格和星
set linebreak "整词换行
set showmatch "显示括号配对情况
set expandtab "tab=>space
set softtabstop=4 "按退格可以一次删除4个空格不到4个时删除剩下的空格
set tabstop=4
set whichwrap=b,s,<,>,[,] "设定退格、空格和左右方向键在行首行尾时的行为
"==============
"不允许
"===============
set nobackup "文件不备份
set noignorecase "默认区分大小写
set nolinebreak "在单词中间断行
set noswapfile
"set scrolloff=5
set shiftwidth=4 "设定 << >>命令移动时宽度为4
set showcmd "在状态栏显示目前执行的指令，未完成的也会显示
set hidden "允许在有未保存的修改时切换缓冲区
set history=100 "设置冒号命令和搜索命令的历史列表
set hlsearch "设置搜索时高亮找到的文本
set ignorecase smartcase "搜索时忽略大小写，但在有一个或以上大写时
set incsearch "输入搜索内容时就显示结果
if (has("gui_running"))
    set guioptions+=b
    set nowrap
else
    set wrap "自动换行
endif
syntax on "自动语法高亮
"设置命令行和状态栏
set cmdheight=1 "设定命令行的行数为1
set laststatus=2 "显示状态栏
"set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B \ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==""?&enc:&fenc).(&bomb?",BOM":"")}]\ %c:%l/%L%)\
set statusline=\ %F%m%r%h\ %w\ \ ASCII=\%b,HEX=\%B\ \ CWD:\ %r%{CurDir()}E5%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction
"自动命令
set wildmenu  "增强模式中的命令行自动完成操作
fun! OmniComplete()
let left = strpart(getline('.'), col('.') - 2, 1)
if left =~ "^$"
return ""
elseif left =~ ' $'
return ""
else
return "\<C-x>\<C-o>"
endfun
inoremap <silent> <S-Tab> <C-R>=OmniComplete()<CR>
autocmd FileType php set ofu=phpcomplete#CompletePHP "PHP语法提示
"map <C-J> :!c:/php/php -l %<CR> php语法进行检测
" Tab related
set sw=4
set smarttab
set et
set ambiwidth=double "出现全半角
"=============================================================================
" Platform dependent settings
"=============================================================================
if (has("win32"))
    if (has("gui_running"))
        "set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
	set guifont=Consolas:h11:cANSI
        set guifontwide=NSimSun:h9:cGB2312
    endif
else
    if (has("gui_running"))
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
    endif
endif
"在保存文件时自动去除无效空白，包括行尾空白包括文件最后的空行。
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
"       silent! %s/\s\+$//
        silent!:%s= *$==
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" Check the syntax of a PHP file
function! CheckPHPSyntax()
    if &filetype != 'php'
        echohl WarningMsg | echo 'This is not a PHP file !' | echohl None
        return
    endif
    if (has("win32"))
	setlocal makeprg=E:\php\php.exe\ -l\ -n\ -d\ html_errors=off\ %
    else
	setlocal makeprg=/usr/local/php/bin/php\ -l\ -n\ -d\ html_errors=off\ %
    endif
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    echohl WarningMsg | echo 'Syntax checking output:' | echohl None
    if &modified == 1
        silent write
    endif
    silent make
    clist
endfunction
au filetype php map <F5> :call CheckPHPSyntax()<CR>
au filetype php imap <F5> <ESC>:call CheckPHPSyntax()<CR>
"======================
" vim目录树插件
"======================
map <F2> :NERDTreeToggle<CR>
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
let mapleader=","
let g:mapleader=","
"http://meituo-gvim-config.googlecode.com/hg/vim/.vimrc
"======================
" 自动注释
"======================
map fg : Dox<cr>
let g:DoxygenToolkit_briefTag_pre="@"
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns"
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Mathias Lorente"
let g:DoxygenToolkit_licenseTag="My own license"
let g:DoxygenToolkit_authorName="hlxo, hlxo@hotmail.com"
let s:licenseTag = "Copyright(C)"
let s:licenseTag = s:licenseTag . "For free"
let s:licenseTag = s:licenseTag . "All right reserved"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
"标签页快捷键
imap <C-tab> :tabnext<cr>
nmap <C-tab> :tabnext<cr>
imap <C-S-tab> :tabprevious<cr>
nmap <C-S-tab> :tabprevious<cr>
imap <M-1> <Esc>:tabfirst<cr>
nmap <M-1> :tabfirst<cr>
imap <M-2> <Esc>2gt
nmap <M-2> 2gt
imap <M-3> <Esc>3gt
nmap <M-3> 3gt
imap <M-4> <Esc>4gt
nmap <M-4> 4gt
imap <M-5> <Esc>5gt
nmap <M-5> 5gt
imap <M-6> <Esc>6gt
nmap <M-6> 6gt
imap <M-7> <Esc>7gt
nmap <M-7> 7gt
imap <M-8> <Esc>8gt
nmap <M-8> 8gt
imap <M-9> <Esc>9gt
nmap <M-9> 9gt
imap <M-0> <Esc>:tablast<cr>
