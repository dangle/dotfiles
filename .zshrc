#---- ZSH Plugins --------------------------------------------------------------
[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

export STARSHIP_LOG=error

. ${ZDOTDIR:-~}/.antidote/antidote.zsh
. ~/.zstyle

antidote load &>/dev/null
#===============================================================================

#---- Codespaces Configuration -------------------------------------------------
if [[ "$(cat /proc/self/cgroup)" == "0::/" ]]; then
    export CONTAINER=1
fi
#===============================================================================

#---- Homebrew Configuration ---------------------------------------------------
if [ -d /home/linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
#===============================================================================

#---- ZSH Configuration --------------------------------------------------------
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Hack: force SHELL value because VSCode launches zsh through bash
export SHELL=/usr/bin/zsh

# Add user and local binaries to PATH
export PATH="$HOME/.fzf/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

# Use less preprocessors
export FPATH="${FPATH}:~/.fpath"
export LESSOPEN='| lessfilter-fzf %s'

# Add support for WezTerm
. ~/.wezterm.sh

# Setup fzf keybindings and completions
source <(fzf --zsh)

# Set zsh options
unsetopt correct_all
setopt extended_glob
setopt HIST_IGNORE_ALL_DUPS

# Configure special keys for some terminals
if [[ "${OSTYPE}" == "linux"* ]]; then
    bindkey '\eOH' beginning-of-line # Home
    bindkey '\e[2~' overwrite-mode   # Insert
    bindkey '\e[3~' delete-char      # Delete
    bindkey '\eOF' end-of-line       # End
fi

# Configure OSX special keys
if [[ "${OSTYPE}" == "darwin"* ]]; then
    bindkey '^[[H' beginning-of-line # Home
    bindkey '^[[2~' overwrite-mode   # Insert
    bindkey '^[[3~' delete-char      # Delete
    bindkey '^[[F' end-of-line       # End
fi

# Configure container special keys
if [[ -v CONTAINER ]]; then
    bindkey '^[[1~' beginning-of-line # Home
    bindkey '^[[2~' overwrite-mode    # Insert
    bindkey '^[[3~' delete-char       # Delete
    bindkey '^[[4~' end-of-line       # End
fi

# Configure keys for the history-substring-search plugin
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
#===============================================================================

#---- Aliases ------------------------------------------------------------------
alias cd=z

alias upgrayedd="sudo systemctl start reflector ; script -qc 'yay -Syu --batchinstall --devel --overwrite \* --noconfirm' /dev/null | lolcat"

if [ -f /usr/bin/herbstclient ]; then
    alias hc=herbstclient
fi
#===============================================================================

#---- Editor Configuration -----------------------------------------------------
export VISUAL=nvim
export EDITOR="${VISUAL}"
export QUOTING_STYLE=literal

if command -v nvim &>/dev/null; then
    alias vi=nvim
    alias vim=nvim
elif command -v vim &>/dev/null; then
    alias vi=vim
fi
#===============================================================================

# ---- SSH Agents --------------------------------------------------------------
if [[ $(uname) == "Linux" && -n "$DESKTOP_SESSION" ]]; then
    eval $(gnome-keyring-daemon --start 2>/dev/null)
    export SSH_AUTH_SOCK
fi
#===============================================================================

#---- JQ configuration ---------------------------------------------------------
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'
#===============================================================================

#---- Python Configuration -----------------------------------------------------

# Do not create *.pyc files
export PYTHONDONTWRITEBYTECODE=1

# Use pyenv if available
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
#===============================================================================

#---- NPM Configuration --------------------------------------------------------
export PATH="$HOME/.npm-packages/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#===============================================================================

#---- Golang Configuration -----------------------------------------------------
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"
#===============================================================================

#---- Rust Configuration -------------------------------------------------------
export PATH="$HOME/.cargo/bin:$PATH"
#===============================================================================

#---- Kubernetes Configuration -------------------------------------------------
if command -v kubectl &>/dev/null; then
    # Use kubecolor of kubectl when available
    command -v kubecolor >/dev/null 2>&1 && \
      alias kubectl=kubecolor && \
      compdef kubecolor=kubectl

    # Short aliases
    alias k=kubectl
    compdef k=kubectl
    alias kctx='kubectl config use-context'
    alias kg='kubectl get'
    alias kl='kubectl logs'

    command -v fzf >/dev/null 2>&1 && { 
	    source <(kubectl completion zsh | sed 's#${requestComp} 2>/dev/null#${requestComp} 2>/dev/null | head -n -1 | fzf  --multi=0 #g')
    }

    export PATH="$HOME/.krew/bin"
fi
#===============================================================================

if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi
