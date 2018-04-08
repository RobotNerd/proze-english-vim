" Syntax setup
if exists('b:current_syntax') && b:current_syntax == 'prose'
  finish
endif

" bold
syn region proseBold start=+__+ end=+\v__|\n\n+

" italics
syn region proseItalic start=+*+ end=+\v*|\n\n+

" quoted strings
syn region proseString start=+"+ end=+\v"|\n\n+ contains=proseBold,proseItalic

" Structural markup
syn match proseStructuralMarkup "\v\c(title|chapter|author|section):(.*)\n"
syn match proseStructuralMarkup "\v^---\s*$\n"

" TODO, BUG, etc. tags
" - must not have an adjacent alphabetic or underscore
syn match proseTodo /\v([A-Za-z_^])@<!(.)@<=(FIXME|IMPORTANT|NOTE|TODO)([A-Za-z_])@!/ contained

" comment
syn region proseComment start=+\v(\\#?)@<!##+ end=+$+ keepend contains=proseTodo
syn region proseComment start=+\v\\@<!###+ end=+\v\\@<!###+ keepend contains=proseTodo

" bracket
syn region proseBracket start=+\v\\@<!\[+ end=+\v\\@<!\]+ keepend contains=proseTodo

hi def link proseBold Statement
hi def link proseItalic Boolean
hi def link proseString String
hi def link proseStructuralMarkup Identifier
hi def link proseTodo Todo
hi def link proseBracket Debug
hi def link proseComment Comment
hi def link proseComment Comment

" TODO: Options for highlighting names
" - Function
" - Special
" - Underlined
" - Debug
" - Typedef
" - Error

if !exists('b:current_syntax')
  let b:current_syntax = 'prose'
endif

" vim: fdm=marker
