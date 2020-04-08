#!/bin/bash

echo -n "--------------------------------------------------------------------------------"
echo -n "
       ,,                    ,...,,    ,,                  
     \`7MM           mm     .d' \"\"db  \`7MM                  
       MM           MM     dM\`         MM                  
  ,M\"\"bMM  ,pW\"Wq.mmMMmm  mMMmm\`7MM    MM  .gP\"Ya  ,pP\"Ybd 
,AP    MM 6W'   \`Wb MM     MM    MM    MM ,M'   Yb 8I   \`\" 
8MI    MM 8M     M8 MM     MM    MM    MM 8M\"\"\"\"\"\" \`YMMMa. 
\`Mb    MM YA.   ,A9 MM     MM    MM    MM YM.    , L.   I8 
 \`Wbmd\"MML.\`Ybmd9'  \`Mbmo.JMML..JMML..JMML.\`Mbmmd' M9mmmP'  written by tona0516.
"
echo "--------------------------------------------------------------------------------"

DOTPATH=~/dotfiles
EXCLUDED_DOTFILES=(.git .gitignore .gitmodules .gitconfig)

check_installed() {
    base_error_description=" is not installed. Please install it before \"make install\"."
    if ! type $1 > /dev/null 2>&1; then
        echo $1$base_error_description
        exit 1
    fi
}

# check if the following commands are installed
check_installed git
check_installed curl
check_installed vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create synbolic links of each dotfile
for f in .??*
do
    should_create_link=true
    for excluded in ${EXCLUDED_DOTFILES[@]}
    do
        [ "$f" = "$excluded" ] && should_create_link=false && break
    done
    [ $should_create_link = true ] && ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

# create synbolic links of directory in .config
mkdir -p $HOME/.config
for d in .config/*
do
    ln -snfv "$DOTPATH/$d" "$HOME/.config"
done

# install vim plugins
vim +PlugInstall +qall

exec zsh -l
