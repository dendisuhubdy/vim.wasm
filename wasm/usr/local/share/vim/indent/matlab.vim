if exists('b:did_indent') | finish | endif
let b:did_indent = 1
setlocal indentexpr=GetMatlabIndent()
setlocal indentkeys=!,o,O,e,0=end,0=elseif,0=case,0=otherwise,0=catch,0=function,0=elsei
let b:MATLAB_function_indent = get(g:, 'MATLAB_function_indent', 2)
let b:MATLAB_lasttick = -1
let b:MATLAB_lastline = -1
let b:MATLAB_waslc = 0
let b:MATLAB_bracketlevel = 0
if exists("*GetMatlabIndent") | finish | endif
let s:keepcpo = &cpo
set cpo&vim
let s:end = '\<end\>\%([^(]*)\)\@!' " Array indexing heuristic
let s:open_pat = 'for\|if\|parfor\|spmd\|switch\|try\|while\|classdef\|properties\|methods\|events\|enumeration'
let s:dedent_pat = '\C^\s*\zs\<\%(end\|else\|elseif\|catch\|\(case\|otherwise\|function\)\)\>'
let s:start_pat = '\C\<\%(function\|' . s:open_pat . '\)\>'
let s:bracket_pair_pat = '\(\[\|{\)\|\(\]\|}\)'
let s:zflag = has('patch-7.4.984') ? 'z' : ''
function! s:IsCommentOrString(lnum, col)
return synIDattr(synID(a:lnum, a:col, 1), "name") =~# 'matlabComment\|matlabMultilineComment\|matlabString'
endfunction
function! s:IsLineContinuation(lnum)
let l = getline(a:lnum) | let c = -3
while 1
let c = match(l, '\.\{3}', c + 3)
if c == -1 | return 0
elseif !s:IsCommentOrString(a:lnum, c) | return 1 | endif
endwhile
endfunction
function! s:SubmatchCount(lnum, pattern, ...)
let endcol = a:0 >= 1 ? a:1 : 1 / 0 | let x = [0, 0, 0, 0]
call cursor(a:lnum, 1)
while 1
let [lnum, c, submatch] = searchpos(a:pattern, 'cpe' . s:zflag, a:lnum)
if !submatch || c >= endcol | break | endif
if !s:IsCommentOrString(lnum, c) | let x[submatch - 2] += 1 | endif
if cursor(0, c + 1) == -1 || col('.') == c | break | endif
endwhile
return x
endfunction
function! s:GetOpenCloseCount(lnum, pattern, ...)
let counts = call('s:SubmatchCount', [a:lnum, a:pattern] + a:000)
return counts[0] - counts[1]
endfunction
function! GetMatlabIndent()
let prevlnum = prevnonblank(v:lnum - 1)
if b:MATLAB_lasttick != b:changedtick || b:MATLAB_lastline != prevlnum
let b:MATLAB_bracketlevel = 0
let previndent = indent(prevlnum) | let l = prevlnum
while 1
let l = prevnonblank(l - 1) | let indent = indent(l)
if l <= 0 || previndent < indent | break | endif
let b:MATLAB_bracketlevel += s:GetOpenCloseCount(l, s:bracket_pair_pat)
if previndent != indent | break | endif
endwhile
let b:MATLAB_waslc = s:IsLineContinuation(prevlnum - 1)
endif
let above_lc = b:MATLAB_lasttick == b:changedtick && prevlnum != v:lnum - 1 && b:MATLAB_lastline == prevlnum ? 0 : s:IsLineContinuation(v:lnum - 1)
let pair_pat = '\C\<\(' . s:open_pat . '\|'
\ . (b:MATLAB_function_indent == 1 ? '^\@<!' : '')
\ . (b:MATLAB_function_indent >= 1 ? 'function\|' : '')
\ . '\|\%(^\s*\)\@<=\%(else\|elseif\|case\|otherwise\|catch\)\)\>'
\ . '\|\S\s*\zs\(' . s:end . '\)'
let [open, close, b_open, b_close] = prevlnum ? s:SubmatchCount(prevlnum,
\ pair_pat . '\|' . s:bracket_pair_pat) : [0, 0, 0, 0]
let curbracketlevel = b:MATLAB_bracketlevel + b_open - b_close
call cursor(v:lnum, 1)
let submatch = search(s:dedent_pat, 'cp' . s:zflag, v:lnum)
if submatch && !s:IsCommentOrString(v:lnum, col('.'))
let [lnum, col] = searchpairpos(s:start_pat, '',  '\C' . s:end, 'bW', 's:IsCommentOrString(line("."), col("."))')
let result = lnum ? indent(lnum) + shiftwidth() * (s:GetOpenCloseCount(lnum, pair_pat, col) + submatch == 2) : 0
else
let result = indent(prevlnum) + shiftwidth() * (open - close
\ + (b:MATLAB_bracketlevel ? -!curbracketlevel : !!curbracketlevel)
\ + (curbracketlevel <= 0) * (above_lc - b:MATLAB_waslc))
endif
let b:MATLAB_waslc = above_lc
let b:MATLAB_bracketlevel = curbracketlevel
let b:MATLAB_lasttick = b:changedtick
let b:MATLAB_lastline = v:lnum
return result
endfunction
let &cpo = s:keepcpo
unlet s:keepcpo
