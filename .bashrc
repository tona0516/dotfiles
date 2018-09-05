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
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gl='git log --oneline'
alias gr='git reset'
alias gd='git diff'
alias gcln='git clean -xdf'
alias ssh='ssh -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


