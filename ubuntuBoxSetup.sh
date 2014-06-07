#!/bin/bash
# setup for an Ubuntu Distro
# specifically xubuntu
#
# You will need to chmod u+x ubuntuBoxSetup.sh in order to run it

echo "*****update & upgrade*****"
sudo apt-get update
sudo apt-get -y upgrade

echo "*****installing vim, emacs, terminator, curl, etc*****"
sudo apt-get install -y git
sudo apt-get install -y terminator
sudo apt-get install -y curl
#sudo apt-get install -y gnome-do
sudo apt-get install -y emacs24-nox
sudo apt-get install -y build-essential
sudo apt-get install -y calibre
sudo apt-get install -y clementine
sudo apt-get install -y inkscape
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

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
cd Downloads
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
echo "" >> .bashrc
echo "# node" >> .bashrc
echo "source ~/.nvm/nvm.sh" >> .bashrc
source ~/.nvm/nvm.sh
nvm install 0.10.28
nvm alias default 0.10.28
npm install -g jshint
npm install jasmine-node -g
cd $HOME

echo "*****install exercism*****"
curl -s http://cli.exercism.io/install | sh
cd projects
mkdir exercism
cd $HOME

echo "*****mongoDB*****"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-10gen

echo "*****install oracle java for webstorm*****"
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java7-installer

echo "*****Reload bash*****"
cd $HOME
source .bashrc

# ToDo:

