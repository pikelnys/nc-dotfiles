export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.node/bin:$PATH

alias gi="git"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias cd..="cd .."
alias cd...="cd ../.."
alias vibp="vi ~/.bash_profile && source ~/.bash_profile"
alias sourcebp="source ~/.bash_profile"
alias xai="cd ~/xdotai"
alias userhome="cd ~/xdotai/user-home"
alias console="cd ~/xdotai/console"
alias tconsole="cd ~/xdotai/trainer-console"
alias common="cd ~/xdotai/common-js"
alias utils="cd ~/xdotai/utils"
alias wfm="cd ~/xdotai/workflow-manager"
alias dummydata="node ~/xdotai/utils/db/dummydata/"
alias mongo_prod="MONGO_URI='' MONGO_SLAVE_OPTIONS=''"
alias mongo_local="MONGO_URI=''"
alias ns="npm start"
alias nt="npm test"
alias nrr="npm run remote"
alias la="ls -a"

export EDITOR=vim

export PS1="\[\033[33m\]${bold}\w ${normal}\033[32m\]\$(wrap_git_branch)\[\033[00m\]\n\t > "

function psag() {
  ps aux | grep $1
}
alias psagn="psag node"

function awsin() {
  ssh ubuntu@`aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --output text  | awk -F "\t" '$1=="PRIVATEIPADDRESSES" {print $4; exit}'`
}

function remote_mongo() {
}

function mongo_remote() {
}

function remote_api() {
}

#Terminal prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

wrap_git_branch() {
  BRANCH=`parse_git_branch`
  if [[ -n $BRANCH ]]; then
    echo " ($BRANCH)"
  fi
}

# stash, co master, pull, co working branch, rebase, stash pop
# G(it) R(e)B(ase)
grb () {
  CHANGES=`git stash`
  OLD_BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git checkout master
  git pull
  git checkout $OLD_BRANCH
  git rebase master

  if [[ $? != 0 ]]; then
    exit
  fi

  if [[ $CHANGES != "No local changes to save" ]]; then
    git stash pop
  fi
}


#git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh
fi

ulimit -n 10240
