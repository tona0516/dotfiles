#----------------------------------------
# Util
#----------------------------------------
is_mac() {
    if [ `uname` = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

#----------------------------------------
# Aliases
#----------------------------------------
if is_mac; then
    # Mac
    alias ll='ls -Gla'
    alias ls='ls -G'
else
    # Linux
    alias ll='ls -la --color=auto'
    alias ls='ls --color=auto'
fi
alias h='hostname'
alias git='noglob git'
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gcf='git branch | fzf | xargs git checkout'
alias gl='git log --oneline'
alias gr='git reset'
alias gd='git diff'
alias gll='git log --oneline | fzf | cut -d" " -f1 | xargs git show'
alias gcln='git clean -xdf'
alias vf='fzf | xargs -o vim'
alias ssh='ssh -A'
alias rezsh='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias fzf='fzf --height 50% --ansi'

if [ `which atom &> /dev/null` ]; then
    alias memo='atom ~/Documents/workaround.md'
else
    alias memo='vim ~/Documents/workaround.md'
fi
alias cs='vim ~/dotfiles/document/cheatsheet.md'

#----------------------------------------
# Settings
#----------------------------------------
setopt extended_glob # 高機能なワイルドカード展開を使用する
setopt auto_list # 補完候補を一覧表示
setopt auto_menu # TAB で順に補完候補を切り替え
setopt list_packed # 候補が多い場合は詰めて表示

setopt hist_ignore_dups # 重複する履歴は無視
setopt share_history # 履歴を共有
setopt hist_ignore_space # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する
setopt extended_history # 履歴ファイルにzsh の開始・終了時刻を記録する
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt interactivecomments # コメントを使えるようにする
setopt noflowcontrol # フロー制御を無効にする

# ヒストリーの設定
export LANG=ja_JP.UTF-8
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプトの表示設定
function git_branch() {
    echo -n "$(git name-rev --name-only HEAD 2> /dev/null)"
}
setopt prompt_subst
function precmd() {
    psvar=()
    branch=`git_branch`
    [[ -n "$branch" ]] && psvar[1]="$branch"
}
RPROMPT=""
PROMPT="%F{214}%n%f %F{white}in%f %F{magenta}%m%f %F{white}at%f %F{cyan}%~%f %1(v|%F{white}on%f %F{red}%1v%f|) %F{green}[%T]%f
%B%F{yellow}〉%f%b%{${reset_color}%}"

# 補完の有効化
autoload -Uz compinit && compinit -u

# 補完候補を一覧表示したとき、Tabや矢印で選択できるように
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#----------------------------------------
# ZPLUG
#----------------------------------------
# install zplug
if [ ! -e ~/.zplug ]; then
    export ZPLUG_HOME=~/.zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source ~/.zplug/init.zsh
ZPLUG_PROTOCOL=HTTPS

# install fzf
if is_mac; then
    zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*darwin*amd64*"
else
    zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
fi

# snippet search by fzf
function select-snippets() {
    BUFFER=$(cat ~/dotfiles/document/command_snippets | fzf --no-sort +m --query "$LBUFFER" --prompt="Snippet > ")
    CURSOR=$#BUFFER
}
zle -N select-snippets
bindkey '^s' select-snippets

# install plugins
zplug "b4b4r07/enhancd", use:init.sh
if zplug check "b4b4r07/enhancd"; then
    ENHANCD_DISABLE_HOME=0
    ENHANCD_DISABLE_DOT=1
    ENHANCD_DISABLE_HYPHEN=1
    ENHANCD_HOOK_AFTER_CD=ls
    ENHANCD_FILTER=fzf
fi

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", lazy:true
zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh
zplug "motemen/ghq", as:command, from:gh-r, rename-to:ghq

zplug "mollifier/anyframe"
if zplug check "mollifier/anyframe"; then
    zstyle ":anyframe:selector:" use fzf
    zstyle ":anyframe:selector:fzf:" command 'fzf --height 50% --ansi'
    bindkey '^r' anyframe-widget-put-history
    alias gco=anyframe-widget-checkout-git-branch
    bindkey '^f' anyframe-widget-insert-filename
fi

# install
zplug install
zplug load

