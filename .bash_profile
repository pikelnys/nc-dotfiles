export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.node/bin:$PATH
export ANT_HOME="/usr/local/ant"
export PATH=$PATH:${ANT_HOME}

alias build_universe="populate-universe -Duniverse.name=gpsa-complex"

alias ui="cd ~/code/nextcapital-ui"
alias bb="cd ~/code/nextcapital-ui/app/styles/building-blocks"
alias api="cd ~/code/nextcapital-ui/app/scripts/nextcapital-api-client"
alias subl=sublime
alias vibp="vi ~/.bash_profile"
alias sourcebp="source ~/.bash_profile"
alias code="cd ~/code"

alias railsc="rails c local_production"
alias mktdata="cd ~/code/rails && RAILS_ENV=local_production rake market_data:use_latest"
alias startrails="passenger start -e local_production"

export EDITOR=vim

export PS1="\[\033[33m\]${bold}\w ${normal}\033[32m\]\$(wrap_git_branch)\[\033[00m\]\n\t > "

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
    exit 1
  fi

  if [[ $CHANGES != "No local changes to save" ]]; then
    git stash pop
  fi
}

dev_branch() {
 grunt deploy:dev --branch=$1 --dev=pikelnys
}

# mkdir and cd into new dir
mcdir () {
  mkdir -p -- "$1" && cd -P -- "$1"
}


#git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh
fi

# Load RVM into a shell session *as a function*
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

ulimit -n 10240
