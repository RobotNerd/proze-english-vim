" Load prose settings.
function ProseInitDocument()
  let data = ProseParseConfig()
  call ProseApplyNameSyntax(data.names)
endfunction
