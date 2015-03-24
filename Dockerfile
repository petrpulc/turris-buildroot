# OpenWRT buildroot docker image
# use debian as build os
FROM debian:latest
MAINTAINER Alex Samorukov
# install packages needed to build OS and packages
RUN apt-get update
RUN apt-get install -y gawk unzip ncurses-dev git-core build-essential libssl-dev subversion mercurial wget gettext procps
# add builder uid/gid
RUN useradd --home /opt/turris builder
RUN mkdir /opt/turris && chown builder:builder /opt/turris
WORKDIR /opt/turris
# remove root password to allow su and switch to builder
RUN passwd -d root
USER builder
# create OpenWRT buildroot in /opt/turris/openwrt
RUN git clone https://gitlab.labs.nic.cz/turris/openwrt.git && cd openwrt && git submodule init && git submodule update
WORKDIR /opt/turris/openwrt
# update all feeds
RUN scripts/feeds update -a
