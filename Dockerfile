# docker build -t dotfiles .
# docker run -itd --name dotfiles dotfiles /bin/zsh
# docker exec -it --user tonango dotfiles /bin/zsh

# どのイメージを基にするか
FROM centos:centos6

# 作成したユーザの情報
LABEL maintainer="Admin <admin@admin.com>"

# RUN: docker buildするときに実行される
RUN echo "now building..."

# ユーザーを作成
RUN useradd -g wheel tonango
RUN echo "tonango ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 必要なパッケージをインストール
RUN yum update -y
RUN yum install -y sudo zsh git vim make gcc ncurses-devel
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs

USER tonango
WORKDIR /home/tonango
RUN git clone https://github.com/tona0516/dotfiles.git

# CMD: docker runするときに実行される
CMD echo "now running..."
