# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/joe/.oh-my-zsh"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias c="code ."
alias v="vim ."
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
alias gcdf="git clean -df"
alias gcam="git add . && git commit -m"
alias gmm="gco main && git pull && gco - && git merge main"
function gcamp() { gcam $1 && git push; }
alias testpack="npm pack && tar -xvzf *.tgz && rm -rf package *.tgz"
alias npkill="npx npkill"
alias diskusage="du -k ./* | awk '$1 > 500000' | sort -nr"
alias pruneLocal="git branch -vv | grep origin | grep ': gone' | awk '{print $1}' | xargs -L 1 git branch -d"
alias pruneRemote="git remote prune origin"

# Nginx
alias nstart="sudo brew services start nginx"
alias nstop="sudo brew services stop nginx"
alias nrestart="sudo brew services restart nginx"

# Docker
alias dsize="la ~/Library/Containers/com.docker.docker/Data/vms/0/data/"
alias dprune="docker image prune -a"
alias dlist="docker ps -a -q"
alias dstopall="docker stop $(dlist)"
alias drmall="docker rm $(dlist)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
