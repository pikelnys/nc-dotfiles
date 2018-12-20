export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.node/bin:$PATH
export PATH=/usr/local/opt/openssl/bin/:$PATH
export PATH=/Users/stevepikelny/.local/bin:$PATH
export SAILFISH_CONTRACT_PATH=~/Desktop/code/private-equity/contracts/
export GOPATH=$HOME/golang
export SYMBIONT_HOME=~/Desktop/code
export PIPENV_PIPFILE=$SYMBIONT_HOME/symbiont-node/src/sailfish/Pipfile
export NPM_TOKEN="GET A NEW NPM TOKEN"
export AWS_BUCKET=pikelnys-bucket-1
export AWS_PROFILE=qa
export AWS_SDK_LOAD_CONFIG=1

alias gi="git"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias cd..="cd .."
alias cd...="cd ../.."
alias vibp="vi ~/.bash_profile && source ~/.bash_profile"
alias sourcebp="source ~/.bash_profile"
alias ns="npm start"
alias nt="npm test"
alias la="ls -a"
alias sailfish_deps="pipenv install --dev && pipenv run python setup.py develop"
alias mock-network="pipenv run sailfish mock-network"
alias k="KUBECONFIG=kubeconfig.yaml kubectl"
function sym() {
  cd ~/Desktop/code/$1
}

alias start_canem="npm start -- --port=1338"
alias start_pe_client="VAULT_TOKEN=asdf npm start -- --symbiont.origin=http://localhost:3333 --canem.host=localhost:1338 --canem.defaultPassword=asdf --models.connection=disk"
alias restart_pe="rm $SYMBIONT_HOME/private-equity/frontend/.tmp/disk.db && rm $SYMBIONT_HOME/canem/.tmp/developmentDb.sqlite"

export EDITOR=vim

eval "$(pyenv init -)"

export PS1="\[\033[33m\]${bold}\w ${normal}\033[32m\]\$(wrap_git_branch)\[\033[00m\]\n\t > "

function docker_sh() {
  docker exec -it $1 sh
}

function hit_node() {
  http --cert=/Users/stevepikelny/.local/share/symbiont/node/$1/node-client.crt --cert-key=/Users/stevepikelny/.local/share/symbiont/node/$1/node-client.key GET https://$1/$2/ --verify=no
}

function psag() {
  ps aux | grep $1
}
alias psagn="psag node"

#Terminal prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function wrap_git_branch() {
  BRANCH=`parse_git_branch`
  if [[ -n $BRANCH ]]; then
    echo " ($BRANCH)"
  fi
}

function mcdir() {
  mkdir $1 && cd $1
}


#git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh
fi

ulimit -n 10240

. ~/.qa_scripts.sh

