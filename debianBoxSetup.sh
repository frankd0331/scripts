#!/bin/bash
# setup for a Debian Stable box
# I'm just learning this stuff so if you're reading this
# it's probably best to look elsewhere

# not sure if this should be part of the script
# also not sure if I should put -y in the UPGRADE line
sudo apt-get update
sudo apt-get upgrade

# installing vim, emacs, terminator, guake, curl
sudo apt-get install -y vim
sudo apt-get install -y terminator
sudo apt-get install -y guake
sudo apt-get install -y curl
sudo apt-get install -y g++

# install emacs 24
wget -q -O - http://emacs.naquadah.org/key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y emacs-snapshot-nox

# setting up my dotfiles

# get dotfiles
cd $HOME
git clone https://github.com/frankd0331/dotfiles.git

# terminator
cd .config
mkdir terminator
cd terminator
ln -sb ~/dotfiles/config.terminator config

# make a home bin dir
cd $HOME
mkdir bin

# ln .emacs.d
ln -sb dotfiles/.emacs.d

# disabling <Ctrl-s> in terminal
cd $HOME
echo "" >> .bashrc
echo "# disable <Ctrl-s> in terminal" >> .bashrc
echo "stty -ixon" >> .bashrc

# enabling 256 colors in terminal
sudo apt-get install -y ncurses-term
echo "" >> .bashrc
echo "# enabling 256 colors in terminal" >> .bashrc
echo "export TERM=xterm-256color" >> .bashrc

# make the projects directory
cd $HOME
mkdir projects

# install jdk7
sudo apt-get install -y openjdk-7-jdk

# add home bin to path
echo "" >> .bashrc
echo "# I thought my home bin was already in path, but just in case" >> .bashrc
echo "export PATH=$PATH:/home/frankd/bin" >> .bashrc

# install Clojure
cd $HOME
cd bin
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod 755 lein
cd $HOME
