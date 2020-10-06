set shellslash

" テーマ
syntax on
colorscheme molokai
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis
filetype plugin indent on

" ウインドウの幅
"set columns=100
" ウインドウの高さ
"set lines=50

" 自動生成ファイルを生成しない
set noswapfile
set nobackup
set viminfo=
set noundofile
set hidden

" ウィンドウ表示設定
set number
set hlsearch
set showtabline=3
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap
set cursorline
set cursorcolumn
set scrolloff=2
set textwidth=0
"set clipboard+=autoselect
set clipboard&
set clipboard^=unnamedplus

set nolist
set listchars=tab:>-,trail:-

set ignorecase
set smartcase

" 対応括弧のペアを追加
set matchpairs&
set matchpairs+=<:>
set matchpairs+=（:）
set matchpairs+=【:】
set matchpairs+=「:」

set iskeyword&
set iskeyword+=-

" ビープ音を消す
set vb t_vb=

" 基本操作キーマップ
nnoremap <silent> <c-d> :q<cr>
nnoremap <silent> <c-c> <esc>:nohlsearch<cr>
nnoremap ; :
nnoremap : ;
noremap <c-z> <nop>
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
noremap <c-h> ^
noremap <c-l> $
noremap <c-e> 2<c-e>
noremap <c-y> 2<c-y>
nnoremap <c-u> <c-r>
"noremap <silent> <c-k> "zyiw:let @/ = '\<' . @z . '\>'<cr>:set hlsearch<cr>
noremap <silent> <c-k> :call Highlight()<cr>:set hlsearch<cr>
noremap <c-n> %
nnoremap <c-z> :stop<cr>

"x でヤンクしない
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" leader
let mapleader="\<space>"
nnoremap <leader>s :set 
nnoremap <leader>g :vimgrep  **/*<left><left><left><left><left>
nnoremap <leader>l :ls<cr>
nnoremap <leader>r :source ~/.vimrc<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>o :tabnew<cr>:e 

noremap , <nop>
nnoremap <silent> ,w :set wrap!<cr>
nnoremap <silent> ,l :set list!<cr>
nnoremap <silent> ,n :set number!<cr>
nnoremap <silent> ,t :set expandtab!<cr>

noremap <f1> :tabnew<cr>:help function-list<cr><c-w>w:q<cr>
" vimrcを開く
noremap <f2> :tabnew<cr>:e ~/.vimrc<cr>

" 画面分割、タブ関連
nnoremap s <nop>
nnoremap sn gt
nnoremap sp gT
nnoremap sj <c-w>w

" 大文字・小文字変換
nnoremap gu gUiw
nnoremap gl guiw

nnoremap <silent> <s-down> :call MoveLine("DOWN")<cr>
nnoremap <silent> <s-up> :call MoveLine("UP")<cr>
vnoremap <silent> <s-down> <esc>:call MoveMultiLine("DOWN")<cr>
vnoremap <silent> <s-up> <esc>:call MoveMultiLine("UP")<cr>

noremap <c-up> <c-b>
noremap <c-down> <c-f>
noremap <c-right> 3zl
noremap <c-left> 3zh

" 入力中キーバインド
inoremap <c-f> <right>
inoremap <c-b> <left>
inoremap <c-d> <del>
inoremap <c-t> <c-v><tab>
 
" 括弧入力補完
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>

inoremap {<cr> {}<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>

let g:selectAfterWrap = 0
vnoremap ( <esc>:call Wrap("(", ")")<cr>
vnoremap [ <esc>:call Wrap("[", "]")<cr>
vnoremap { <esc>:call Wrap("{", "}")<cr>
vnoremap < <esc>:call Wrap("<", ">")<cr>
vnoremap " <esc>:call Wrap("\"", "\"")<cr>
vnoremap ' <esc>:call Wrap("\'", "\'")<cr>
vnoremap s <esc>:call Wrap(" ", " ")<cr>

vnoremap / y/<c-r>"<cr>

" Quickfixフック
autocmd QuickFixCmdPre vimgrep tabnew
autocmd QuickFixCmdPost vimgrep cwindow

" 自作コマンド読み込み
":source $VIM/_mycommand.vim

" netrw.vim設定
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_winsize=30
let g:netrw_preview=1
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
"let g:netrw_altv = 1
"let g:netrw_alto = 1

noremap <F9> :tabnew<cr>:e .<cr>

" 最下ウィンドウにステータスバーを常に表示する
set laststatus=2
 
" ステータスバーの内容
"set statusline=%1*
set statusline =
set statusline+=\ [%n]                                     " バッファ番号
set statusline+=\ %<%t                                     " ファイル名
set statusline+=%r%H%W%m                                   " ファイルステータス
"set statusline+=\ [Type:%{strlen(&ft)?&ft:'unknown'}]      " ファイルタイプ
set statusline+=\ [Enc/Fmt:%{strlen(&fenc)?&fenc:'unknown'}/%{GetFileFormat()}]   " ファイルエンコーディング/ファイルフォーマット( 改行コード )
set statusline+=\ %{&bomb?'[BOM]':''}                      " BOM の有無
set statusline+=%=                                         " 以下、右寄せで表示
set statusline+=\ [Ascii:%03b/0x%02B]                             " ASCII コード ( 10進/16進 )
"set statusline+=\ [Pos:%03v\ %l/%L]                        " カーソル位置の列 / 行、全行数
set statusline+=\ [Line:%l/%L\ Col:%c]                             " カーソル位置の列 / 行、全行数
set statusline+=\                                          " パディング
 
" ファイルフォーマットを改行コードに変換
function! GetFileFormat()
    if &ff == 'unix'
        return 'LF'
    elseif &ff == 'dos'
        return 'CRLF'
    elseif &ff == 'mac'
        return 'CR'
    else
        return 'unknown'
    endif
endfunction

" 選択範囲の文字列を取得
function! GetSelectedString()

    let ret = ""
    let tmp = @@
    execute "normal! gvy"
    let ret = @@
    let @@ = tmp

    return ret
endfunction

" 25%/75%の位置に移動できる
" 着地点を予測しにくいため、使い勝手がイマイチ
function! ThreeQuarter(pos)
    execute "normal! H"
    let rowH = line('.')
    execute "normal! L"
    let rowL = line('.')
    execute "normal! M"
    let rowM = line('.')

    let rowMH = ( rowH + rowM ) / 2
    let rowML = ( rowL + rowM ) / 2

    if a:pos == "h"
        execute "normal! " . rowMH . "G"
    else
        execute "normal! " . rowML . "G"
    endif
endfunction

" 指定の文字で選択範囲を囲む
function! Wrap(prefix, suffix)

    execute "normal! `>"
    execute "normal! a" . a:suffix . "\<esc>"
    let sufline = line('.')
    let suflength = strchars(a:suffix)

    execute "normal! `<"
    execute "normal! i" . a:prefix . "\<esc>"
    let prefline = line('.')
    let preflength = strchars(a:prefix)
    
    " 文字挿入後に範囲選択をするかどうか
    if g:selectAfterWrap == 0
        return
    endif

    let cursorshift = 0
    if prefline == sufline
        let cursorshift = preflength + suflength
    else
        let cursorshift = suflength
    endif

    execute "normal! `<v`>" . repeat('l', cursorshift)

endfunction

" カーソル位置の単語をハイライト（*の移動しない版）
function! Highlight()
    let tmp = @@

    execute "normal! viwy"
    let @/ = '\<' . @@ . '\>'
"    なぜか反応しない、呼び出し元で実行（妥協）
"    set hlsearch

    let @@ = tmp
endfunction

" コメントアウト
function! CommentOut(commentString)
    execute "normal! 0i" . a:commentString . "\<esc>"
endfunction

" コメントアウト解除
function! UnCommentOut(commentString)
    let tmp = @@

    let line = getline('.')
    if match(line, '^\s*'.a:commentString) == -1
        return
    endif
    execute "normal! ^" . repeat("x", len(a:commentString))

    let @@ = tmp
endfunction

" 複数行コメントアウト/解除
function! CommentOutMultiLine(commentString)
    call MultiLineCall('CommentOut', [a:commentString])
endfunction

function! UnCommentOutMultiLine(commentString)
    call MultiLineCall('UnCommentOut', [a:commentString])
endfunction

function! FiletypeCommentStr()
    if &ft == 'vim'
        return '"'
    elseif &ft == 'lisp'
        return ';'
    elseif &ft == 'c' || &ft == 'java' || &ft == 'javascript' || &ft == 'php'
        return '//'
    elseif &ft == 'perl' || &ft == 'python'
        return '#'
    endif
endfunction

nnoremap <silent> - :call CommentOut(FiletypeCommentStr())<cr>
nnoremap <silent> + :call UnCommentOut(FiletypeCommentStr())<cr>
vnoremap <silent> - <esc>:call CommentOutMultiLine(FiletypeCommentStr())<cr>gv
vnoremap <silent> + <esc>:call UnCommentOutMultiLine(FiletypeCommentStr())<cr>gv

" 行移動
function! MoveLine(direction)
    let tmp = @@

    let currentLine = line(".")
    let minLine = 1
    let maxLine = line("$")

    "下移動
    if a:direction == "DOWN"
        if currentLine == maxLine
            "最下行の場合、下に新たに空行を追加して移動
            execute "normal! ddo\<ESC>p"
        else
            execute "normal! ddp"
        endif

    "上移動
    elseif a:direction == "UP"
        if currentLine == minLine
            "最上行の場合、何もしない
            return
        elseif currentLine == maxLine
            "最下行の場合、カーソル行が上にずれるため、kが必要無い
            execute "normal! ddP"
        else
            execute "normal! ddkP"
        endif
    endif

    let @@ = tmp
endfunction

" 複数行移動
function! MoveMultiLine(direction)
    let tmp = @@

    let minLine = 1
    let maxLine = line("$")

    execute "normal! `<"
    let topLine = line('.')
    execute "normal! `>"
    let bottomLine = line('.')

    "下移動
    if a:direction == "DOWN"
        if bottomLine == maxLine
            "最下行の場合、下に新たに空行を追加して移動
            execute "normal! `<V`>do\<ESC>p`[V`]"
        else
            execute "normal! `<V`>dp`[V`]"
        endif

    "上移動
    elseif a:direction == "UP"
        if topLine == minLine
            "最上行の場合、何もしない
            execute "normal! `<V`>"
            return
        elseif bottomLine == maxLine
            "最下行の場合、カーソル行が上にずれるため、kが必要無い
            execute "normal! `<V`>dP`[V`]"
        else
            execute "normal! `<V`>dkP`[V`]"
        endif
    endif

    let @@ = tmp
endfunction

" 複数行にわたる関数実行
function! MultiLineCall(funcName, args)
    execute "normal! `<"
    let startLine = line('.')
    execute "normal! `>"
    let endLine = line('.')

    let Fn = function(a:funcName, a:args)

    for eachLine in range(startLine, endLine)
        execute "normal! " . eachLine . "G"
        call Fn()
    endfor
endfunction

" ある文字を基準に、縦のラインを揃える
function! CharIndent(indexchar) range
    let lnum = a:firstline
    let maxidx = 0
    while lnum <= a:lastline
        let idx = match(getline(lnum), a:indexchar)
        if idx > maxidx
            let maxidx = idx
        endif
        let lnum = lnum + 1
    endwhile

    let lnum = a:firstline
    while lnum <= a:lastline
        let idx = match(getline(lnum), a:indexchar)
        if idx > 0
            let spacenum = maxidx - idx
            let convertedline = substitute(getline(lnum), a:indexchar, repeat(" ", spacenum).a:indexchar, "")
            call setline(lnum, convertedline)
        endif
        let lnum = lnum + 1
    endwhile
endfunction

" 各種言語用設定
autocmd FileType vue :setlocal filetype=html

" オムニ補完
"autocmd FileType *
"\   if &l:omnifunc == ''
"\ |   setlocal omnifunc=syntaxcomplete#Complete
"\ | endif

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

" タグファイル探索
se tags=.tags;/;

augroup ctags
  autocmd!
  autocmd BufWritePost * call Execute_ctags()
augroup END

function! Execute_ctags() abort
    let tag_name = '.tags'
    let tags_path = findfile(tag_name , '.;')

    if tags_path ==# ''
        return
    endif

    let tags_dirpath = fnamemodify(tags_path, ':p:h')
    execute 'silent !cd ' . tags_dirpath . ' && ctags -R -f ' . tag_name . ' 2> /dev/null &'
endfunction

augroup vimrc_auto_reload
    autocmd!
    autocmd BufWritePost *.vim,*vimrc source ~/.vimrc
augroup END
