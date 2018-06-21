" Parse prose config file.

" TODO Try to determine filetype based on contents instead of extension.
" TODO Parse compilation options
" TODO Update to support unicode


" Parse JSON formatted config file.
" @param path Path to the config file.
" @return Structured data parsed from the config file.
function ProseParseJson(path)
  let data = { 'names': {}, 'compile': {} }
  py import json
  py import vim
  py f = open(vim.eval("a:path"), 'r')
  py parsed = json.loads(f.read())
  py f.close()

  " The python u' prefix for unicode strings is removed by forcing ASCII.
  py names = parsed['names']
  py characters = [x.encode('ascii') for x in names['characters']] if names['characters'] else []
  py places = [x.encode('ascii') for x in names['places']] if names['places'] else []
  py things = [x.encode('ascii') for x in names['things']] if names['things'] else []
  py invalid = [x.encode('ascii') for x in names['invalid']] if names['invalid'] else []
  py vim.command("let data.names.characters = " + str(characters))
  py vim.command("let data.names.places = " + str(places))
  py vim.command("let data.names.things = " + str(things))
  py vim.command("let data.names.invalid = " + str(invalid))
  return data
endfunction


" Parse YAML formatted config file.
" @param path Path to the config file.
" @return Dictionary containing lists of names parsed.
function ProseParseYaml(path)
  let data = { 'names': {}, 'compile': {} }
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
  py vim.command("let data.names.characters = " + str(characters))
  py vim.command("let data.names.places = " + str(places))
  py vim.command("let data.names.things = " + str(things))
  py vim.command("let data.names.invalid = " + str(invalid))
  return data
endfunction


" Find and parse the prose config file.
" @return Structured data parsed from the config file. If
"    no config file is found, return an empty dictionary.
function ProseParseConfig()
  let path = findfile('config.yml')
  let data = 0
  if path != ''
    let data = ProseParseYaml(path)
  else
    let path = findfile('config.json')
    if path != ''
      let data = ProseParseJson(path)
    endif
  endif
  return data
endfunction
