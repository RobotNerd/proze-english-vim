" Prose tag names to be added to the temporary dictionary.
let s:tagnames = ['FIXME', 'IMPORTANT', 'NOTE', 'TODO']

" Pattern for negative lookahead/lookbehind for syntax highlighting.
let s:look_around = '([A-Za-z0-9])'

" Add the names as a syntax rule.
" @param names All name sets to be added to the syntax rules.
" @param name_group Name subset to be processed.
" @param rule Name of the syntax rule.
function s:AddSyntaxRule(names, name_group, rule)
  if !empty(get(a:names, a:name_group))
    for name in a:names[a:name_group]
      exec 'syn match ' . a:rule . ' /\v' . s:look_around .'@<!(' . name . ')' . s:look_around . '@!/'
    endfor
  endif
endfunction

" Insert names for spell checking.
" Sanitize name patterns before adding them.
" @param names All name sets to be added fo spell checking.
" @param name_group Name subset to be processed.
function s:AddToSpellcheck(names, name_group)
  if !empty(get(a:names, a:name_group))
python3 << EOF
import re
import vim
for pattern in list(vim.eval("a:names[a:name_group]")):
  pattern = re.sub('[^A-Za-z0-9]', ' ', pattern)
  for name in pattern.split():
    vim.command("silent exec 'spe! {}'".format(name))
EOF
  endif
endfunction

" Add special names to the syntax.
" Names are parsed from the config file.
" These names are highlighted based on the rules in the prose syntax.
" @param names Dictionary containing lists of names.
function ProseApplyNameSyntax(names)
  call s:AddSyntaxRule(a:names, 'characters', 'ProseCharacter')
  call s:AddSyntaxRule(a:names, 'places', 'ProsePlace')
  call s:AddSyntaxRule(a:names, 'things', 'ProseThing')
  call s:AddSyntaxRule(a:names, 'invalid', 'ProseInvalid')
endfunction

" Add special names to the spell checker.
" Names are parsed from the config file.
" @param names Dictionary containing lists of names.
function ProseApplyNameSpellcheck(names)
  for name in s:tagnames
    silent exec 'spe! ' . name
  endfor
  call s:AddToSpellcheck(a:names, 'characters')
  call s:AddToSpellcheck(a:names, 'places')
  call s:AddToSpellcheck(a:names, 'things')
endfunction
