" Toggle paste mode
nmap <F4> :set paste!<BAR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" CTags
nmap <Leader>rt :!ctags --extra=+f -R *<CR><CR>
nmap <C-\> :tnext<CR>

" Ack a word
nmap <Leader>a :Ack <cword>

" Clear out the highlights
" Much better than my former method '/asldfkjasdlfkja<CR>'
noremap <silent><Leader>/ :nohls<CR>

" The two exclamation points mean I'm serious
" so use 'sudo' and quit your complaining
cmap w!! %!sudo tee > /dev/null %

" Let me draw you a VIM!
map <F5> :redraw! \| :noh \| <cr><c-w>=

" Clean up trailing whitespace
map <Leader>cw :%s/\s\+$//e<CR>:update<CR>

" Timestamp insertion
map <Leader>d :r! TZ=US/Pacific date +"\%a \%d \%b \%Y \%R \%Z"<CR>

" Relies on Unimpaired

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" / Relies on Unimpaired

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Fuck you too, manual key.
nnoremap K <nop>

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Make Y act like D and C
map Y y$


" Diary of a madman
function! OpenToday()
  let l:fname = '~/Dropbox/Notes/diary/' . strftime('%Y-%m-%d') . '.md'
  execute 'edit' l:fname
endfunction
nmap <silent> <Leader>md :<C-U>call OpenToday()<CR>

