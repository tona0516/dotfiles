is_mac && alias ls='ls -G -F' || alias ls='ls --color=auto -F'
alias ll='ls -l'
alias lla='ls -la'
alias sl='ls'
alias h='hostname'
alias git='noglob git'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gs='git status'
alias gl="git log --pretty='format:%C(yellow)%h %C(cyan)%an %C(green)%cd %C(reset)%s %C(red)%d' --date=short"
alias gll='glo' # forgit plugin alias
alias gr='git reset'
alias gd='git diff'
alias gdd='git diff --cached'
alias groot='cd-gitroot'
alias ssh='ssh -A'
alias rezsh='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias sudo-vim='sudo -E vim'
alias gco=anyframe-widget-checkout-git-branch
alias psa="ps aux"
alias psg="ps aux | grep "
alias df='df -h'
alias dotfiles="cd ~/dotfiles"
alias k="kubectl"

# C で標準出力をクリップボードにコピーする
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
