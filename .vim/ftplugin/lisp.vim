if exists("b:did_lisp_plugin")
    finish
endif
let b:did_lisp_plugin = 1

setlocal lispwords-=if
setlocal iskeyword+=:
setlocal complete+=k~/.vim/cl-symbol-list

inoremap <buffer> ' '
nnoremap <buffer> <silent> <F5> :call StartRepl()<cr>
nnoremap <buffer> <silent> <cr> va(<esc>:call Repl()<cr>
vnoremap <buffer> <silent> <cr> <esc>`<v`><esc>:call Repl()<cr>
command! Loadfile :call LoadFile()
command! Macroexpand :call Macroexpand()

abbreviate <buffer> dfp defparameter
abbreviate <buffer> dfn defun
abbreviate <buffer> dfm defmacro
abbreviate <buffer> dfst defstruct
abbreviate <buffer> lmd lambda

if exists("s:did_html_func")
    finish
endif
let s:did_html_func = 1

let s:term_buf = 0
function! StartRepl()
    belowright vertical let s:term_buf = term_start("rlwrap sbcl --noinform", {"term_finish": "close"})
    execute "normal! \<c-w>p"
endfunction

function! Repl()
    let msg = GetSelectedString() . "\<cr>"
    call term_sendkeys(s:term_buf, msg)
endfunction

function! LoadFile()
    let msg = '(load "'.expand('%:p').'")' . "\<cr>"
    call term_sendkeys(s:term_buf, msg)
endfunction

function! Macroexpand()
    execute "normal! va(\<esc>"
    let msg = "(macroexpand-1 '" . GetSelectedString() . ")\<cr>"
    call term_sendkeys(s:term_buf, msg)
endfunction

"function! Repl()
"    call ReplClient(GetSelectedString())
"endfunction
"
"function! ReplClient(string)
"    if !exists("t:ch") || ch_status(t:ch) != "open"
"        let t:ch = ch_open("localhost:9000", {"mode": "raw", "callback": "Handler"})
"    endif
"
"    let backflg = 0
"    if expand('%:t') == "repl.lisp"
"        execute "normal! G"
"    else
"        execute "normal! \<c-w>wG"
"        let backflg = 1
"    endif
"
"    "画面表示時、末尾の改行は除く
"    let str = substitute(a:string, "\n$", "", "")
"    execute "normal! oIN >>> " . str . "\<esc>=%"
"
"    if !backflg
"        execute "normal! G"
"    else
"        execute "normal! \<c-w>p"
"    endif
"
"    "サーバ送信時、末尾に改行を付ける
"    let str = str . "\n"
"    call ch_sendraw(t:ch, str)
"endfunction
"
"function! Handler(channel, msg)
"    let backflg = 0
"    if expand('%:t') == "repl.lisp"
"        execute "normal! G"
"    else
"        execute "normal! \<c-w>wG"
"        let backflg = 1
"    endif
"
"    execute "normal! oOUT>>> " . substitute(a:msg, '\n\s\+', '\n', 'g') . "\<esc>=%"
"
"    if !backflg
"        execute "normal! G"
"    else
"        execute "normal! \<c-w>p"
"    endif
"
"    call ch_close(t:ch)
"endfunction
"
"function! StartRepl()
"    execute "vnew ~/repl.lisp"
"    execute "normal! \<c-w>x"
"endfunction
"
"function! LoadFile()
"    call ReplClient('(load "'.expand('%:p').'")')
"endfunction
