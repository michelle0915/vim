autocmd FileType lisp :set lispwords-=if

autocmd FileType lisp :inoremap ' '
autocmd FileType lisp :nnoremap <silent> <c-F5> :call StartRepl()<cr>
autocmd FileType lisp :nnoremap <silent> <c-cr> va(<esc>:call Repl()<cr>
autocmd FileType lisp :vnoremap <silent> <c-cr> <esc>`<V`><esc>:call Repl()<cr>
autocmd FileType lisp :command! Loadfile :call LoadFile()

autocmd FileType lisp :abbreviate dfp defparameter
autocmd FileType lisp :abbreviate dfn defun
autocmd FileType lisp :abbreviate dfm defmacro
autocmd FileType lisp :abbreviate dfst defstruct
autocmd FileType lisp :abbreviate lmd lambda


function! Repl()
    call ReplClient(GetSelectedString())
endfunction

function! ReplClient(string)
    if !exists("t:ch") || ch_status(t:ch) != "open"
        let t:ch = ch_open("localhost:9000", {"mode": "raw", "callback": "Handler"})
    endif

    let backflg = 0
    if expand('%') == "repl.lisp"
        execute "normal! G"
    else
        execute "normal! \<c-w>wG"
        let backflg = 1
    endif

    "画面表示時、末尾の改行は除く
    let str = substitute(a:string, "\n$", "", "")
    execute "normal! oIN>>> " . str . "\<esc>=%"

    if !backflg
        execute "normal! G"
    else
        execute "normal! \<c-w>p"
    endif

    "サーバ送信時、末尾に改行を付ける
    let str = str . "\n"
    call ch_sendraw(t:ch, str)
endfunction

function! Handler(channel, msg)
    let backflg = 0
    if expand('%') == "repl.lisp"
        execute "normal! G"
    else
        execute "normal! \<c-w>wG"
        let backflg = 1
    endif

    execute "normal! oOUT>>> " . a:msg . "\<esc>=%"

    if !backflg
        execute "normal! G"
    else
        execute "normal! \<c-w>p"
    endif

    call ch_close(t:ch)
endfunction

function! StartRepl()
    execute '!start clisp -i '.$VIM.'/replserver.lisp'
    execute "vnew repl.lisp"
    execute "normal! \<c-w>x"
endfunction

function! LoadFile()
    call ReplClient('(load "'.expand('%:p').'")')
endfunction
