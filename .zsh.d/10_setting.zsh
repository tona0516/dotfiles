setopt extended_glob # 高機能なワイルドカード展開を使用する
setopt auto_list # 補完候補を一覧表示
setopt auto_menu # TAB で順に補完候補を切り替え
setopt list_packed # 候補が多い場合は詰めて表示
setopt list_types # 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt hist_ignore_dups # 重複する履歴は無視
setopt share_history # 履歴を共有
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する
setopt extended_history # 履歴ファイルにzsh の開始・終了時刻を記録する
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt interactive_comments # コメントを使えるようにする
setopt no_flow_control # フロー制御を無効にする
setopt ignore_eof # Ctrl+d無効
setopt no_beep # ビープ音を無効にする
setopt no_hist_beep # ビープ音を無効にする
setopt no_list_beep  # ビープ音を無効にする
setopt auto_param_keys #変数名を補完する
setopt auto_resume # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt brace_ccl # echo {a-z}などを使えるようにする

unsetopt glob_dots #"*" にドットファイルをマッチ

# ヒストリーの設定
export LANG=ja_JP.UTF-8
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 補完の有効化
# zplugで呼ばれるので不要
# autoload -Uz compinit && compinit -u

# 補完候補を一覧表示したとき、Tabや矢印で選択できるように
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
export LSCOLORS=gxfxcxdxbxegedabagacag # for mac
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30' # for linux:
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 失敗したコマンドを履歴に残らないようにする
zshaddhistory() {
    whence ${${(z)1}[1]} >| /dev/null || return 1
}

# PATHの追加
export PATH=$HOME/local/bin:$PATH
