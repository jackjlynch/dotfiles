# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pygmalion"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  common-aliases
  dirhistory
  git-extras
  history 
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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ "$(whoami)" == "jalyn" ]]; then
  export GOMACLIENTDIR=${HOME}/tools/gomaclient/goma-linux
  export PATH=${HOME}/bin:$GOMACLIENTDIR:$PATH
  export NINJA_STATUS='[%r running, %f/%t @ %c/s %o/s : %es ]'
  export DEVTOOLS_BUILD_FLAVOR=release_x64
  export ES_TELEMETRY_WARN_PSUTIL=0
  export NINJA_CHECK_ARGS_GN=0
  export NINJA_CHECK_ALL_TARGET=0
  export AT_WORK=1
  alias gngen=gngen.sh
  alias cmd="(cd /mnt/c/Users/JALYN && cmd.exe)"
  alias gcdesc="PYTHONPATH=~/.local/lib/python3.6/site-packages/ git cl desc"
  alias gcup="PYTHONPATH=~/.local/lib/python3.6/site-packages/ git cl upload"

	alias edge_server="(cd ~/edge/src/third_party/blink/renderer/devtools && npm run server)"
	alias chromium_server="(cd ~/chromium/src/third_party/blink/renderer/devtools && npm run server)"

  alias chranary="/mnt/c/Users/JALYN/AppData/Local/Google/Chrome\ SxS/Application/chrome.exe"
  alias canary="/mnt/c/Users/JALYN/AppData/Local/Microsoft/Edge\ SxS/Application/msedge.exe"
  alias dev="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge\ Dev/Application/msedge.exe"

  function dtt {
    target="Default"
    if is_edge; then
      target="release_x64"
    fi
    dtrun test --target=$target http/tests/devtools/${1} --no-retry-failure
  }

  function is_edge {
    [[ "$(pwd | awk -F / '{print $4}')" == 'edge' ]]
    return
  }
fi

if [[ "$(cat /proc/version)" == *"microsoft"* ]]; then
  export WINDOWS_IP="$(route -n | awk 'NR==3{print $2}')"
  export DISPLAY=$WINDOWS_IP:0.0
fi

alias gpu="git push -u origin \$(git symbolic-ref --short HEAD)"

unsetopt histverify

export PATH=${HOME}/.local/bin:$PATH
if [ -x "$(command -v yarn)" ]; then
  export PATH=$PATH:$(yarn global bin)
fi
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

eval "$(direnv hook zsh)"

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
    export EDITOR='nvr -cc split --remote-wait'
    export GIT_EDITOR='nvr -cc split --remote-wait'
  fi
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fbr - checkout git branch
# from https://github.com/junegunn/fzf/wiki/examples#git
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

if [ -n "$VIMRUNTIME" ]; then
  direnv reload
fi
