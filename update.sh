#!/bin/bash -e
#
# Updates Vim plugins.
#
# All credit for the original file goes to Ian Langworth <statico>
# from https://github.com/statico/dotfiles/blob/master/.vim/update.sh
#
# Update everything (long):
#
#   ./update.sh
#
# Update just the things from Git:
#
#   ./update.sh repos
#
# Update just one plugin from the list of Git repos:
#
#   ./update.sh repos powerline
#

cd ~/

vimdir=$PWD/.vim
bundledir=$vimdir/bundle
tmp=/tmp/$LOGNAME-vim-update
me=.vim/update.sh

# I have an old server with outdated CA certs.
if [ -n "$INSECURE" ]; then
  curl='curl --insecure'
  export GIT_SSL_NO_VERIFY=true
else
  curl='curl'
fi

# URLS --------------------------------------------------------------------

# This is a list of all plugins which are available via Git repos. git:// URLs
# don't work.
repos=(

  # Status bar
  https://github.com/vim-airline/vim-airline

  # Fuzzy file search
  https://github.com/ctrlpvim/ctrlp.vim.git

  # Autocomplete
  #https://github.com/Valloric/YouCompleteMe.git

  # Fuzzy search project
  https://github.com/junegunn/fzf.vim.git

  # Git in the gutter
  https://github.com/airblade/vim-gitgutter.git

  # Syntax checker
  https://github.com/scrooloose/syntastic.git

  # Language-specific plugins
  https://github.com/kchmck/vim-coffee-script.git
  https://github.com/elzr/vim-json.git
  https://github.com/ap/vim-css-color.git
  https://github.com/klen/python-mode.git
  https://github.com/leafgarland/typescript-vim.git

  # The Pope of Tim
  https://github.com/tpope/vim-pathogen.git
  https://github.com/tpope/vim-abolish.git
  https://github.com/tpope/vim-surround.git
  https://github.com/tpope/vim-sensible.git
  https://github.com/tpope/vim-fugitive.git

  # Not sure what these do
  https://github.com/scrooloose/nerdcommenter.git
  https://github.com/docunext/closetag.vim.git
  https://github.com/mtth/scratch.vim.git

  # L9 Vim Uility plugins (original deleted by author
  https://github.com/eparreno/vim-l9
  
  )

# Here's a list of everything else to download in the format
# <destination>;<url>[;<filename>]
other=(

  'zenburn/colors;https://raw.githubusercontent.com/jnurmine/Zenburn/master/colors/zenburn.vim'
  'wombat/colors;http://files.werx.dk/wombat.vim'
  'coffee/colors;https://raw.githubusercontent.com/duythinht/vim-coffee/master/colors/coffee.vim'
  'molokai/colors;https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
  'solarized/colors;https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8.vim'

  )

case "$1" in

  # GIT -----------------------------------------------------------------
  repos|repo)
    mkdir -p $bundledir
    for url in ${repos[@]}; do
      if [ -n "$2" ]; then
        if ! (echo "$url" | grep "$2" &>/dev/null) ; then
          continue
        fi
      fi
      dest="$bundledir/$(basename $url | sed -e 's/\.git$//')"
      rm -rf $dest
      echo "Cloning $url into $dest"
      git clone --recursive -q $url $dest
      rm -rf $dest/.git
    done
    cd $bundledir
    git submodule update --init --recursive
    # YouCompleteMe requires an additional step:
    # cd YouCompleteMe
    # ./install.py
    # cd $OLDPWD
    ;;

  # TARBALLS AND SINGLE FILES -------------------------------------------
  other)
    set -x
    mkdir -p $bundledir
    rm -rf $tmp
    mkdir $tmp
    pushd $tmp

    for pair in ${other[@]}; do
      parts=($(echo $pair | tr ';' '\n'))
      name=${parts[0]}
      url=${parts[1]}
      filename=${parts[2]}
      dest=$bundledir/$name

      rm -rf $dest

      if echo $url | egrep '.zip$'; then
        # Zip archives from VCS tend to have an annoying outer wrapper
        # directory, so unpacking them into their own directory first makes it
        # easy to remove the wrapper.
        f=download.zip
        $curl -L $url >$f
        unzip $f -d $name
        mkdir -p $dest
        mv $name/*/* $dest
        rm -rf $name $f

      else
        # Assume single files. Create the destination directory and download
        # the file there.
        mkdir -p $dest
        pushd $dest
        if [ -n "$filename" ]; then
          $curl -L $url >$filename
        else
          $curl -OL $url
        fi
        popd

      fi

    done

    popd
    rm -rf $tmp
    ;;

  # HELP ----------------------------------------------------------------

  all)
    $me repos
    $me other
    echo
    echo "Update OK"
    ;;

  *)
    set +x
    echo
    echo "Usage: $0 <section> [<filter>]"
    echo "...where section is one of:"
    grep -E '\w\)$' $me | sed -e 's/)//'
    echo
    echo "<filter> can be used with the 'repos' section."
    exit 1

esac
