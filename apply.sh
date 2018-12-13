#!/bin/bash

DIR=`dirname $0`
. $DIR/util.sh

if argument vim; then
  (cd $DIR ; git submodule update --init)
  cp ./.vimrc ~/.vim/.vimrc
  cp ./updat.sh ~/.vim/update.sh
  chmod +x ~/.vim/update.sh
  ~/.vim/update.sh
  mkdir ~/.backups
fi

if argument tmux; then
  replace ~/.tmux.conf
fi

if argument git; then
  cp $DIR/.git-completion.sh ~
  cp $DIR/.git-branch-prompt.sh ~
fi

if argument brew; then
  brew install fzf
  brew install the_silver_searcher
  brew install jq
  brew install tree
fi
