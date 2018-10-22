# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="tjkirch_mod"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-machine docker-compose kitchen aws kubectl minikube helm)

# User configuration
POTION=~/git/remote/potion/bin

export GOPATH=~/Projects/go
export GEM_PATH=${HOME}/.gem
export PATH="$HOME/.local/bin:/usr/texbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Library/Haskell/bin:$POTION:$GOPATH/bin:${HOME}/.gem/bin"

source $ZSH/oh-my-zsh.sh
if [ -r $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

# Pager for nicer work with Git logs
export PAGER='less -R -X -e'

if [ -x /usr/local/bin/docker-machine ]; then
    if [ $(/usr/local/bin/docker-machine status default 2>/dev/null | grep -q -v 'Stopped') ]; then
        eval $(/usr/local/bin/docker-machine env default)
    else
        # echo "docker-machine default is not running; not setting environment."
    fi
fi

autoload -U promptinit
promptinit