# Prose format: vim plugin

This vim plugin provides syntax highlighting for
[prose](https://github.com/RobotNerd/prose-english-format) documents.

## Installation

Follow the instructions to install
[vundle](https://github.com/VundleVim/Vundle.vim). Once installed,
add the following line to your `.vimrc` file:

```
Plugin 'robotnerd/prose-english-vim'
```

Then launch vim and run the command `:PluginInstall`.

Now vim will automatically provide syntax highlighting for documents
with a `*.prose` extension.

## Configure spell checking

Turn on spell checking using the US English dictionary.

```viml
setlocal spell spelllang=en_us
```

The configuration highlights misspelled words by underlining them.

```viml
hi clear SpellBad
hi SpellBad cterm=underline
```

## Other configuration options

Tabs:
```viml
set tabstop=2
setl expandtab
set shiftwidth=2
```

Text wrapping:
```viml
set wrap
set linebreak
map j gj
map k gk
```

Column width:
```viml
set columns=80
```

## Sample `.vimrc`

Here is a sample configuration block that can be added to your `.vimrc`
file for prose support.

```viml
" Apply custom configuration for prose documents.
augroup proseConfig
  autocmd!
  autocmd BufRead,BufNewFile *.prose
    \ set tabstop=2 |
    \ setl expandtab |
    \ set shiftwidth=2 |
    \ set wrap |
    \ set linebreak |
    \ map j gj |
    \ map k gk |
    \ set columns=80 |
    \ setlocal spell spelllang=en_us |
    \ hi clear SpellBad |
    \ hi SpellBad cterm=underline
augroup END
```
