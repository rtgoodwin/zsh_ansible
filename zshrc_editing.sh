# ====================
# Home Directory Setup
# ====================
export USER_HOME="${HOME}"

# ====================
# ZSH Configuration
# ====================
# Basic ZSH settings
HISTFILE="${USER_HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY_TIME
setopt autocd

# Oh-My-ZSH settings
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# Update settings
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# HIST_STAMPS="mm/dd/yyyy"

# ZSH Plugins
plugins=(virtualenv z history sudo git zsh-autosuggestions fzf-tab)
source "${USER_HOME}/.zsh-plugins/zsh-z/zsh-z.plugin.zsh"

# ====================
# Shell Integrations
# ====================
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(direnv hook zsh)"
[ -f "${USER_HOME}/.fzf.zsh" ] && source "${USER_HOME}/.fzf.zsh"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -e "${USER_HOME}/.iterm2_shell_integration.zsh" && source "${USER_HOME}/.iterm2_shell_integration.zsh"
. "${USER_HOME}/.wrikepy_complete.zsh"
. "${USER_HOME}/.zsh/my_functions.zsh"
. "${USER_HOME}/.config/wezterm/wezterm.sh"

# ====================
# Environment Variables
# ====================
export LANG=en_US.UTF-8
export EDITOR="code-insiders"

# ====================
# Path Configuration
# ====================
# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Node/NPM/Yarn
export PATH="${USER_HOME}/.yarn/bin:${USER_HOME}/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/opt/homebrew/opt/node@18/bin"
export PATH="$PATH:${USER_HOME}/.config/yarn/global"

# PNPM
export PNPM_HOME="${USER_HOME}/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Bun
export BUN_INSTALL="${USER_HOME}/.bun"
[ -s "${USER_HOME}/.bun/_bun" ] && source "${USER_HOME}/.bun/_bun"

# Other paths
export PATH="$PATH:~/scripts/"
export PATH=$PATH:~/.adt/bin
export PATH=$PATH:${USER_HOME}/go/bin
export PATH="$PATH:${USER_HOME}/.local/bin"
[[ :$PATH: == *:${USER_HOME}/bin:* ]] || PATH=${USER_HOME}/bin:$PATH

# ====================
# Python Configuration
# ====================
# Conda initialization
__conda_setup="$('${USER_HOME}/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${USER_HOME}/miniforge3/etc/profile.d/conda.sh" ]; then
        . "${USER_HOME}/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="${USER_HOME}/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

# ====================
# Node Version Manager
# ====================
export NVM_DIR="${USER_HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" "--no-use"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ====================
# Aliases
# ====================
alias grep=egrep
alias lpsql='psql -h localhost -p 5433 -U postgres -d postgres'
alias lst='lsd --tree'
alias lao='/bin/ls -laO'
alias colors="~/scripts/colors.sh"
alias ibrew="arch -x86_64 /opt/brew/bin/brew"
alias flows="~/flows.sh"
alias hg="history | grep $1"
alias xhead='f() { xsv slice -e 20 $1 | xsv table};f'
alias empty='echo "Empty string regex: '^.{0}$'"'
alias lc='f() { wc -l < $1 };f'
alias lines='f() { wc -l < $1 };f'
alias ma='f() { mamba activate $1 };f'
alias md='mamba deactivate'
alias ib='PATH=/usr/local/bin'
alias awho='whois -h whois.apple.com'
alias ls='lsd -latrh'
alias history="history 1"
alias triplet="rustc -Vv | grep host | cut -f2 -d' '"
alias platform="rustc -Vv | grep host | cut -f2 -d' '"
alias p=pbpaste
alias c=pbcopy
alias fdd='fd -d 1'

# Xcode related aliases
alias 'xclear=rm -rf ~/Library/Developer/Xcode/DerivedData && rm -rf ~/Library/Developer/Xcode/DerivedData'
alias 'lsdump=/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump'
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister'
alias lskill='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -R -f -u -v ~/Library/Developer/Xcode/DerivedData'
alias lsadd='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -R -f -v ~/Library/Developer/Xcode/DerivedData'
alias 'archives=/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -R -f -u -v ~/Library/Developer/Xcode/DerivedData/Archives'

# ====================
# Functions
# ====================
# Utility Functions
function img-data() {
  TYPE=$(file --mime-type -b $1)
  ENC=$(base64 -i $1)
  echo "data:$TYPE;base64,$ENC"
}

# Weather Functions
w3() {
    ZONE=78665
    printf '\e[8;50;150t'
    if [ "$#" -gt 0 ]; then ZONE="$#"; fi
    curl -s 'wttr.in/'${ZONE}'?F'
}

wf() {
    ZONE=78665
    printf '\e[8;50;150t'
    if [ "$#" -gt 0 ]; then ZONE="$#"; fi
    curl -s 'wttr.in/'${ZONE}'?F&format=v2'
}

# Search Functions
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

fif2() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" && echo "opening $file" && open "$file" || return 1;
}

# Port Functions
port() {
    netstat -anvp tcp | awk 'NR<3 || /LISTEN/' | grep $1
}

ports() {
    sudo lsof -i -n -P | grep TCP | grep $1
}

# Docker Functions
remove_docker_container() {
  if [[ -z "$1" ]]; then
    echo "Please provide the name of the Docker container to remove."
    return 1
  fi
  local container_name=$1
  local container_id=$(docker ps -aqf "name=$container_name")
  if [[ -z "$container_id" ]]; then
    echo "No container found with name: $container_name"
  else
    docker rm $container_id
  fi
}

remove_docker_volume() {
  if [[ -z "$1" ]]; then
    echo "Please provide the name of the Docker volume to remove."
    return 1
  fi
  local volume_name=$1
  local volume_id=$(docker volume ls -qf "name=$volume_name")
  if [[ -z "$volume_id" ]]; then
    echo "No volume found with name: $volume_name"
  else
    docker volume rm $volume_id
  fi
}

# Development Functions
twnew() {
    bunx tailwindcss init -p
    cat tailwind.config.js | sed -e 's/content: \[\]/content: \["*\.html"\,"*\.svelte"\,"*\.tsx"\]/g' > tmp.js && rm tailwind.config.js && mv tmp.js tailwind.config.js
    tee input.css >/dev/null <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF
    echo "- Created and updated 'tailwind.config.js', be sure to check the content list"
    echo "- Created default $(gum style --foreground 212 'input.css')"
    echo "- Start watcher with: $(gum style --foreground 212 'twwatch')"
}

twwatch() {
    bunx tailwindcss -i input.css -o output.css -w
}

# Python Environment Functions
mkenv() {
    rm -rf venv
    uv venv
    echo "source .venv/bin/activate" > .envrc
    echo "alias pip='uv pip'" >> .envrc
    direnv allow
    alias pip='uv pip'
}

adduv() {
    script="$1"
    shift
    uv add --script "$script" "$@"
}

uvadd() {
    script="$1"
    shift
    uv add --script "$script" "$@"
}

# ====================
# Rosetta Terminal Setup
# ====================
if [ $(arch) = "i386" ]; then
    alias brew86="/usr/local/bin/brew"
    alias pyenv86="arch -x86_64 pyenv"
fi

# ====================
# Cargo/Rust Setup
# ====================
. "${USER_HOME}/.cargo/env"

# ====================
# LM Studio Setup
# ====================
export PATH="$PATH:${USER_HOME}/.cache/lm-studio/bin"
source <(acc --zsh-completions 2>/dev/null)
