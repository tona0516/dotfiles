"setting
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" (macでは不要だけど)BackSpace有効
set backspace=start,eol,indent

set ambiwidth=double

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=full
set wildmenu
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
"シンタックスに色をつける
syntax on
" スクロール時に数行余らせる
set scrolloff=3

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
"ソフトタブを有効にする
set expandtab
" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"重いスクロールの解決
set lazyredraw
" 挿入モード時はctrl+hjklで移動できるようにする
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-a> <Home>
imap <C-e> <End>
" emacsのようにctrl+aで先頭、ctrl+eで末尾に移動する
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
" Tabでタブ移動
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
nmap <C-t> :tabnew<CR>
" 括弧→補完→改行→インデント
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" 不可視文字を表示する
set list
set listchars=tab:»-,trail:-,eol:$,extends:»,precedes:«,nbsp:%

"jjでノーマルモードに
inoremap <silent> jj <ESC>
" 挿入モード時に点滅の縦棒タイプのカーソル
let &t_SI .= "\e[5 q"
" ノーマルモード時に点滅の矩形タイプのカーソル
let &t_EI .= "\e[1 q"

"左右のカーソル移動で行間移動可能にする。
set whichwrap+=b,s,h,l,<,>,[,]

" 最後にいたカーソルを記憶する
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" 新しいウィンドウを右側で開く
set splitright

" ctrl+lで行情報+不可視文字の表示/非表示
function! s:toggle_line_info()
    set invnumber
    set invlist
    GitGutterToggle
endfunction
command! LineInfoToggle call s:toggle_line_info()
nnoremap <C-l> :LineInfoToggle<CR>
"----------------------------------------
" vim-plug
"----------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0ng/vim-hybrid'
Plug 'tomasr/molokai'
Plug 'dylnmc/novum.vim'
Plug 'mushanyoung/vim-windflower'
Plug 'roxma/vim-paste-easy'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'svermeulen/vim-easyclip'
call plug#end()

" インストール判定関数
function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction
"----------------------------------------
" NERDTree
"----------------------------------------
if s:is_plugged("nerdtree")
    map <C-n> :NERDTreeTabsToggle<CR>
    let NERDTreeShowHidden = 1
    let g:NERDTreeWinSize = 48
endif

"----------------------------------------
" fzf
"----------------------------------------
if s:is_plugged("fzf.vim")
    map <C-o> :GFiles<CR>
    map gs :GFiles?<CR>
    map <C-f> :Files<CR>
    map <C-r> :History<CR>
    map r :redo<CR>
endif

"----------------------------------------
" colorscheme
"----------------------------------------
if s:is_plugged("vim-hybrid") && has('unix')
    set background=dark
    colorscheme hybrid
    highlight LineNr ctermfg=lightgreen
endif

"----------------------------------------
" vim-lsp-settings
"----------------------------------------
if s:is_plugged("vim-lsp-settings")
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_signs_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
endif

"----------------------------------------
" asyncomplete.vim
"----------------------------------------
if s:is_plugged("asyncomplete.vim")
    " To auto close preview window when completion is done.
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
endif

"----------------------------------------
" vim-easyclip
"----------------------------------------
if s:is_plugged("vim-easyclip")
    let g:EasyClipShareYanks = 1
    " easycilpからコピーした一覧を取得
    function! s:yank_list()
      redir => ys
      silent Yanks
      redir END
      return split(ys, '\n')[1:]
    endfunction

    " 引数からPasteコマンドで貼り付け
    function! s:yank_handler(reg)
      if empty(a:reg)
        echo "aborted register paste"
      else
        let token = split(a:reg, ' ')
        execute 'Paste' . token[0]
      endif
    endfunction

    " fzfを使って一覧を呼び出して貼り付け
    command! FZFYank call fzf#run({
    \ 'source': <sid>yank_list(),
    \ 'sink': function('<sid>yank_handler'),
    \ 'options': '-m --prompt="FZFYank> "',
    \ 'down': '40%'
    \ })

    nnoremap <C-Y><C-Y> :<C-U>FZFYank<CR>
    inoremap <C-Y><C-Y> <C-O>:<C-U>FZFYank<CR>
endif
