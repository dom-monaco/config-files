# If you come from bash you might have to change your $PATH.

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/dominicmonaco/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="amuse"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(gcloud kube-ps1)
source $ZSH/oh-my-zsh.sh

# ========================================================
# User configuration

eval "$(/opt/homebrew/bin/brew shellenv)"

# Preferred editor for local and remote sessions
# Set to sublime
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='subl -w'
fi


# Set personal aliases, overriding those provided by oh-my-zsh libs
# For a full list of active aliases, run `alias`

alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

alias activate_venv='. ~/workspace/venv/py.3.8/bin/activate'
alias ls='ls -1'

alias prestart='podman machine stop; podman machine start'
alias pstart='podman machine start'
alias pbuild='podman build --force-rm --no-cache -t test .'
alias pclean='podman rmi $(podman images -f "dangling=true" -q)'

# kubectl crap
alias k='kubectl'
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias which_kx='kubectl config get-contexts'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
function kex() { kubectl exec --stdin --tty $@ -- /bin/bash; }

# docker crap
alias dockerb='docker build --quiet --force-rm --no-cache -t'
alias docker_tf='docker run -it --rm -v $(pwd):$(pwd) -v /Users/$(whoami)/.ssh/id_rsa:/root/.ssh/id_rsa -v /Users/$(whoami)/.aws:/root/.aws -w $(pwd) devops-docker.ops-use1.cylance.com/terraform:latest bash'

# git crap
alias branch_cleanup='find . -maxdepth 2 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} sh -c "echo {}; cd {}; git branch | grep - | xargs git branch -D; cd .."'
alias which_branch='find . -maxdepth 2 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} sh -c "echo {}; git -C {} rev-parse --abbrev-ref HEAD"'
alias pull_all_2='find . -maxdepth 2 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull -v'
alias pull_all_3='find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull -v'
alias tg_cache='find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;; find . -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;'

# GCP crap
alias gtoken='export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)'
alias gcca="gcloud config configurations activate"
alias gccl="gcloud config configurations list"
alias glistbuckets='for b in $(gsutil ls); do gsutil du -sh $b; done'


# ========================================================
# ========================================================
# GCLOUD STUFF
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# ========================================================
# ========================================================
# SETTLE STUFF
# NVM install
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# krew path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# rbenv start
eval "$(rbenv init - zsh)"

# docker BS cus macs suck now
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# ========================================================
# ========================================================

export PATH=$PATH:/Users/dominicmonaco/.zsh_functions


