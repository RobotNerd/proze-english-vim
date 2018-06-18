" Parse prose config file.

" TODO Try to determine filetype based on contents instead of extension.


" Parse JSON formatted config file.
" @param path Path to the config file.
" @return Structured data parsed from the config file.
function ProseParseJson(path)
  let raw = readfile(a:path)
  let data = {}
  " TODO
  return data
endfunction


" Parse YAML formatted config file.
" @param path Path to the config file.
" @return Structured data parsed from the config file.
function ProseParseYaml(path)
  echom 'ParseYaml called'
  py import yaml
  py import vim
  py f = open(vim.eval("a:path"), 'r')
  py parsed = yaml.safe_load(f)
  py f.close()
  py names = parsed['names']
  py characters = names['characters'] if names['characters'] else []
  py places = names['places'] if names['places'] else []
  py things = names['things'] if names['things'] else []
  py invalid = names['invalid'] if names['invalid'] else []
  py vim.command("let g:prose_characters = " + str(characters))
  py vim.command("let g:prose_places = " + str(places))
  py vim.command("let g:prose_things = " + str(things))
  py vim.command("let g:prose_invalid = " + str(invalid))
  if len(g:prose_characters) > 0
    exec 'syn keyword proseCharacter ' . join(g:prose_characters)
  endif
  if len(g:prose_places) > 0
    exec 'syn keyword prosePlace ' . join(g:prose_places)
  endif
  if len(g:prose_things) > 0
    exec 'syn keyword proseThing ' . join(g:prose_things)
  endif
  if len(g:prose_invalid) > 0
     exec 'syn keyword proseInvalid ' . join(g:prose_invalid)
  endif
endfunction


" Find and parse the prose config file.
" @return Structured data parsed from the config file. If
"    no config file is found, return an empty dictionary.
function ProseParseConfig()
  let path = findfile('config.yml')
  let data = 0
  if path
    let data = s:ProseParseYaml()
  else
    let path = findfile('config.json')
    if path
      let data = s:ProseParseJson()
    endif
  endif
  return data
endfunction

