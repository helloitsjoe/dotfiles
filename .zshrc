# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="gianu"
# ZSH_THEME="robbyrussell"
ZSH_THEME="crunch"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias gz="gzip -c $1 | wc -c"
alias c="code ."
alias v="vim ."
alias vimrc="vim ~/.vimrc"
alias z="vi ~/.zshrc"
alias sz="source ~/.zshrc"
alias ns="npm start"
alias ni="npm i"
alias nrb="npm run build"
alias nrw="npm run watch"
alias t="npm t"
alias tc="t -- --coverage"
alias tw="t -- --watch"
alias ts="t -- --silent"
alias tws="t -- --watch --silent"
alias twc="t -- --watch --coverage"
alias yt="yarn test"
alias yw="yarn watch"
alias yb="yarn build"
alias ys="yarn start"
alias yd="yarn dev"
alias ytw="yt --watch"
alias yts="yt --silent"
alias ytc="yt --coverage"
alias ytwc="yt --watch --coverage"
alias ytws="yt --watch --silent"
alias p="pnpm"
alias gcdf="git clean -df"
alias gcam="git add . && git commit -m"
alias gmm="gco main && git pull && gco - && git merge main"
alias glg="git log --graph --oneline"
alias glc="git rev-parse --short HEAD | tr -d '\n' | pbcopy && echo 'Copied hash'"
alias gpx="git log -p -S"
alias his="history | grep"
function gcamp() { gcam $1 && git push; }
function mk() { mkdir -p $1 && cd $1; }
alias testpack="npm pack && tar -xvzf *.tgz && rm -rf package *.tgz"
alias npkill="npx npkill"
alias diskusage="du -k ./* | awk '$1 > 500000' | sort -nr"
# alias diskspace="du -h ./* -d2 | grep 'G\t'"
alias prettyjson="pbpaste | jq '.' | pbcopy"
alias pruneLocal="git branch -vv | grep origin | grep ': gone' | awk '{print $1}' | xargs -L 1 git branch -d"
# alias prunelocal="git branch --merged main | grep -v "main" | xargs -n 1 git branch -d"
alias pruneRemote="git remote prune origin"
alias deleteremote="git push -d origin"

function findfileswithcontents() {
  grep -rl --exclude-dir={node_modules,coverage} --exclude=\*.lock "$1" .
}

function findandreplace() {
  findfileswithcontents | xargs sed -i '' "s/$1/$2/"
}

#WF
alias vm="ssh dev-gcp"
alias yv!="yarn version!"
alias n8="nvm use 8.16.2"
alias devdoctor="bash dev_doctor/src/dev_doctor"

function cdp() {
  package=$1
  dir=$(yarn --silent workspace $package exec --silent pwd)
  cd $dir
}

# Docker
alias d="docker"
alias dps="docker ps"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcr="docker-compose run --rm"
alias dsize="la ~/Library/Containers/com.docker.docker/Data/vms/0/data/"
alias dprune="docker image prune -a"
alias dpruneall="docker system prune -a"
alias dlist="docker ps -a -q"
alias dstopall="docker stop $(dlist)"
alias drmall="docker rm $(dlist)"

# k8s
alias k="kubectl"
alias kuc="k config use-context"
alias kgc="k config get-contexts"
function kpods() {
  namespace="${1:-$(basename $(pwd))}"
  kubectl -n $namespace get pods
}
function klogs() {
  pod_id="${1:-$(kpods | grep $(basename $(pwd)) | awk {'print $1'})}"
  namespace="${2:-$(basename $(pwd))}"
  kubectl logs $pod_id -n $namespace 
}
function kh() {
  namespace="${1:-$(basename $(pwd))}"
  echo $namespace
  kubectl -n $namespace describe hpa
}
function kauth() {
  # mv $1 ~/.kube/config
  mv ~/Downloads/kubecfg.yaml ~/.kube/config
}

# GIF
function gif() {
  # ffmpeg -i $1.mov -vf scale=480:-1 -r 15 gif/ffout%3d.png
  ffmpeg -i $1.mov -pix_fmt rgb8 -r 15 -vf scale=480:-1 $1.gif
  # convert -layers Optimize $1.gif $1-small.gif
}

# local
if [[ -f ~/.local.zsh ]]; then
  echo "sourcing local.zsh..."
  source ~/.local.zsh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
