if (exists("b:did_ftplugin"))
finish
endif
runtime! ftplugin/git.vim
let b:did_ftplugin = 1
setlocal comments=:# commentstring=#\ %s formatoptions-=t
setlocal nomodeline
if !exists("b:undo_ftplugin")
let b:undo_ftplugin = ""
endif
let b:undo_ftplugin = b:undo_ftplugin."|setl com< cms< fo< ml<"
function! s:choose(word)
s/^\(\w\+\>\)\=\(\s*\)\ze\x\{4,40\}\>/\=(strlen(submatch(1)) == 1 ? a:word[0] : a:word) . substitute(submatch(2),'^$',' ','')/e
endfunction
function! s:cycle()
call s:choose(get({'s':'edit','p':'squash','e':'reword','r':'fixup'},getline('.')[0],'pick'))
endfunction
command! -buffer -bar Pick   :call s:choose('pick')
command! -buffer -bar Squash :call s:choose('squash')
command! -buffer -bar Edit   :call s:choose('edit')
command! -buffer -bar Reword :call s:choose('reword')
command! -buffer -bar Fixup  :call s:choose('fixup')
command! -buffer -bar Cycle  :call s:cycle()
if exists("g:no_plugin_maps") || exists("g:no_gitrebase_maps")
finish
endif
nnoremap <buffer> <expr> K col('.') < 7 && expand('<Lt>cword>') =~ '\X' && getline('.') =~ '^\w\+\s\+\x\+\>' ? 'wK' : 'K'
let b:undo_ftplugin = b:undo_ftplugin . "|nunmap <buffer> K"
