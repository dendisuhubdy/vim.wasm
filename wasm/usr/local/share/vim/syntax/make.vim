if exists("b:current_syntax")
finish
endif
let s:cpo_save = &cpo
set cpo&vim
syn match makeSpecial	"^\s*[@+-]\+"
syn match makeNextLine	"\\\n\s*"
syn match makePreCondit	"^ *\(ifn\=\(eq\|def\)\>\|else\(\s\+ifn\=\(eq\|def\)\)\=\>\|endif\>\)"
syn match makeInclude	"^ *[-s]\=include"
syn match makeStatement	"^ *vpath"
syn match makeExport    "^ *\(export\|unexport\)\>"
syn match makeOverride	"^ *override"
hi link makeOverride makeStatement
hi link makeExport makeStatement
syn region makeDefine start="^\s*define\s" end="^\s*endef\s*\(#.*\)\?$" contains=makeStatement,makeIdent,makePreCondit,makeDefine
syn case ignore
syn match makeInclude	"^!\s*include"
syn match makePreCondit "^!\s*\(cmdswitches\|error\|message\|include\|if\|ifdef\|ifndef\|else\|else\s*if\|else\s*ifdef\|else\s*ifndef\|endif\|undef\)\>"
syn case match
syn region makeIdent	start="\$(" skip="\\)\|\\\\" end=")" contains=makeStatement,makeIdent,makeSString,makeDString
syn region makeIdent	start="\${" skip="\\}\|\\\\" end="}" contains=makeStatement,makeIdent,makeSString,makeDString
syn match makeIdent	"\$\$\w*"
syn match makeIdent	"\$[^({]"
syn match makeIdent	"^ *[^:#= \t]*\s*[:+?!*]="me=e-2
syn match makeIdent	"^ *[^:#= \t]*\s*="me=e-1
syn match makeIdent	"%"
syn match makeConfig "@[A-Za-z0-9_]\+@"
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1 nextgroup=makeSource
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2 nextgroup=makeSource
syn region makeTarget   transparent matchgroup=makeTarget start="^[~A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"rs=e-1 end=";"re=e-1,me=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
syn match makeTarget		"^[~A-Za-z0-9_./$()%*@-][A-Za-z0-9_./\t $()%*@-]*::\=\s*$" contains=makeIdent,makeSpecTarget,makeComment skipnl nextgroup=makeCommands,makeCommandError
syn region makeSpecTarget	transparent matchgroup=makeSpecTarget start="^\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDARY\)\>\s*:\{1,2}[^:=]"rs=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
syn match makeSpecTarget		"^\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDARY\)\>\s*::\=\s*$" contains=makeIdent,makeComment skipnl nextgroup=makeCommands,makeCommandError
syn match makeCommandError "^\s\+\S.*" contained
syn region makeCommands start=";"hs=s+1 start="^\t" end="^[^\t#]"me=e-1,re=e-1 end="^$" contained contains=makeCmdNextLine,makeSpecial,makeComment,makeIdent,makePreCondit,makeDefine,makeDString,makeSString nextgroup=makeCommandError
syn match makeCmdNextLine	"\\\n."he=e-1 contained
syn match makeStatement contained "(\(abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|file\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|guile\|if\|info\|join\|lastword\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|subst\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\>"ms=s+1
if exists("make_microsoft")
syn match  makeComment "#.*" contains=@Spell,makeTodo
elseif !exists("make_no_comments")
syn region  makeComment	start="#" end="^$" end="[^\\]$" keepend contains=@Spell,makeTodo
syn match   makeComment	"#$" contains=@Spell
endif
syn keyword makeTodo TODO FIXME XXX contained
syn match makeEscapedChar	"\\[^$]"
syn region  makeDString start=+\(\\\)\@<!"+  skip=+\\.+  end=+"+  contains=makeIdent
syn region  makeSString start=+\(\\\)\@<!'+  skip=+\\.+  end=+'+  contains=makeIdent
syn region  makeBString start=+\(\\\)\@<!`+  skip=+\\.+  end=+`+  contains=makeIdent,makeSString,makeDString,makeNextLine
syn sync minlines=20 maxlines=200
syn sync match makeCommandSync groupthere NONE "^[^\t#]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}\s*$"
hi def link makeNextLine	makeSpecial
hi def link makeCmdNextLine	makeSpecial
hi def link makeSpecTarget	Statement
if !exists("make_no_commands")
hi def link makeCommands	Number
endif
hi def link makeImplicit	Function
hi def link makeTarget		Function
hi def link makeInclude		Include
hi def link makePreCondit	PreCondit
hi def link makeStatement	Statement
hi def link makeIdent		Identifier
hi def link makeSpecial		Special
hi def link makeComment		Comment
hi def link makeDString		String
hi def link makeSString		String
hi def link makeBString		Function
hi def link makeError		Error
hi def link makeTodo		Todo
hi def link makeDefine		Define
hi def link makeCommandError	Error
hi def link makeConfig		PreCondit
let b:current_syntax = "make"
let &cpo = s:cpo_save
unlet s:cpo_save
