if exists('b:current_syntax')
finish
endif
syn case ignore
let s:urgency='urgency=\(low\|medium\|high\|emergency\|critical\)\( [^[:space:],][^,]*\)\='
let s:binNMU='binary-only=yes'
syn match debchangelogName	contained "^[[:alnum:]][[:alnum:].+-]\+ "
exe 'syn match debchangelogFirstKV	contained "; \('.s:urgency.'\|'.s:binNMU.'\)"'
exe 'syn match debchangelogOtherKV	contained ", \('.s:urgency.'\|'.s:binNMU.'\)"'
syn match debchangelogTarget	contained "\v %(frozen|unstable|sid|%(testing|%(old)=stable)%(-proposed-updates|-security)=|experimental|%(squeeze|wheezy|jessie)-%(backports%(-sloppy)=|lts|security)|stretch%(-backports%(-sloppy)=|-security)=|buster%(-backports|-security)=|bullseye|%(devel|precise|trusty|vivid|wily|xenial|yakkety|zesty|artful|bionic|cosmic|disco|eoan)%(-%(security|proposed|updates|backports|commercial|partner))=)+"
syn match debchangelogVersion	contained "(.\{-})"
syn match debchangelogCloses	contained "closes:\_s*\(bug\)\=#\=\_s\=\d\+\(,\_s*\(bug\)\=#\=\_s\=\d\+\)*"
syn match debchangelogLP	contained "\clp:\s\+#\d\+\(,\s*#\d\+\)*"
syn match debchangelogEmail	contained "[_=[:alnum:].+-]\+@[[:alnum:]./\-]\+"
syn match debchangelogEmail	contained "<.\{-}>"
syn region debchangelogHeader start="^[^ ]" end="$" contains=debchangelogName,debchangelogFirstKV,debchangelogOtherKV,debchangelogTarget,debchangelogVersion,debchangelogBinNMU oneline
syn region debchangelogFooter start="^ [^ ]" end="$" contains=debchangelogEmail oneline
syn region debchangelogEntry start="^  " end="$" contains=debchangelogCloses,debchangelogLP oneline
hi def link debchangelogHeader  Error
hi def link debchangelogFooter  Identifier
hi def link debchangelogEntry   Normal
hi def link debchangelogCloses  Statement
hi def link debchangelogLP      Statement
hi def link debchangelogFirstKV Identifier
hi def link debchangelogOtherKV Identifier
hi def link debchangelogName    Comment
hi def link debchangelogVersion Identifier
hi def link debchangelogTarget  Identifier
hi def link debchangelogEmail   Special
let b:current_syntax = 'debchangelog'
