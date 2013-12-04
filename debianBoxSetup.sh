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
sudo apt-get upgrade

echo "*****installing vim, emacs, terminator, curl*****"
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y terminator
sudo apt-get install -y curl
sudo apt-get install -y g++
sudo apt-get install -y valgrind
sudo apt-get install -y haskell-platform
sudo apt-get install -y golang

echo "*****Installing Emacs 24*****"
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

echo "*****install jdk7*****"
sudo apt-get install -y openjdk-7-jdk

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

echo "*****Install Haskell*****"
sudo apt-get install -y haskell-platform

echo "*****Install Racket*****"
sudo apt-get install -y racket

echo "*****Install Erlang*****"
sudo echo "deb http://packages.erlang-solutions.com/debian wheezy contrib" >> /etc/apt/sources.list
wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
sudo apt-key add erlang_solutions.asc
sudo apt-get update
sudo apt-get install erlang

echo "*****Install Elixir*****"
cd $HOME
cd bin
git clone https://github.com/elixir-lang/elixir.git
cd elixir
make clean test
cd $HOME
echo "" >> .bashrc
echo "# Adding Elixir to PATH" >> .bashrc
echo "export PATH=$PATH:/home/frankd/bin/elixir/bin" >> .bashrc

echo "*****Reload bash*****"
cd $HOME
source .bashrc

# ToDo:
# Test
