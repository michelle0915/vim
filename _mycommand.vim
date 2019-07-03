:command! ReloadVimrc :source $VIM/_gvimrc
:command! -nargs=1 RenameCurrentFile :call rename(expand('%'), '<args>')
:command! -nargs=1 TagWrap normal cat<<args>></<args>><ESC>F>p
:command! -nargs=+ CreateTag :call CreateTag(<f-args>) 
:command! Ascii2Native :call Ascii2Native()
:autocmd FileType perl command! AddBreakPoint :call AddBreakPoint()
:autocmd FileType php noremap <C-F5> :!start php %<CR>
:autocmd FileType php inoremap <C-CR> ."\n";
:autocmd BufNewFile,BufRead *.tsv  noremap <C-F5> :call ShowMap("\t")<cr>
:autocmd BufNewFile,BufRead *.csv  noremap <C-F5> :call ShowMap(",")<cr>
:autocmd BufRead,BufNewFile *.nml set filetype=nml

""""ASCII2NATIVE変換
function! Ascii2Native()
    let s:originalLine = getline(".")
    let s:replaceLine = ""

    let s:replaceLine = substitute(s:originalLine, '\\u\([a-z0-9]\{4}\)', '\=nr2char("0x".submatch(1))', "g")
    call setline(line("."), s:replaceLine)

    return 0
endfunction

"dw cwが単語単位でうまく動かない
function! SkipMove(key)
    execute "normal! " . a:key

    let s:skipChars = "(){}[]<>\",\.'=|:;"
    while(stridx(s:skipChars, getline(".")[col(".") - 1]) != -1)
        execute "normal! " . a:key
    endwhile

    return 0
endfunction

""""行移動
function! MoveLine(direction)
    let s:currentLine = line(".")
    let s:minLine = 1
    let s:maxLine = line("$")

    "下移動
    if a:direction == "DOWN"
        if s:currentLine == s:maxLine
            "最下行の場合、下に新たに空行を追加して移動
            execute "normal! ddo\<ESC>p"
        else
            execute "normal! ddp"
        endif

    "上移動
    elseif a:direction == "UP"
        if s:currentLine == s:minLine
            "最上行の場合、何もしない
            return
        elseif s:currentLine == s:maxLine
            "最下行の場合、カーソル行が上にずれるため、kが必要無い
            execute "normal! ddP"
        else
            execute "normal! ddkP"
        endif
    endif
endfunction

""""カウンター
function! Counter(init, inc)
    ""初期値
    let cnt = 0
    if type(a:init) == type(v:t_number)
        let cnt = a:init
    endif

    ""増加数
    let inc = 1
    if type(a:inc) == type(v:t_number)
        let inc = a:inc
    endif

    ""戻り値となる関数
    function! InnerCount() closure
        let retval = cnt
        let cnt += inc
        return retval
    endfunction

    return funcref('InnerCount')
endfunction

""""Perlブレークポイント挿入
function! AddBreakPoint()
    let s:bpString = "$DB::single = 1;"
    execute "normal! O" . s:bpString
endfunction

"カーソル位置のカラムのヘッダーを表示する
"TODO マルチバイト文字に対応していない
function! ShowHeader(delimiter)
    
    "デリミターの指定
    let s:delimiter = a:delimiter

    let s:strHeader = getline(1)
    let s:strCurrentLine = getline(line('.'))
    let s:headers = split(s:strHeader, s:delimiter)
    let s:columns = split(s:strCurrentLine, s:delimiter)

    "カーソル位置が何カラム目かを判別する
    let s:strCurrentLineToCursor = strcharpart(s:strCurrentLine, 0, col('.'))
    let s:nthColumn = len(split(s:strCurrentLineToCursor, s:delimiter)) - 1

    echo s:headers[s:nthColumn]
    return
endfunction

"ヘッダーとデータのマップを表示する
"TODO 行末が値なしの場合、配列数が一致しなくなる
function! ShowMap(delimiter)

    "デリミターの指定
    let s:delimiter = a:delimiter

    let s:strHeader = getline(1)
    let s:strCurrentLine = getline(line('.'))
    let s:headers = split(s:strHeader, s:delimiter)
    let s:columns = split(s:strCurrentLine, s:delimiter)

    "ヘッダーとデータのカラム数が不一致の場合エラー
    if len(s:headers) != len(s:columns)
        echo "ヘッダーとデータのカラム数が一致しません"
        return
    endif

    "カラム毎にヘッダーと値を表示
    for n in range(0, len(s:headers) - 1)
        echo s:headers[n] . ' => ' . s:columns[n]
    endfor
    
    return
endfunction


function! CreateTag(tagname, ...)
    "開始タグとタグ名
    let s:output = '<'.a:tagname

    "各属性を追加
    for s:attr in a:000
        let s:output .= ' '.s:attr.'=""'
    endfor

    "終了タグ
    let s:output .= '></'.a:tagname.'>'

    execute "normal! O".s:output
endfunction
