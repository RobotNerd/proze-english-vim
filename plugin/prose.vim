" Load prose settings.
function ProseInitDocument()
  let data = ProseParseConfig()
  call ProseApplyNameSyntax(data.names)
  call ProseApplyNameSpellcheck(data.names)
endfunction

