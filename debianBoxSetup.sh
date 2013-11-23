#!/bin/bash
# setup for a Debian Stable box
# I'm just learning this stuff so if you're reading this
# it's probably best to look elsewhere
#
# You will need to chmod u+x debianBoxSetup.sh in order to run it

# not sure if this should be part of the script
# also not sure if I should put -y in the UPGRADE line
sudo apt-get update
sudo apt-get upgrade

echo "*****installing vim, emacs, terminator, curl*****"
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y terminator
sudo apt-get install -y curl
sudo apt-get install -y g++

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

echo "*****install Clojure*****"
cd $HOME
cd bin
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod 755 lein
cd $HOME

# ToDo:
# install Node
# install Haskell

echo "*****Reload bash*****"
cd $HOME
source .bashrc
