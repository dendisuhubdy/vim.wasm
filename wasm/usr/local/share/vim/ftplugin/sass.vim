if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1
let b:undo_ftplugin = "setl com< cms< def< inc< inex< ofu< sua<"
setlocal comments=://
setlocal commentstring=//\ %s
setlocal define=^\\s*\\%(@mixin\\\|=\\)
setlocal includeexpr=substitute(v:fname,'\\%(.*/\\\|^\\)\\zs','_','')
setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.sass,.scss,.css
let &l:include = '^\s*@import\s\+\%(url(\)\=["'']\='
