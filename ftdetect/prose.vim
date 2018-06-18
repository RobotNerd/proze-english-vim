au BufNewFile,BufRead *.prose setfiletype prose
autocmd BufReadPost *.prose call ProseInitDocument()
