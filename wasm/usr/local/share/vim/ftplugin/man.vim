if &filetype == "man"
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1
endif
let s:cpo_save = &cpo
set cpo-=C
if &filetype == "man"
setlocal iskeyword+=\.,-
let b:undo_ftplugin = "setlocal iskeyword<"
if !exists("no_plugin_maps") && !exists("no_man_maps")
if !hasmapto('<Plug>ManBS')
nmap <buffer> <LocalLeader>h <Plug>ManBS
let b:undo_ftplugin = b:undo_ftplugin
\ . '|silent! nunmap <buffer> <LocalLeader>h'
endif
nnoremap <buffer> <Plug>ManBS :%s/.\b//g<CR>:setl nomod<CR>''
nnoremap <buffer> <c-]> :call <SID>PreGetPage(v:count)<CR>
nnoremap <buffer> <c-t> :call <SID>PopPage()<CR>
nnoremap <buffer> <silent> q :q<CR>
let b:undo_ftplugin = b:undo_ftplugin
\ . '|silent! nunmap <buffer> <Plug>ManBS'
\ . '|silent! nunmap <buffer> <c-]>'
\ . '|silent! nunmap <buffer> <c-t>'
\ . '|silent! nunmap <buffer> q'
endif
if exists('g:ft_man_folding_enable') && (g:ft_man_folding_enable == 1)
setlocal foldmethod=indent foldnestmax=1 foldenable
let b:undo_ftplugin = b:undo_ftplugin
\ . '|silent! setl fdm< fdn< fen<'
endif
endif
if exists(":Man") != 2
com -nargs=+ -complete=shellcmd Man call s:GetPage(<q-mods>, <f-args>)
nmap <Leader>K :call <SID>PreGetPage(0)<CR>
nmap <Plug>ManPreGetPage :call <SID>PreGetPage(0)<CR>
endif
if !exists("s:man_tag_depth")
let s:man_tag_depth = 0
let s:man_sect_arg = ""
let s:man_find_arg = "-w"
try
if !has("win32") && $OSTYPE !~ 'cygwin\|linux' && system('uname -s') =~ "SunOS" && system('uname -r') =~ "^5"
let s:man_sect_arg = "-s"
let s:man_find_arg = "-l"
endif
catch /E145:/
endtry
func <SID>PreGetPage(cnt)
if a:cnt == 0
let old_isk = &iskeyword
if &ft == 'man'
setl iskeyword+=(,)
endif
let str = expand("<cword>")
let &l:iskeyword = old_isk
let page = substitute(str, '(*\(\k\+\).*', '\1', '')
let sect = substitute(str, '\(\k\+\)(\([^()]*\)).*', '\2', '')
if match(sect, '^[0-9 ]\+$') == -1
let sect = ""
endif
if sect == page
let sect = ""
endif
else
let sect = a:cnt
let page = expand("<cword>")
endif
call s:GetPage(sect, page)
endfunc
func <SID>GetCmdArg(sect, page)
if a:sect == ''
return a:page
endif
return s:man_sect_arg.' '.a:sect.' '.a:page
endfunc
func <SID>FindPage(sect, page)
let where = system("man ".s:man_find_arg.' '.s:GetCmdArg(a:sect, a:page))
if where !~ "^/"
if matchstr(where, " [^ ]*$") !~ "^ /"
return 0
endif
endif
return 1
endfunc
func <SID>GetPage(cmdmods, ...)
if a:0 >= 2
let sect = a:1
let page = a:2
elseif a:0 >= 1
let sect = ""
let page = a:1
else
return
endif
if page == '<cword>'
let page = expand('<cword>')
endif
if sect != "" && s:FindPage(sect, page) == 0
let sect = ""
endif
if s:FindPage(sect, page) == 0
echo "\nCannot find a '".page."'."
return
endif
exec "let s:man_tag_buf_".s:man_tag_depth." = ".bufnr("%")
exec "let s:man_tag_lin_".s:man_tag_depth." = ".line(".")
exec "let s:man_tag_col_".s:man_tag_depth." = ".col(".")
let s:man_tag_depth = s:man_tag_depth + 1
if &filetype != "man"
let thiswin = winnr()
exe "norm! \<C-W>b"
if winnr() > 1
exe "norm! " . thiswin . "\<C-W>w"
while 1
if &filetype == "man"
break
endif
exe "norm! \<C-W>w"
if thiswin == winnr()
break
endif
endwhile
endif
if &filetype != "man"
if exists("g:ft_man_open_mode")
if g:ft_man_open_mode == "vert"
vnew
elseif g:ft_man_open_mode == "tab"
tabnew
else
new
endif
else
if a:cmdmods != ''
exe a:cmdmods . ' new'
else
new
endif
endif
setl nonu fdc=0
endif
endif
silent exec "edit $HOME/".page.".".sect."~"
setl buftype=nofile noswapfile
setl ma nonu nornu nofen
silent exec "norm! 1GdG"
let unsetwidth = 0
if empty($MANWIDTH)
let $MANWIDTH = winwidth(0)
let unsetwidth = 1
endif
if !exists('s:env_has_u')
call system('env -u x true')
let s:env_has_u = (v:shell_error == 0)
endif
let env_cmd = s:env_has_u ? 'env -u MANPAGER' : 'env MANPAGER=cat'
let man_cmd = env_cmd . ' man ' . s:GetCmdArg(sect, page) . ' | col -b'
silent exec "r !" . man_cmd
if unsetwidth
let $MANWIDTH = ''
endif
while line('$') > 1 && getline(1) =~ '^\s*$'
silent keepj norm! ggdd
endwhile
while line('$') > 1 && getline('$') =~ '^\s*$'
silent keepj norm! Gdd
endwhile
1
setl ft=man nomod
setl bufhidden=hide
setl nobuflisted
setl noma
endfunc
func <SID>PopPage()
if s:man_tag_depth > 0
let s:man_tag_depth = s:man_tag_depth - 1
exec "let s:man_tag_buf=s:man_tag_buf_".s:man_tag_depth
exec "let s:man_tag_lin=s:man_tag_lin_".s:man_tag_depth
exec "let s:man_tag_col=s:man_tag_col_".s:man_tag_depth
exec s:man_tag_buf."b"
exec s:man_tag_lin
exec "norm! ".s:man_tag_col."|"
exec "unlet s:man_tag_buf_".s:man_tag_depth
exec "unlet s:man_tag_lin_".s:man_tag_depth
exec "unlet s:man_tag_col_".s:man_tag_depth
unlet s:man_tag_buf s:man_tag_lin s:man_tag_col
endif
endfunc
endif
let &cpo = s:cpo_save
unlet s:cpo_save
