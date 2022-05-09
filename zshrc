set +x
# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export TERM=xterm-256color

set -o emacs
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# ZSH_THEME="tjkirch_mod"
# ZSH_THEME="gnzh"
# ZSH_THEME="pygmalion"
ZSH_THEME="muse"
# ZSH_THEME="kolo"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew git docker docker-machine docker-compose kitchen aws kubectl minikube helm terraform pip)

# User configuration
POTION=~/git/remote/potion/bin

export GOROOT=~/Software/go
export GOPATH=~/Projects/go
export RUBY_VER=2.7.0
export GEM_PATH="$HOME/.gem/ruby/$RUBY_VER:$HOME/.linuxbrew/lib/ruby/gems/$RUBY_VER"
export PATH="$HOME/.rbenv/shims:$HOME/.gem/ruby/$RUBY_VER/bin:$HOME/bin:$HOME/.linuxbrew/Cellar/tfenv/0.6.0/bin:$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$HOME/.local/bin:/usr/texbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Library/Haskell/bin:$POTION:$GOPATH/bin:$GOROOT/bin:$PATH"

source $ZSH/oh-my-zsh.sh
if [ -r $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

# Pager for nicer work with Git logs
export PAGER='less -R -X -e'

autoload -U promptinit
promptinit

awsls () {
    aws ec2 describe-instances \
        --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,Tags[?Key==`Name`].Value[]]' \
        --output json | \
        tr -d '\n[] "' | \
        perl -pe 's/i-/\ni-/g' | \
        tr ',' '\t' | \
        sed -e 's/null/None/g' | \
        grep '^i-' | \
        column -t \
    }

# zprof

autoload -U +X bashcompinit && bashcompinit
if [ -x tfenv ]; then
    TFENV_VER=$(tfenv --version | awk '{print $2;}')
    TF_VER=$(tfenv version-name)
    complete -o nospace -C $HOME/.linuxbrew/Cellar/tfenv/${TFENV_VER}/versions/${TF_VER}/terraform terraform
fi

xrdb -remove
[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults
