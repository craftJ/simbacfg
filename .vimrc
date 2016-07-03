
"====================================
" VIMRC of zj
" History, 20160228 add 
"====================================

set number
set cursorline
set ruler
set hlsearch
set incsearch
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)
set nocompatible
set history=1000

syntax on
"set background=dark
colorscheme molokai

set tabstop=4
set shiftwidth=4
set cindent
set showmatch
set showmode
set showcmd
set linebreak
set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
set incsearch
set hlsearch
set ignorecase
set smartcase
set autowrite


"-------- taglist ------------------
"设置F9为显示taglist窗口的快捷键，否则要通过命令 :TlistOpen 或者:TlistToggle显示窗口
map <silent> <F9> :TlistToggle<cr>  
let Tlist_Use_Right_Window=0 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=1 "0表示让taglist可以同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=1 "实时更新tags
let Tlist_Inc_Winwidth=0 "禁止自动改变当前vim窗口的大小



"--------- winmanage ---------------
map <silent> <F8> :WMToggle<cr>
nmap wm :WMToggle<cr> 
let g:winManagerWindowLayout='FileExplorer|TagList' " 设置管理的插件
let g:persistentBehaviour=0 "如果所有编辑文件都关闭了，退出vim


"--------- cscope -------------------
"set cscopequickfix=s-,c-,d-,i-,t-,e- "设定是否使用 quickfix 窗口来显示 cscope 结果
"自动加载cscope.out文件
map <F10> :call LoadCscope()<cr>
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		"echo path
		"echo db
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
	endif
endfunction

"加载cscope文件
nmap ca :csadd cscope.out<cr>

"查找代码符号
nmap cs :cs find s <C-R>=expand("<cword>")<cr><cr>

"查找本定义
nmap cg :cs find g <C-R>=expand("<cword>")<cr><cr>

"查找调用本函数的函数
nmap cc :cs find c <C-R>=expand("<cword>")<cr><cr>

"查找本字符
nmap ct :cs find t <C-R>=expand("<cword>")<cr><cr>

"查找egrep模式
nmap ce :cs find e <C-R>=expand("<cword>")<cr><cr>

"查找本文件
nmap cf :cs find f <C-R>=expand("<cfile>")<cr><cr>

"查找包含本文件的文件
nmap ci :cs find i <C-R>=expand("<cfile>")<cr><cr>

"查找本函数调用的函数
nmap cd :cs find d <C-R>=expand("<cword>")<cr><cr>




"---------- ctags --------------------
let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'
map <F7> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags




"------- omnicppcomplete setting --------
" 按下F3自动补全代码，注意该映射语句后不能有其他字符，包括tab；否则按下F3会自动补全一些乱码
imap <F3> <C-X><C-O>
" 按下F2根据头文件内关键字补全
imap <F2> <C-X><C-I>
set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1



"---------- program --------------------
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc -Wall"
    let compileflag="-o %< "
    exec compilecmd." % ".compileflag
endfunc
func! CompileGpp()
    exec "w"
    let compilecmd="!g++ -Wall"
    let compileflag="-o %< "
    exec compilecmd." % ".compileflag
endfunc

func! RunPython()
        exec "!python %"
endfunc
func! CompileJava()
    exec "!javac %"
endfunc


func! CompileCode()
        exec "w"
        if &filetype == "cpp"
                exec "call CompileGpp()"
        elseif &filetype == "c"
                exec "call CompileGcc()"
        elseif &filetype == "python"
                exec "call RunPython()"
        elseif &filetype == "java"
                exec "call CompileJava()"
        endif
endfunc

func! RunResult()
        exec "w"
        if &filetype == "cpp"
            exec "! ./%<"
        elseif &filetype == "c"
            exec "! ./%<"
        elseif &filetype == "python"
            exec "call RunPython"
        elseif &filetype == "java"
            exec "!java %<"
        endif
endfunc

map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>

map <F6> :call RunResult()<CR>



