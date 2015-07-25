"""
" 一般設定
"""
syntax enable

set number
set list
set listchars=tab:->,trail:-,nbsp:%,extends:>,precedes:<,eol:๑
set incsearch
set hlsearch
set nowrap
set showmatch
set whichwrap=h,l
set nowrapscan
set ignorecase
set smartcase
set hidden
set history=2000
set autoindent
set expandtab
set tabstop=4
set shiftwidth=2
set helplang=en
set wildmenu wildmode=list:longest,full

colorscheme hybrid


"""
" :なんてできれば打ちたくない
"""
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"""
" Shift+数字キーなんて打てるはずない
"""
nnoremap <Space>h ^
nnoremap <Space>l $
nnoremap <Space><Space> $

"""
" Spaceにいろいろ割り当てたついでだし
"""
nnoremap <Space>j 50j
nnoremap <Space>k 50k

"""
" 頻繁に使うキーが端っこにあるとかおかしい
"""
inoremap jj <Esc>
inoremap kk <CR>

"""
" Emacsっぽいやつ
"""
noremap <C-a> <Home>
noremap <C-e> <End>
noremap <C-b> <Left>
noremap <C-f> <Right>
noremap <C-p> <Up>
noremap <C-n> <Down>
noremap <C-k> <Up>

"""
" 画面分割してExplorer開くとか、分割画面移動とか
"""
nnoremap ss :<C-u>S<CR>
nnoremap vs :<C-u>Ve<CR>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sq :<C-u>q<CR>
nnoremap so <C-w>=
nnoremap sf 3<C-w>>
nnoremap sb 3<C-w><
nnoremap sp 3<C-w>+
nnoremap sn 3<C-w>-

"""
" タブまわり
"""
nnoremap sP :<C-u>bp<CR>
" Anywhere SID.
function! s:SID_PREFIX()
return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline() "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1] " first window, first appears
    let no = i " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '+' : ''
    let sell = (i == tabpagenr() ? '[' : ' ')
    let selr = (i == tabpagenr() ? ']' : ' ')
    let title = fnamemodify(bufname(bufnr), ':t')
    let s .= '%'.i.'T'
    let s .= '%#TabLineSel#'
    let s .= sell . no . ':' . title . mod . selr
  endfor
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

for n in range(1, 9)
execute 'nnoremap <silent> t'.n ':<C-u>tabnext'.n.'<CR>'
endfor

nnoremap t <Nop>
nnoremap <silent> tn :tablast<bar> :tabnew<bar> :E<CR>
nnoremap <silent> tq :tabclose<CR>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> th :tabprevious<CR>

"""
" sudo vimしてなくてもsudoしたい
""""
nnoremap <silent> save :set noswapfile<CR>:w !sudo tee >/dev/null %<CR>:set swapfile<CR>
nnoremap sudo :! sudo
nnoremap cmd :!

"""
" leaderをマップしてみたけど
"""
let mapleader = ","
noremap \ ,

noremap <Leader>c :<C-u>setlocal number! list! nowrap!<CR>
noremap <Leader>v :<C-u>setlocal paste!<CR>

"""
" かっこ良くハイライトするやつ
"""
augroup vimrc-auto-cursorline
autocmd!
autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
autocmd WinEnter * call s:auto_cursorline('WinEnter')
autocmd WinLeave * call s:auto_cursorline('WinLeave')

let s:cursorline_lock = 0
function! s:auto_cursorline(event)
  if a:event ==# 'WinEnter'
    setlocal cursorline
    setlocal cursorcolumn
    let s:cursorline_lock = 2
  elseif a:event ==# 'WinLeave'
    setlocal nocursorline
    setlocal nocursorcolumn
  elseif a:event ==# 'CursorMoved'
    if s:cursorline_lock
      if 1 < s:cursorline_lock
        let s:cursorline_lock = 1
      else
        setlocal nocursorline
        setlocal nocursorcolumn
        let s:cursorline_lock = 0
      endif
    endif
  elseif a:event ==# 'CursorHold'
    setlocal cursorline
    setlocal cursorcolumn
    let s:cursorline_lock = 1
  endif
endfunction
augroup END
