
"顏色主題
"http://code.google.com/p/vimcolorschemetest/
"set vim
""http://cle.linux.org.tw/~edt1023/vim/node10.html
"colorscheme murphy
"colo desert
"colorscheme peachpuff
"=====================
"colorscheme adriana
"colorscheme advantage
"
":colorscheme nightwish
set bg=light
set bg=dark
set t_Co=256
colorscheme ir_black
syntax on
set number

"啟動右邊數字鍵
:imap <Esc>Oq 1
:imap <Esc>Or 2
:imap <Esc>Os 3
:imap <Esc>Ot 4
:imap <Esc>Ou 5
:imap <Esc>Ov 6
:imap <Esc>Ow 7
:imap <Esc>Ox 8
:imap <Esc>Oy 9
:imap <Esc>Op 0
:imap <Esc>On .
:imap <Esc>OQ /
:imap <Esc>OR *
:imap <Esc>Ol +
:imap <Esc>OS -

"Linux gVim 用如下\ 12
set guifont=Monaco\ 12
"set guifont=Consolas\ 12
set guifont=mingliu\ 12

set cursorline

set nu                  "set 行號
set hlsearch            "高亮度反白

set pastetoggle=<F9>    "paste cancel form

set ruler               "可顯示最後一行的狀態
set showmode            "左下角那一行的狀態
set tags=./tags,./../tags,./**/tags

"這也可以算是一種模式，list mode。就是 Tab 的地方會以 ^I 顯示，
"而行尾之 EOL 會顯示成 $。可以讓您清楚的知道 Tab 在哪裡，折行是
"不是真的  Ctrl-v I ==>
"set list

"可指定多個，會依載入的檔案形式來調整 ff。
"例如 :set ffs=unix,dos ff=unix
"則預設為 unix 格式，但如讀入的是 dos 格式的檔案，會自動調整為 dos 格式，
"這樣存檔時就會以 dos 格式存檔（狀態列會顯示）。
"此時如要改成 unix 格式，可 set ff=unix 然後存檔就會轉成 unix 格式，反之亦然。
"如果不這樣設，也就是您不管 ff 或 ffs 都設成 unix，那讀入 dos 格式的檔案時在每行尾會出現 ^M 這個字元（就是 0D 啦！）
"這時縱使 :set ff=unix 也來不及了！只好 :%s/^M//g 來消去這個 ^M。ㄟ，還記得怎麼替換嗎？就是把 ^M 換成沒有啦!
" ^M 是按 Ctrl-v 後不放再按 M 或 Enter 鍵，表示馬上執行
" Hey，你怎麼知道是 0D 呀！好吧！告訴您一個密秘，您把游標移到 ^M 那個位置，然後按 ga 在狀態列就會顯示 10，16，8 進位的值。
" 其它的字元也是可以如此顯示。a 就是 ascii 的意思。但這是 vim 的擴充功能，elvis 沒有。
"elvis 縱使載入 dos 格式的檔案，也是會自動把 ^M 隱藏起來。
:set ffs=unix,dos ff=unix
"auto indent
set ai

"samrt indet
set si

"C-style indeting
set cindent

"wrap lines
set wrap

set title

"Highlight search things
set hlsearch

"How many tenths of a second to blink
set mat=2

"show matching bracets
set showmatch

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"set magic on
set magic

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

set autoindent
"if file have change, it can auto write
"set autowrite
set ic

" Folding configuration
 set foldmethod=marker
" Edit and uncomment next line if you want non-default marker
"set foldmarker={,}
"set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
"set foldcolumn=4
set foldlevelstart=1



"要在所有 mode 中都可以使用滑鼠要設定
set mouse=a

"Get out of VI's compatible mode..
set nocompatible

" set tab
"=========show ^I^I =====

"set smarttab
"set ts=4
"=========show four spaces ====
set softtabstop=2
set shiftwidth=4  "shift space number
set expandtab     "Use tab replace to space

"set sts=1
"set ts=2  " ^I^I
"set tabstop=4    "Use four spaces replace to tab
":retab


"顯示狀態
set laststatus=2
set showcmd
set fileencodings=utf-8
set statusline=%F%m%r%h%w\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]


"r 確保 Vim 在回车後自動追加注释符號
"mM 確保 Vim 能在中文字符之间折行而不要求空格的存在
"set formatoptions+=rmM

"Sets how many lines of history VIM har to remember
set history=100

"Enable filetype plugin
filetype plugin on
filetype indent on
set completeopt=longest,menu
set nocp
" mapping
"inoremap <expr> <CR>     pumvisible()?"\<C-Y>":"\<CR>"
"inoremap <expr> <C-J>    pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
"inoremap <expr> <C-K>    pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"inoremap <expr> <C-U>    pumvisible()?"\<C-E>":"\<C-U>"



""""""""""""""""""""""""""""""
" showmark
""""""""""""""""""""""""""""""
let showmarks_enable = 1
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let showmarks_ignore_type ="hqm"
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1


nmap mk :MarksBrowser<cr>
let marksCloseWhenSelected = 0
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
" ms update marks

" .mt open/close showmarks
" .mo force showmarks
" .mh clear the marks
" .ma clear all the marks
" .mm auto creat a mark
""""""""""""""""""""""""""""""
 " BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufwinEnter \[buf\ List\] setl nonumber


""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少輸入 2 個字符才開始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找歷史
let g:LookupFile_AlwaysAcceptFirst = 1          "Enter 打開第一個匹配項目
let g:LookupFile_AllowNewFiles = 0              "不允許創建不存在的檔案


"lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'


if filereadable("/rpj/tbt1720/build/L27.13.1_dual_screen/filenametags")               "設置 tag 檔案的名字
let g:LookupFile_TagExpr = '"/rpj/tbt1720/build/L27.13.1_dual_screen/filenametags"'
endif
"映射 LookupFile 為,lk
nmap  lk :LUTags
"映射 LUBufs 為,ll
nmap  ll :LUBufs
"映射 LUWalk 為,lw
nmap  lw :LUWalk

""""""""""""""""""""""""""""""
" NERDTree
" """"""""""""""""""""""""""""""
let NERDTreeWinPos = "right" "where NERD tree window is placed on the screen
let NERDTreeChDirMode=2
let NERDTreeWinSize=35
"let NERDTreeQuitOnOpen=1
nmap <F7> <ESC>:NERDTreeToggle<RETURN>" Open and close the NERD_tree.vim separately

""""""""""""""""""""""""""""""
" winManagerWindowLayout
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 40
let g:defaultExplorer = 0
nmap  :FirstExplorerWindow
nmap  :BottomExplorerWindow
nmap wm :WMToggle<cr>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowsNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:AutoOpenWinManager = 1

""""""""""""""""""""""""""""""
" cscope
""""""""""""""""""""""""""""""
if has("cscope")
set csprg=cscope
set csto=0
set cst
set nocsverb
" add any database in current directory
if filereadable("cscope.out")
cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
cs add $CSCOPE_DB
endif
set csverb
set cscopetag
set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
endif

ab #d #define
ab #i #include
ab #k printk("[Johnny](%s)%s ,%d\n\n", __func__, __FILE__, __LINE__);
ab #f printf("(Johnny)(%s)%s ,%d\n\n", __FUNCTION__, __FILE__, __LINE__);
ab #= printk("==================================================\n\n");
ab #g LOG.d(TAG, "[Johnny]");
ab #a #if XXX_LOG  #endif
"ab #l /* [TBT1720 BK053]Migrate TWL6030_PWM related sources into Linux kernel 3.0. ,Johnny, 2011/10/31 */
"ab #l /* [TBT1720 BK005]Backlight functionality. ,Johnny, 2011/12/30 */
"ab #l /* [TBT1720 BK006]MHL functionality. ,Johnny, 2012/01/06 */
"ab #l /* [TBT1720 BK0xx]Migrate Wi-Fi and bluetooth related sources into Linux kernel 3.0.1. ,Johnny, 2011/11/2 */
"ab #l /* [TBT1720 BK0xx]Migrate wakeup related sources into Linux kernel 3.0.1. ,Johnny, 2011/11/3 */
"ab #l /* [TBT1720]Enable fastboot function. ,Johnny, 2011/12/27 */
"ab #l /* [PCT0750]Implement MSR related code. ,Johnny, 2011/12/22 */
"ab #l /* [PHT2300]Add original Light+Proximity source code to driver/framework layer. ,Johnny, 2012/03/23 */
"ab #l /* [PHT2300]Patching GPS with 4AI.1.2. ,Johnny, 2012/03/27 */
"ab #l /* [PHT2300]Fix pin configure. ,Johnny, 20120410 */
"ab #l /* [PHT2300]Fix boot from SD card. ,Johnny, 20120409 */
"ab #l /* [PHT2300]usb interface and power enable ,Johnny, 20120411 */
"ab #l /* [PHT2300]add build & install ducati script ,Johnny, 20120416 */
"ab #l /* [PHT2300]LCD module initialization. ,Johnny, 20120417 */
"ab #l /* [PHT2300]Elpida SDRAM 1066MHz configuration. ,Johnny, 20120417 */
ab #l /* [PHT2200]Porting Ducati code. ,Johnny, 20120504 */



