if exists("b:did_perl_plugin")
    finish
endif
let b:did_perl_plugin = 1

setlocal iskeyword+=:
setlocal complete+=k~/.vim/perl_module_list
