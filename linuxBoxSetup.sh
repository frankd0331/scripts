#!/bin/bash
# setup for a Ubuntu 12.04 LTS box
# should work on any debian based distro
# I'm just learning this stuff so if you're reading this
# it's probably best to look elsewhere

# not sure if this should be part of the script
# also not sure if I should put -y in the UPGRADE line
sudo apt-get update
sudo apt-get upgrade

# installing git, vim, emacs, terminator, guake, curl
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
sudo apt-get install -y terminator
sudo apt-get install -y guake
sudo apt-get install -y curl

# setting up my dotfiles

# get dotfiles
cd $HOME
git clone https://github.com/frankd0331/dotfiles.git

# terminator
cd .config
mkdir terminator
cd terminator
ln -sb ~/dotfiles/config.terminator config

# emacs with ensime
cd $HOME
mkdir bin
cd bin
wget https://www.dropbox.com/sh/ryd981hq08swyqr/ZiCwjjr_vm/ENSIME%20Releases/ensime_2.10.0-0.9.8.9.tar.gz
tar -xvf ensime_2.10.0-0.9.8.9.tar.gz
cd $HOME
ln -sb dotfiles/.emacs
# not sure how to automate it but you'll have to:
# M-x package-install RET evil RET
# in emacs to setup evil-mode

# vim
ln -sb dotfiles/.vimrc
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd .vim/bundle
git clone git://github.com/vim-scripts/tComment.git
git clone git://github.com/Lokaltog/vim-easymotion.git
git clone git://github.com/scrooloose/nerdtree.git
git clone git://github.com/derekwyatt/vim-scala.git
git clone git://github.com/dahu/Insertlessly.git
git clone git://github.com/altercation/vim-colors-solarized.git

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

# install Scala
sudo apt-get install -y openjdk-7-jdk
cd bin
wget http://www.scala-lang.org/files/archive/scala-2.10.2.tgz
tar -xvf scala-2.10.2.tgz
cd $HOME
echo "" >> .bashrc
echo "# adding Scala to path" >> .bashrc
echo "export PATH=$PATH:/home/frankd/bin/scala-2.10.2/bin" >> .bashrc

cd bin
wget http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch//0.12.4/sbt-launch.jar
cd $HOME
cd scripts
cp sbt ~/bin
cd $HOME
chmod u+x ~/bin/sbt
echo "" >> .bashrc
echo "# I thought my home bin was already in path, but just in case" >> .bashrc
echo "export PATH=$PATH:/home/frankd/bin" >> .bashrc

# install Clojure
cd $HOME
cd bin
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod 755 lein
cd $HOME
