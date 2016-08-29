#!/bin/bash
# setup for an Debian/Ubuntu Based Distro
#
# You will need to chmod u+x virtualBoxSetup.sh in order to run it

echo "*****update & upgrade*****"
sudo apt-get update
sudo apt-get -y upgrade

echo "*****installing vim, emacs, terminator, curl, etc*****"
sudo apt-get install -y git
sudo apt-get install -y terminator
sudo apt-get install -y curl
sudo apt-get install -y emacs24-nox
sudo apt-get install -y build-essential

echo "*****Setting up my dotfiles*****"

echo "*****Gitting dotfiles*****"
cd $HOME
git clone https://github.com/frankd0331/dotfiles.git

echo "*****Setting up Terminator dotfiles*****"
cd .config
mkdir terminator
cd terminator
ln -sb ~/dotfiles/config.terminator config

echo "*****Make a home bin dir*****"
cd $HOME
mkdir bin

echo "*****ln .emacs*****"
ln -sb dotfiles/.emacs.d

echo "*****disabling <Ctrl-s> in terminal*****"
cd $HOME
echo "" >> .bashrc
echo "# disable <Ctrl-s> in terminal" >> .bashrc
echo "stty -ixon" >> .bashrc

echo "*****enabling 256 colors in terminal*****"
sudo apt-get install -y ncurses-term
echo "" >> .bashrc
echo "# enabling 256 colors in terminal" >> .bashrc
echo "export TERM=xterm-256color" >> .bashrc

echo "*****make the projects directory*****"
cd $HOME
mkdir projects

echo "*****add home bin to path*****"
echo "" >> .bashrc
echo "# I thought my home bin was already in path, but just in case" >> .bashrc
echo "export PATH=$PATH:/home/frankd/bin" >> .bashrc

echo "*****Reload bash*****"
cd $HOME
source .bashrc

# ToDo:
