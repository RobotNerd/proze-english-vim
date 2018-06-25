" Prose tag names to be added to the temporary dictionary.
let s:tagnames = ['FIXME', 'IMPORTANT', 'NOTE', 'TODO']

" Add special names to the syntax.
" Names are parsed from the config file.
" These names are highlighted based on the rules in the prose syntax.
" @param names Dictionary containing lists of names.
function ProseApplyNameSyntax(names)
  for name in a:names.characters
    exec 'syn match ProseCharacter /\v' . name . '/'
  endfor
  for name in a:names.places
    exec 'syn match ProsePlace /\v' . name . '/'
  endfor
  for name in a:names.things
    exec 'syn match ProseThing /\v' . name . '/'
  endfor
  for name in a:names.invalid
    exec 'syn match ProseInvalid /\v' . name . '/'
  endfor
endfunction

" Add special names to the spell checker.
" Names are parsed from the config file.
" @param names Dictionary containing lists of names.
function ProseApplyNameSpellcheck(names)
  " TODO ignore regex values in names
  " TODO split words apart
  for name in s:tagnames
    silent exec 'spe! ' . name
  endfor
  for name in a:names.characters
    silent exec 'spe! ' . name
  endfor
  for name in a:names.places
    silent exec 'spe! ' . name
  endfor
  for name in a:names.things
    silent exec 'spe! ' . name
  endfor
endfunction

