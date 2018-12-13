#!/bin/bash

DIR=`dirname $0`
. $DIR/util.sh

if argument vim; then
  (cd $DIR ; git submodule update --init)
  replace ~/.vim
  replace ~/.vimrc
  cp ./updat.sh ~/.vim/update.sh
  chmod +x ~/.vim/update.sh
fi

if argument tmux; then
  replace ~/.tmux.conf
fi

if argument git; then
  cp $DIR/.git-completion.sh ~
  cp $DIR/.git-branch-prompt.sh ~
fi

