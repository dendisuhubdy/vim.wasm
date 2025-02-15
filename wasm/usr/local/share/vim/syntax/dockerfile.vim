if exists("b:current_syntax")
finish
endif
let b:current_syntax = "dockerfile"
syntax case ignore
syntax match dockerfileKeyword /\v^\s*(ONBUILD\s+)?(ADD|ARG|CMD|COPY|ENTRYPOINT|ENV|EXPOSE|FROM|HEALTHCHECK|LABEL|MAINTAINER|RUN|SHELL|STOPSIGNAL|USER|VOLUME|WORKDIR)\s/
syntax region dockerfileString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax match dockerfileComment "\v^\s*#.*$"
hi def link dockerfileString String
hi def link dockerfileKeyword Keyword
hi def link dockerfileComment Comment
