# need this packages
# yum install -y \
#   curl \
#   git \
#   make \
#   gcc \
#   ncurses-devel

if [ -z `ls | grep vim/`]; then
    git clone https://github.com/vim/vim
fi
cd vim && ./configure --prefix=$HOME/local --with-features=huge --enable-multibyte --disable-selinux
make && sudo make install
