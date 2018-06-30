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

To automatically turn on spell checking whenever a prose document is
opened, add an augroup section to your .vimrc file. Here's an example
that uses the US English dictionary.

```
augroup spelling
  autocmd!
  autocmd BufRead,BufNewFile *.prose setlocal spell spelllang=en_us
augroup END
```

You can also change the default highlighting used when spell checking.
Here is an example that underlines any misspelled words.

```
hi clear SpellBad
hi SpellBad cterm=underline
```
