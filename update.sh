#!/bin/bash

is_installed() {
    if type $1 > /dev/null 2>&1; then
        return 0
    fi
    return 1
}

if is_installed zplug; then
    zplug update
fi

vim +PlugUpdate +qall

# relogin zsh
exec zsh -l
