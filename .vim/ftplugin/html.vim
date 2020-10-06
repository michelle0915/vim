" prevent load twice
if exists("b:did_html_plugin")
    finish
endif
let b:did_html_plugin = 1

setlocal shiftwidth=2

inoremap <buffer> >> ><esc>:call AddEndTag()<cr>cit
inoremap <buffer> ><cr> ><esc>:call AddEndTag()<cr>cit<cr><esc><s-o>
nnoremap <silent> <buffer> <leader>j :call JumpToPairTag()<cr>

" functions
if exists("s:did_html_func")
    finish
endif
let s:did_html_func = 1

function! AddEndTag()
    execute "normal! va<\<esc>"
    let tagstring = GetSelectedString()
    echo tagstring
    " 終了タグまたは対のないタグの場合、なにもしない
    if strcharpart(tagstring, 0, 2) == '</' || strcharpart(tagstring, strchars(tagstring) - 2) == '/>'
        return
    endif

    " タグ名のみ取得
    let tagname = strcharpart(tagstring, 1, strchars(tagstring) - 2)
    " 属性値が設定されている場合
    let spaceIndex = stridx(tagname, " ")
    if (spaceIndex != -1)
        let tagname = strpart(tagname, 0, spaceIndex)
    endif

    execute "normal! %a</".tagname.">"

endfunction

" 対となる開始・終了タグに移動する
function! JumpToPairTag()
    " カーソル位置の括弧を含むタグ文字列を取得（マルチバイト文字も考慮して、以後扱う）
    execute "normal! va<\<esc>"
    let tagstring = GetSelectedString()

    " 対のないタグの場合、なにもしない
    if strcharpart(tagstring, strchars(tagstring) - 2) == '/>'
        return
    endif

    " タグ名のみ取得
    let tagname = strcharpart(tagstring, 1, strchars(tagstring) - 2)
    " 属性値が設定されている場合
    let spaceIndex = stridx(tagname, " ")
    if (spaceIndex != -1)
        let tagname = strpart(tagname, 0, spaceIndex)
    endif

    " 開始/終了タグに応じて下/上検索
    if tagname[0] != '/'
        let res = searchpair('<'.tagname.'.\{-}>', '', '</'.tagname.'>', 'W')
    else
        let tagname = tagname[1:]
        let res = searchpair('<'.tagname.'.\{-}>', '', '</'.tagname.'>', 'bW')
    endif

endfunction
