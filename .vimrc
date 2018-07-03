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

" ------------------ dein setting -------------------------
if &compatible
    set nocompatible
endif
set runtimepath^=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

" deinの設定
call dein#begin(expand('$HOME/.vim/dein'))
call dein#add('Shougo/dein.vim')

" ==================== plugins ===============================
call dein#add('Shougo/unite.vim') " ファイル操作とか
call dein#add('itchyny/lightline.vim') " 情報を見やすく
call dein#add('nathanaelkane/vim-indent-guides') " インデントを色分け
call dein#add('Townk/vim-autoclose') " カッコを自動で閉じる
call dein#add('ujihisa/neco-look') " 英単語の補完
call dein#add('scrooloose/nerdtree') " ツリー型のファイル表示
call dein#add('jistr/vim-nerdtree-tabs') " タブ強化プラグイン
call dein#add('mhinz/vim-grepper') " 高速grepするやつ
call dein#add('scrooloose/syntastic') " swiftのSyntax check
call dein#add('kballard/vim-swift') " swiftのSyntax check
call dein#add('keith/swift.vim') " swiftのsyntax highlight
call dein#add('ctrlpvim/ctrlp.vim') " ctrlp
call dein#add('tomasr/molokai')  " molokai
call dein#add('vim-airline/vim-airline') " airline
call dein#add('vim-airline/vim-airline-themes') " airline-theme
call dein#add('tpope/vim-fugitive') " vimでGitコマンドを使う
" ============================================================
call dein#end()
filetype plugin indent on

" 未インストールのプラグインをインストール
if dein#check_install()
    call dein#install()
endif

"----------------------------------------
" NERDTree
"----------------------------------------
" Ctrl+eで表示切り替え
map <C-e> :NERDTreeTabsToggle<CR>
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

"----------------------------------------
" ctrlp
"----------------------------------------
let g:ctrlp_show_hidden = 1

"----------------------------------------
" molokai
"----------------------------------------
colorscheme molokai

"----------------------------------------
" airline
"----------------------------------------
let g:airline_theme = 'molokai'

