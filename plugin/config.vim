" Parse prose config file.

" TODO Try to determine filetype based on contents instead of extension.
" TODO Parse compilation options
" TODO Update to support unicode


" Parse JSON formatted config file.
" @param path Path to the config file.
" @param filetype Either json or yaml.
" @return Structured data parsed from the config file.
function s:ParseNames(path, filetype)
  let data = { 'names': {}, 'compile': {} }
python3 << EOF
import vim
with open(vim.eval("a:path"), 'r') as f:
  if vim.eval("a:filetype") == 'json':
    import json
    parsed = json.loads(f.read())
  elif vim.eval("a:filetype") == 'yaml':
    import yaml
    parsed = yaml.safe_load(f)
if parsed:
  names = parsed.get('names')
  if names:
    characters = names.get('characters') if names.get('characters') else []
    places = names.get('places') if names.get('places') else []
    things = names.get('things') if names.get('things') else []
    invalid = names.get('invalid') if names.get('invalid') else []
    vim.command("let data.names.characters = " + str(characters))
    vim.command("let data.names.places = " + str(places))
    vim.command("let data.names.things = " + str(things))
    vim.command("let data.names.invalid = " + str(invalid))
EOF
  return data
endfunction


" Find and parse the prose config file.
" @return Structured data parsed from the config file. If
"    no config file is found, return an empty dictionary.
function ProseParseConfig()
  let path = findfile('config.yml')
  let data = 0
  if path != ''
    let data = s:ParseNames(path, 'yaml')
  else
    let path = findfile('config.json')
    if path != ''
      let data = s:ParseNames(path, 'json')
    endif
  endif
  return data
endfunction
