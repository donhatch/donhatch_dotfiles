set ai " autoindent
set sw=4 " shiftwidth
set terse
set et " expand tabs

"----------------------------------------
" google-local
se sw=2
"se ts=2 " wtf? no way!
" takes too long! and I don't think I care about anything in it
"source /usr/share/vim/google/google.vim
"----------------------------------------

map g G
map #H :%s/.<C-v><C-h>//g<CR>
map ## :e#<CR>
map #< :se paste<CR>
map #> :se nopaste<CR>
set background=dark

au! BufRead,BufNewFIle *.prejava set filetype=java

"STUPID FUCKING THING
se tw=0

" turn off frickin auto-wrapping in .txt files
"autocmd BufRead *.txt se tw=0
" hmm, mimimicing what is in /usr/share/vim/vim70/vimrc_example.vim
"autocmd FileType text setlocal textwidth=0
" woops! that didn't work!
autocmd BufRead *.txt setlocal textwidth=0

"so I don't get that freaking gx mapping that messes with my g mapping
let g:netrw_nogx = 1

syntax enable

"BUG: this doesn't work for lines 80 through 89 !?! instead of ":80" I get "0"
:map * :exe 'silent !google-chrome-beta "https://cs.corp.google.com/?q=%:'.line(".").'" \| grep -v "Created new window in existing browser session." &'<CR><C-l>

" so modelines will work (disabled by default on most linux os's)
set modeline
set modelines=5

" To avoid the <Esc>O problem...
" http://vi.stackexchange.com/questions/3261/speed-bump-on-esco-insert-to-normal-to-insert-new-line-above-cursor
" default is timeout,timeoutlen=1000,ttimeoutlen=-1  (-1 meaning 1000)
" Recommended in :help timeout  (I don't like this much)
":set timeout timeoutlen=1000 ttimeoutlen=100
" Recommended in :help xterm-cursor-keys  (I like this better)
set notimeout          " don't timeout on mappings
set ttimeout           " do timeout on terminal key codes
set timeoutlen=100     " timeout after 100 msec


"====================================================================================================
" DOESN'T WORK

" " Code from:
" " http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" " then https://coderwall.com/p/if9mda
" " and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" " to fix the escape time problem with insert mode.
" "
" " Docs on bracketed paste mode:
" " http://www.xfree86.org/current/ctlseqs.html
" " Docs on mapping fast escape codes in vim
" " http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" 
" if !exists("g:bracketed_paste_tmux_wrap")
"   let g:bracketed_paste_tmux_wrap = 1
" endif
" 
" function! WrapForTmux(s)
"   if !g:bracketed_paste_tmux_wrap || !exists('$TMUX')
"     return a:s
"   endif
" 
"   let tmux_start = "\<Esc>Ptmux;"
"   let tmux_end = "\<Esc>\\"
" 
"   return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
" endfunction
" 
" let &t_SI .= WrapForTmux("\<Esc>[?2004h")
" let &t_EI .= WrapForTmux("\<Esc>[?2004l")
" 
" function! XTermPasteBegin(ret)
"   set pastetoggle=<f29>
"   set paste
"   return a:ret
" endfunction
" 
" execute "set <f28>=\<Esc>[200~"
" execute "set <f29>=\<Esc>[201~"
" map <expr> <f28> XTermPasteBegin("i")
" imap <expr> <f28> XTermPasteBegin("")
" vmap <expr> <f28> XTermPasteBegin("c")
" cmap <f28> <nop>
" cmap <f29> <nop>
"====================================================================================================
