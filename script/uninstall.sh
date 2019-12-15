#!/bin/bash

# remove installed each alias
for f in .??*
do
    [ -f $HOME/$f ] && rm $HOME/$f && echo "removed "$HOME/$f
done

# remove installed each directory
REMOVE_FILES=(.zcompdump .zplug/ .enhancd/ .vim/)
for f in ${REMOVE_FILES[@]}
do
    [ -e $HOME/$f ] && rm -rf $HOME/$f && echo "removed "$HOME/$f
done

# relogin zsh
exec $SHELL -l

