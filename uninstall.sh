#!/bin/bash

# remove installed each alias
for f in .??*
do
    if [ -f $HOME/$f ]; then
        rm $HOME/$f
    fi
done

# remove installed each directory
if [ -f $HOME/.zcompdump ]; then
    rm $HOME/.zcompdump
fi
if [ -d $HOME/.zplug/ ]; then
    rm -rf $HOME/.zplug/
fi
if [ -d $HOME/.enhancd/ ]; then
    rm -rf ~/.enhancd/
fi
if [ -d $HOME/.vim/ ]; then
    rm -rf $HOME/.vim/
fi

# relogin zsh
exec $SHELL -l
