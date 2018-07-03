" Parse prose config file.

" TODO Try to determine filetype based on contents instead of extension.
" TODO Parse compilation options
" TODO Update to support unicode


" Parse JSON formatted config file.
" @param path Path to the config file.
" @return Structured data parsed from the config file.
function ProseParseJson(path)
  let data = { 'names': {}, 'compile': {} }
python3 << EOF
import json
import vim
with open(vim.eval("a:path"), 'r') as f:
  parsed = json.loads(f.read())

# The python u' prefix for unicode strings is removed by forcing ASCII.
names = parsed.get('names')
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


" Parse YAML formatted config file.
" @param path Path to the config file.
" @return Dictionary containing lists of names parsed.
function ProseParseYaml(path)
  let data = { 'names': {}, 'compile': {} }
python3 << EOF
import yaml
import vim
with open(vim.eval("a:path"), 'r') as f:
  parsed = yaml.safe_load(f)
names = parsed.get('names')
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
    let data = ProseParseYaml(path)
  else
    let path = findfile('config.json')
    if path != ''
      let data = ProseParseJson(path)
    endif
  endif
  return data
endfunction
