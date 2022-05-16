# https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/7654#7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Home / End key fix in tmux and elsewhere (?)
# bindkey '\e[4~' end-of-line
# bindkey '\e[1~' beginning-of-line

# Bug in v18.09 that breaks publishing ports. Therefore any new
# docker-machines will use this image that does work.
export VIRTUALBOX_BOOT2DOCKER_URL=https://github.com/boot2docker/boot2docker/releases/download/v18.06.1-ce/boot2docker.iso
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export EDITOR=nvim
export PYTHONSTARTUP=~/.pythonrc
export TERM=gnome-256color
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig:${HOME}/.linuxbrew/bin/
export AWS_PROFILE=hiti
# ~/.docker/ca.pem isn't a thing here on Linux
export DOCKER_TLS_VERIFY=false

# https://bbs.archlinux.org/viewtopic.php?id=176987
# Fix/workaround for flickering, locks and missing menus etc for Libreoffice
export SAL_USE_VCLPLUGIN=gen

export NPM_PACKAGES="${HOME}/.local/share/npm-packages"

export PATH="${PATH}:${NPM_PACKAGES}/bin:${HOME}/.npm/"
export MANPATH="${MANPATH}:${NPM_PACKAGES}/share/man"

# PROXY=${PROXY:-proxy:3128}
NOPROXY="192.168.0.0/16,127.0.0.0/8,localhost"

alias proxy="export HTTP_PROXY=$PROXY; export HTTPS_PROXY=$PROXY; export http_proxy=$PROXY; export https_proxy=$PROXY export NO_PROXY=$NOPROXY"
alias noproxy="unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy NO_PROXY"

alias boxes='boxes -d shell -pv1'

# Use docker image to provide a java runtime
alias jdk='docker run --rm -v $PWD:/tmp -w /tmp openjdk:8'

# SSH
alias kansible='ansible -i ~/.ansible/k8s-cluster-hosts.ini'
# alias ansible='ansible -c ~/.config/ansible/ansible.cfg'

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
alias gpap='git pull --all --prune'
alias gb='git branch'
alias gba='git branch --all'
alias gc='git checkout main'
alias ggr='git grep'
alias gh='git hamster || git co ghammond'
alias gp='git pp'
alias gr='git rebm'
alias gla='git lga'
alias gl='git lg'
alias gdp='git diff production..'
alias gdps='gdp --stat'
alias gdm='git diff main..'
alias gdms='gdm --stat'

# alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias open=xdg-open

# Linux Brew - gcc requires a big tmp space so use a large volume...
export HOMEBREW_PREFIX="$HOME/.linuxbrew"
export HOMEBREW_TEMP="/var/lib/rancher/gcc"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# Compiled Emacs in Software
# export PATH="$HOME/Software/emacs/usr/local/bin:${PATH}"

# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Project
export VIRTUALENVWRAPPER_PYTHON=$HOMEBREW_PREFIX/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$HOMEBREW_PREFIX/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export VIRTUALENVWRAPPER_TMPDIR=$HOMEBREW_PREFIX/tmp
if [ -r $HOMEBREW_PREFIX/bin/virtualenvwrapper.sh ]; then
    source $HOMEBREW_PREFIX/bin/virtualenvwrapper.sh
fi

# Eyaml
KEYS_DIR="${HOME}/.gnupg/eyaml"
alias eyaml-edit='GEM_PATH=~/.gem/ eyaml edit --pkcs7-private-key=${KEYS_DIR}/private_key.pkcs7.pem --pkcs7-public-key=${KEYS_DIR}/public_key.pkcs7.pem'
function eyaml {
    GEM_PATH=~/.gem/ ~/.gem/ruby/2.3.0/bin/eyaml ${@}
}

# helper to pass parameters to ansible when needing password sudo for -b
alias become='ansible -b -e @~/.gnupg/ansible-sudo.yml --ask-vault-pass'

# function scale-down-ds {
#     kubectl -n monitoring patch daemonset ${@} -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
# }

# function scale-up-ds {
#     kubectl -n monitoring patch daemonset ${@} --type json -p='[{"op": "remove", "path": "/spec/template/spec/nodeSelector/non-existing"}]'
# }

# alias pod-per-node='kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name'
