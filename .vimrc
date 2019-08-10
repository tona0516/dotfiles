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
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
"シンタックスに色をつける
syntax on

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
" 挿入モード時にemacのようにctrl+aで先頭、ctrl+eで末尾に移動する
nmap <C-a> <Home>
nmap <C-e> <End>
imap <C-a> <Home>
imap <C-e> <End>
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

"jjでノーマルモードにして保存
inoremap <silent> jj <ESC>
"挿入モード時は縦棒のカーソルを表示する
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
endif

"左右のカーソル移動で行間移動可能にする。
set whichwrap+=b,s,h,l,<,>,[,]

" " コメントのハイライトをグレーにする
highlight Comment ctermfg=Green

" マウスでカーソル移動できるようにする
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
end

" 最後にいたカーソルを記憶す
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

"----------------------------------------
" vim-plug
"----------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'Shougo/unite.vim' " ファイル操作とか
Plug 'itchyny/lightline.vim' " 情報を見やすく
Plug 'nathanaelkane/vim-indent-guides' " インデントを色分け
Plug 'Townk/vim-autoclose' " カッコを自動で閉じる
Plug 'ujihisa/neco-look' " 英単語の補完
Plug 'scrooloose/nerdtree' " ツリー型のファイル表示
Plug 'jistr/vim-nerdtree-tabs' " タブ強化プラグイン
Plug 'mhinz/vim-grepper' " 高速grepするやつ
Plug 'tpope/vim-fugitive' " vimでGitコマンドを使う
Plug 'junegunn/fzf' " インクリメンタルサーチ
Plug 'junegunn/fzf.vim' " インクリメンタルサーチ
Plug 'w0ng/vim-hybrid' " カラースキーム
Plug 'tomasr/molokai' " カラースキーム
Plug 'ConradIrwin/vim-bracketed-paste' "自動set paste
Plug 'tyru/caw.vim' " ctrl+/でコメントアウトのトグル
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
    " Ctrl+eで表示切り替え
    map <C-n> :NERDTreeTabsToggle<CR>
    " 隠しファイルをデフォルトで表示させる
    let NERDTreeShowHidden = 1
endif

"----------------------------------------
" fzf
"----------------------------------------
if s:is_plugged("fzf.vim")
    map <C-o> :Files<CR>
    map <C-r> :History<CR>
    map r :redo<CR>
endif

"----------------------------------------
" colorscheme
"----------------------------------------
if s:is_plugged("vim-hybrid") && has('unix')
    set background=dark
    colorscheme hybrid
    highlight LineNr ctermfg=gray
elseif s:is_plugged("molokai")
    colorscheme molokai
endif

"----------------------------------------
" caw.vim
"----------------------------------------
if s:is_plugged("caw.vim")
    nmap <C-_> <plug>(caw:hatpos:toggle)
    vmap <C-_> <plug>(caw:hatpos:toggle)
endif

