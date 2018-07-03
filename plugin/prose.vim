" Load prose settings.
function ProseInitDocument()
  let data = ProseParseConfig()
  if data
    call ProseApplyNameSyntax(data.names)
    call ProseApplyNameSpellcheck(data.names)
  endif
endfunction

