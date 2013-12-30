#!/bin/bash
# setup for an Ubuntu Distro
#
# You will need to chmod u+x debianBoxSetup.sh in order to run it

echo "*****update & upgrade*****"
sudo apt-get update
sudo apt-get -y upgrade

echo "*****installing vim, emacs, terminator, curl*****"
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y terminator
sudo apt-get install -y curl
sudo apt-get install -y racket

# replace this with ubuntu appropriate emacs
# and any other needed ppa's
echo "*****myppa.list*****"
cd $HOME
mkdir tmp
touch tmp/myppa.list
#echo "deb http://emacs.naquadah.org/ stable/" >> tmp/myppa.list
sudo cp tmp/myppa.list /etc/apt/sources.list.d/
rm tmp/myppa.list

echo "*****Installing Emacs 24*****"
#wget -q -O - http://emacs.naquadah.org/key.gpg | sudo apt-key add -
#sudo apt-get update
#sudo apt-get install -y emacs-snapshot-nox

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

echo "*****install node*****"
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

echo "*****mongoDB*****"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-10gen

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

echo "*****Reload bash*****"
cd $HOME
source .bashrc

# ToDo:
# Test
