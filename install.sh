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

# check git installed
if [ ! `which git` ];then
    echo "git is not installed. Please install it before \"make install\""
    exit 1
 fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create synbolic links of eash dotfile
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

# relogin zsh
vim +PlugInstall +qall
exec $SHELL -l

