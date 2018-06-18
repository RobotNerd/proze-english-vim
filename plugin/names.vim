" TODO ensure regex names are highlighted correctly

" Add special names parsed from the config file to the syntax.
" These names are highlighted based on the rules in the prose syntax.
" @param names Dictionary containing lists of names.
function ProseApplyNameSyntax(names)
  if len(a:names.characters) > 0
    exec 'syn keyword proseCharacter ' . join(a:names.characters)
  endif
  if len(a:names.places) > 0
    exec 'syn keyword prosePlace ' . join(a:names.places)
  endif
  if len(a:names.things) > 0
    exec 'syn keyword proseThing ' . join(a:names.things)
  endif
  if len(a:names.invalid) > 0
     exec 'syn keyword proseInvalid ' . join(a:names.invalid)
  endif
endfunction
