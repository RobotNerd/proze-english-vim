" Add special names parsed from the config file to the syntax.
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

