if exists("b:current_syntax")
finish
endif
let s:cpo_save = &cpo
set cpo&vim
syn case match
setlocal iskeyword+=$,@-@
syn match erlangComment           '%.*$' contains=erlangCommentAnnotation,erlangTodo
syn match erlangCommentAnnotation ' \@<=@\%(clear\|docfile\|end\|headerfile\|todo\|TODO\|type\|author\|copyright\|doc\|reference\|see\|since\|title\|version\|deprecated\|hidden\|private\|equiv\|spec\|throws\)' contained
syn match erlangCommentAnnotation /`[^']*'/ contained
syn keyword erlangTodo            TODO FIXME XXX contained
syn match erlangNumberInteger '\<\d\+\>'
syn match erlangNumberInteger '\<\%([2-9]\|[12]\d\|3[0-6]\)\+#[[:alnum:]]\+\>'
syn match erlangNumberFloat   '\<\d\+\.\d\+\%([eE][+-]\=\d\+\)\=\>'
syn region erlangString            start=/"/ end=/"/ contains=erlangStringModifier
syn region erlangQuotedAtom        start=/'/ end=/'/ contains=erlangQuotedAtomModifier
syn match erlangStringModifier     '\\\%(\o\{1,3}\|x\x\x\|x{\x\+}\|\^.\|.\)\|\~\%([ni~]\|\%(-\=\d\+\|\*\)\=\.\=\%(\*\|\d\+\)\=\%(\..\)\=[tl]*[cfegswpWPBX#bx+]\)' contained
syn match erlangQuotedAtomModifier '\\\%(\o\{1,3}\|x\x\x\|x{\x\+}\|\^.\|.\)' contained
syn match erlangModifier           '\$\%([^\\]\|\\\%(\o\{1,3}\|x\x\x\|x{\x\+}\|\^.\|.\)\)'
syn match erlangOperator   '==\|=:=\|/=\|=/=\|<\|=<\|>\|>=\|=>\|:=\|++\|--\|=\|!\|<-\|+\|-\|\*\|\/'
syn keyword erlangOperator div rem or xor bor bxor bsl bsr and band not bnot andalso orelse
syn match erlangBracket    '{\|}\|\[\|]\||\|||'
syn match erlangPipe       '|'
syn match erlangRightArrow '->'
syn match erlangAtom           '\<\l[[:alnum:]_@]*' contains=erlangBoolean
syn keyword erlangBoolean      true false contained
syn match erlangLocalFuncCall  '\<\a[[:alnum:]_@]*\>\%(\%(\s\|\n\|%.*\n\)*(\)\@=' contains=erlangBIF
syn match erlangLocalFuncRef   '\<\a[[:alnum:]_@]*\>\%(\%(\s\|\n\|%.*\n\)*/\)\@='
syn match erlangGlobalFuncCall '\<\%(\a[[:alnum:]_@]*\%(\s\|\n\|%.*\n\)*\.\%(\s\|\n\|%.*\n\)*\)*\a[[:alnum:]_@]*\%(\s\|\n\|%.*\n\)*:\%(\s\|\n\|%.*\n\)*\a[[:alnum:]_@]*\>\%(\%(\s\|\n\|%.*\n\)*(\)\@=' contains=erlangComment,erlangVariable
syn match erlangGlobalFuncRef  '\<\%(\a[[:alnum:]_@]*\%(\s\|\n\|%.*\n\)*\.\%(\s\|\n\|%.*\n\)*\)*\a[[:alnum:]_@]*\%(\s\|\n\|%.*\n\)*:\%(\s\|\n\|%.*\n\)*\a[[:alnum:]_@]*\>\%(\%(\s\|\n\|%.*\n\)*/\)\@=' contains=erlangComment,erlangVariable
syn match erlangVariable '\<[A-Z_][[:alnum:]_@]*'
syn match erlangMacro    '??\=[[:alnum:]_@]\+'
syn match erlangMacro    '\%(-define(\)\@<=[[:alnum:]_@]\+'
syn match erlangMap      '#'
syn match erlangRecord   '#\s*\l[[:alnum:]_@]*'
syn region erlangQuotedRecord        start=/#\s*'/ end=/'/ contains=erlangQuotedAtomModifier
syn match erlangShebang  '^#!.*'
syn match erlangBitType '\%(\/\%(\s\|\n\|%.*\n\)*\)\@<=\%(integer\|float\|binary\|bytes\|bitstring\|bits\|binary\|utf8\|utf16\|utf32\|signed\|unsigned\|big\|little\|native\|unit\)\%(\%(\s\|\n\|%.*\n\)*-\%(\s\|\n\|%.*\n\)*\%(integer\|float\|binary\|bytes\|bitstring\|bits\|binary\|utf8\|utf16\|utf32\|signed\|unsigned\|big\|little\|native\|unit\)\)*' contains=erlangComment
syn match erlangUnknownAttribute '^\s*-\%(\s\|\n\|%.*\n\)*\l[[:alnum:]_@]*' contains=erlangComment
syn match erlangAttribute '^\s*-\%(\s\|\n\|%.*\n\)*\%(behaviou\=r\|compile\|export\(_type\)\=\|file\|import\|module\|author\|copyright\|doc\|vsn\|on_load\)\>' contains=erlangComment
syn match erlangInclude   '^\s*-\%(\s\|\n\|%.*\n\)*\%(include\|include_lib\)\>' contains=erlangComment
syn match erlangRecordDef '^\s*-\%(\s\|\n\|%.*\n\)*record\>' contains=erlangComment
syn match erlangDefine    '^\s*-\%(\s\|\n\|%.*\n\)*\%(define\|undef\)\>' contains=erlangComment
syn match erlangPreCondit '^\s*-\%(\s\|\n\|%.*\n\)*\%(ifdef\|ifndef\|else\|endif\)\>' contains=erlangComment
syn match erlangType      '^\s*-\%(\s\|\n\|%.*\n\)*\%(spec\|type\|opaque\|callback\)\>' contains=erlangComment
syn keyword erlangKeyword after begin case catch cond end fun if let of
syn keyword erlangKeyword receive when try
syn keyword erlangBIF abs alive apply atom_to_binary atom_to_list contained
syn keyword erlangBIF binary_part binary_to_atom contained
syn keyword erlangBIF binary_to_existing_atom binary_to_float contained
syn keyword erlangBIF binary_to_integer bitstring_to_list contained
syn keyword erlangBIF binary_to_list binary_to_term bit_size contained
syn keyword erlangBIF byte_size check_old_code check_process_code contained
syn keyword erlangBIF concat_binary date delete_module demonitor contained
syn keyword erlangBIF disconnect_node element erase error exit contained
syn keyword erlangBIF float float_to_binary float_to_list contained
syn keyword erlangBIF garbage_collect get get_keys group_leader contained
syn keyword erlangBIF halt hd integer_to_binary integer_to_list contained
syn keyword erlangBIF iolist_to_binary iolist_size is_alive contained
syn keyword erlangBIF is_atom is_binary is_bitstring is_boolean contained
syn keyword erlangBIF is_float is_function is_integer is_list contained
syn keyword erlangBIF is_number is_pid is_port is_process_alive contained
syn keyword erlangBIF is_record is_reference is_tuple length link contained
syn keyword erlangBIF list_to_atom list_to_binary contained
syn keyword erlangBIF list_to_bitstring list_to_existing_atom contained
syn keyword erlangBIF list_to_float list_to_integer list_to_pid contained
syn keyword erlangBIF list_to_tuple load_module make_ref max min contained
syn keyword erlangBIF module_loaded monitor monitor_node node contained
syn keyword erlangBIF nodes now open_port pid_to_list port_close contained
syn keyword erlangBIF port_command port_connect pre_loaded contained
syn keyword erlangBIF process_flag process_flag process_info contained
syn keyword erlangBIF process purge_module put register registered contained
syn keyword erlangBIF round self setelement size spawn spawn_link contained
syn keyword erlangBIF spawn_monitor spawn_opt split_binary contained
syn keyword erlangBIF statistics term_to_binary throw time tl contained
syn keyword erlangBIF trunc tuple_size tuple_to_list unlink contained
syn keyword erlangBIF unregister whereis contained
syn sync match erlangSync grouphere NONE "^[a-z]\s*("
let b:erlang_syntax_synced = 1
let s:old_style = (exists("g:erlang_old_style_highlight") &&
\g:erlang_old_style_highlight == 1)
hi def link erlangComment Comment
hi def link erlangCommentAnnotation Special
hi def link erlangTodo Todo
hi def link erlangShebang Comment
hi def link erlangNumberInteger Number
hi def link erlangNumberFloat Float
hi def link erlangString String
if s:old_style
hi def link erlangQuotedAtom Type
else
hi def link erlangQuotedAtom String
endif
hi def link erlangStringModifier Special
hi def link erlangQuotedAtomModifier Special
hi def link erlangModifier Special
hi def link erlangOperator Operator
hi def link erlangRightArrow Operator
if s:old_style
hi def link erlangBracket Normal
hi def link erlangPipe Normal
else
hi def link erlangBracket Delimiter
hi def link erlangPipe Delimiter
endif
if s:old_style
hi def link erlangAtom Normal
hi def link erlangLocalFuncCall Normal
hi def link erlangLocalFuncRef Normal
hi def link erlangGlobalFuncCall Function
hi def link erlangGlobalFuncRef Function
hi def link erlangVariable Normal
hi def link erlangMacro Normal
hi def link erlangRecord Normal
hi def link erlangQuotedRecord Normal
hi def link erlangMap Normal
else
hi def link erlangAtom String
hi def link erlangLocalFuncCall Normal
hi def link erlangLocalFuncRef Normal
hi def link erlangGlobalFuncCall Normal
hi def link erlangGlobalFuncRef Normal
hi def link erlangVariable Identifier
hi def link erlangMacro Macro
hi def link erlangRecord Structure
hi def link erlangQuotedRecord Structure
hi def link erlangMap Structure
endif
if !s:old_style
hi def link erlangBitType Type
endif
if s:old_style
hi def link erlangAttribute Type
hi def link erlangMacroDef Type
hi def link erlangUnknownAttribute Normal
hi def link erlangInclude Type
hi def link erlangRecordDef Type
hi def link erlangDefine Type
hi def link erlangPreCondit Type
hi def link erlangType Type
else
hi def link erlangAttribute Keyword
hi def link erlangMacroDef Macro
hi def link erlangUnknownAttribute Normal
hi def link erlangInclude Include
hi def link erlangRecordDef Keyword
hi def link erlangDefine Define
hi def link erlangPreCondit PreCondit
hi def link erlangType Type
endif
hi def link erlangKeyword Keyword
hi def link erlangBIF Function
if s:old_style
hi def link erlangBoolean Statement
hi def link erlangExtra Statement
hi def link erlangSignal Statement
else
hi def link erlangBoolean Boolean
hi def link erlangExtra Statement
hi def link erlangSignal Statement
endif
let b:current_syntax = "erlang"
let &cpo = s:cpo_save
unlet s:cpo_save
