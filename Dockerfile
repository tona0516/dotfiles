FROM centos:centos7
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y update && \
    yum clean all && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV LANG="ja_JP UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

LABEL maintainer="tona0516 <tonango.0516@gmail.com>"

RUN useradd -g wheel tonango
RUN echo "tonango ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN yum update -y
RUN yum install -y sudo zsh git vim make gcc ncurses-devel
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs

USER tonango
WORKDIR /home/tonango

COPY --chown=tonango:tonango . /home/tonango/dotfiles

