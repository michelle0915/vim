compiler perl

augroup perl_synwrite
    exec "au BufWriteCmd,FileWriteCmd " . expand("%") . " :w |:silent make |:redraw! |:cwindow"
augroup END

"if exists("b:did_perl_synwrite")
"    finish
"endif
"let b:did_perl_synwrite = 1
"
"if (exists("perl_synwrite_au") && !exists("b:perl_synwrite_au"))
"    let b:perl_synwrite_au = perl_synwrite_au
"elseif !exists("b:perl_synwrite_au")
"    let b:perl_synwrite_au = 0
"endif
"
"if (exists("perl_synwrite_qf") && !exists("b:perl_synwrite_qf"))
"    let b:perl_synwrite_qf = perl_synwrite_qf
"elseif !exists("b:perl_synwrite_qf")
"    let b:perl_synwrite_qf = 0
"endif
"
"function! s:PerlSynDo(do_anyway, do_command)
"    let command = "!perl -c"
"
"    if (b:perl_synwrite_qf)
"        let $VI_QUICKFIX_SOURCEFILE = expand("%")
"        let command = command . " -MVi::QuickFix"
"    endif
"
"    if (match(getline(1), "^#!.\\+perl.\\+-T") == 0)
"        let command = command . " -T"
"    endif
"
"    exec "write" command
"
"    silent! cgetfile
"    if !v:shell_error || a:do_anyway
"        exec a:do_command
"        set nomod
"    endif
"endfunction
"
"if (b:perl_synwrite_au > 0)
"    let b:undo_ftplugin = "au! perl_synwrite * " . expand("%")
"    augroup perl_synwrite
"        exec "au BufWriteCmd,FileWriteCmd " . expand("%") . " call s:PerlSynDo(0, \"write <afile>\")"
"    augroup END
"endif
"
"command -buffer -nargs=* -complete=file -range=% -bang Write call s:PerlSynDo("<bang>"=="!", "<line1>,<line2>write<bang> <args>")
