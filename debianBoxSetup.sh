#!/bin/bash
# setup for a Debian Stable box
# I'm just learning this stuff so if you're reading this
# it's probably best to look elsewhere
#
# You will need to chmod u+x debianBoxSetup.sh in order to run it

# not sure if this should be part of the script
# also not sure if I should put -y in the UPGRADE line
echo "*****update & upgrade*****"
sudo apt-get update
sudo apt-get -y upgrade

echo "*****installing vim, emacs, terminator, curl*****"
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y terminator
sudo apt-get install -y curl
sudo apt-get install -y haskell-platform
sudo apt-get install -y racket
sudo apt-get install -y openjdk-7-jdk

echo "*****myppa.list*****"
cd $HOME
mkdir tmp
touch tmp/myppa.list
echo "deb http://emacs.naquadah.org/ stable/" >> tmp/myppa.list
echo "deb http://packages.erlang-solutions.com/debian wheezy contrib" >> tmp/myppa.list
sudo cp tmp/myppa.list /etc/apt/sources.list.d/
rm tmp/myppa.list

echo "*****Installing Emacs 24*****"
# not sure if the following wget is needed
wget -q -O - http://emacs.naquadah.org/key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y emacs-snapshot-nox

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

echo "*****ln .xmonad*****"
ln -sb dotfiles/.xmonad
cd bin
ln -sb ~/dotfiles/xmonad.start
# I'll think about how I want to change xmonad.desktop later

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

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

cd bin
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod u+x lein
cd $HOME

echo "*****Reload bash*****"
cd $HOME
source .bashrc

# ToDo:
# Test
