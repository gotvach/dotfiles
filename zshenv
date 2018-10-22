# https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/7654#7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

export VAGRANT_DEFAULT_PROVIDER=virtualbox
export PATH=${PATH}:${HOME}/Library/Python/3.7/bin:/usr/local/opt/mysql-client/bin
export EDITOR=nvim

# Vagrant aliases
alias vgpr='vagrant provision'
alias vgs='vagrant ssh'
alias vgst='vagrant status'
alias vgsu='vagrant suspend'
alias vgd='vagrant destroy'
alias vgdf='vagrant destroy -f'
alias vgu='vagrant up'
alias vgup='vagrant up'

alias vg='vagrant'

# Git shell aliases
alias gpa='git pull --all'
alias gb='git branch'
alias gba='git branch --all'
alias gc='git checkout master'
alias gh='git hamster || git co ghammond'
alias gp='git pp'
alias gr='git rebm'
alias gla='git lga'
alias gl='git lg'
alias gdp='git diff production..'
alias gdps='gdp --stat'
alias gdm='git diff master..'
alias gdms='gdm --stat'

alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs

