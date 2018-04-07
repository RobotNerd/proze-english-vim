" Syntax setup
if exists('b:current_syntax') && b:current_syntax == 'prose'
  finish
endif

" quoted strings
syn region proseString start=+"+ end=+\v"|\n\n+

" Metadata markup
syn match proseMetadata /\vTitle:/

" " section header
" syn match proseSection "^[A-Za-z\.].*$"
"
" " TODO, BUG, etc. tags
" " - must not be at the start of the line (it's a section header then)
" " - must not have an adjacent alphabetic or underscore
" syn match proseTodo /\v([A-Za-z_^])@<!(.)@<=(BUG|DEPRECATED|FIXME|IMPORTANT|NOTE|TODO)([A-Za-z_])@!/
"
" " bullet points
" syn region proseQuestion start=+\v^\s*\? + end=+\v\n\n@=|\n([A-Z])@=|(^\s*[-x!\*] )@=+ contains=proseTodo,proseLineComment
" syn region proseImportant start=+\v^\s*\! + end=+\v\n\n@=|\n([A-Z])@=|(^\s*[-\*\?x] )@=+ contains=proseTodo,proseLineComment
" syn region proseInvalid start=+\v^\s*x + end=+\v\n\n@=|\n([A-Z])@=|(^\s*[-\*\?!] )@=+ contains=proseTodo,proseLineComment
"
" " comment
" syn region proseLineComment start=+##+ end=+$+ keepend contains=proseTodo
"
" " URIs ------------
"
" " like: http://www.example.com
" " - requires leading whitespace
" syn match proseURI "\v(\s+)@<=([A-Za-z][A-Za-z0-9+\.\-]*)?://(\w\+(:\w\+)?\@)?([A-Za-z][-_0-9A-Za-z]*\.){1,}(\w{2,}\.?){1,}(:[0-9]{1,5})?\S*"
"
" " like: //example.com/path
" " - requires leading whitespace
" " - can be nested in () or {}
" syn match proseURI "\v(\s+|\(|\{)@<=//[A-za-z0-9\-_/\.#]*"
"
" " like: ./path/to/file.txt
" " - requires leading whitespace
" " - can be nested in () or {}
" syn match proseURI "\v(\s+|\(|\{)@<=(\.{1,2})?/[A-za-z0-9\-_/\.#]+"
"
" " email
" " - requires leading whitespace
" " - can be nested in () or {}
" syn match proseEmail "\v(\s+|\(|\{)@<=[A-za-z0-9_]+[A-za-z0-9\.\-_\+]*\@[A-za-z0-9\.\-_]*"
"
" " URN
" " - requires leading whitespace
" " - can be nested in () or {}
" syn match proseURN "\v(\s+|\(|\{)@<=[a|u]rn:[A-Za-z0-9\-_:/\.]+"
"
" " hashtag
" " - requires leading whitespace
" " - can be nested in () or {}
" syn match proseHashtag "\v(\s+|\(|\{)@<=(\@|#)[A-Za-z0-9\-_]+"

hi def link proseString String
hi def link proseMetadata Identifier
" hi def link proseObjAssign Identifier
" hi def link proseSection Underlined
" hi def link proseQuestion Exception
" hi def link proseImportant Repeat
" hi def link proseInvalid Comment
" hi def link proseTodo Todo
" hi def link proseLineComment Comment
" hi def link proseURI Underlined
" hi def link proseURN Underlined
" hi def link proseEmail Underlined
" hi def link proseHashtag Underlined

if !exists('b:current_syntax')
  let b:current_syntax = 'prose'
endif

" vim: fdm=marker
