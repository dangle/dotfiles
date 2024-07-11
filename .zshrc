#---- Spaceship Prompt Configuration -------------------------------------------
export SPACESHIP_PROMPT_ORDER=(
    user
    dir
    host
    git
    package
    node
    golang
    rust
    aws
    python
    venv
    kubectl
    terraform
    exec_time
    line_sep
    jobs
    exit_code
    char
)
export SPACESHIP_EXIT_CODE_SHOW
export SPACESHIP_PROMPT_ASYNC=false
export DISABLE_AUTO_TITLE="true"
#===============================================================================

#---- ZSH Plugins --------------------------------------------------------------
source ~/.antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-extras
antigen bundle python
antigen bundle pip
antigen bundle aws
antigen bundle docker
antigen bundle sudo
antigen bundle systemd
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen theme spaceship-prompt/spaceship-prompt

antigen apply &>/dev/null
#===============================================================================

#---- ZSH Configuration --------------------------------------------------------
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export SHELL=/usr/bin/zsh

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

# Configure devcontainer special keys
if [[ "$(cat /proc/self/cgroup)" == "0::/" ]]; then
    bindkey '^[[1~' beginning-of-line # Home
    bindkey '^[[2~' overwrite-mode   # Insert
    bindkey '^[[3~' delete-char      # Delete
    bindkey '^[[4~' end-of-line       # End
fi

# Configure keys for the history-substring-search plugin
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export PATH="$HOME/bin:/usr/local/bin:$PATH"
#===============================================================================

# ---- SSH Agents --------------------------------------------------------------
if [[ $(uname) == "Linux" && -n "$DESKTOP_SESSION" ]]; then
    eval $(gnome-keyring-daemon --start 2>/dev/null)
    export SSH_AUTH_SOCK
fi
#===============================================================================

#---- Python Configuration -----------------------------------------------------
export PYTHONDONTWRITEBYTECODE=1

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

#---- Editor Configuration -----------------------------------------------------
export EDITOR=nvim
export QUOTING_STYLE=literal

if command -v nvim &>/dev/null; then
    alias vi=nvim
    alias vim=nvim
elif command -v vim &>/dev/null; then
    alias vi=vim
fi
#===============================================================================

#---- Kubernetes Configuration -------------------------------------------------
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
    command -v kubecolor >/dev/null 2>&1 && \
      alias kubectl=kubecolor && \
      compdef kubecolor=kubectl
    alias k=kubectl
    compdef k=kubectl
    alias kctx='kubectl config use-context'
    alias kg='kubectl get'
    alias kl='kubectl logs'
    alias klf='kubectl logs -f'
fi
#===============================================================================

#---- Codespaces Configuration -------------------------------------------------
if command -v gh &>/dev/null; then
    function cs() {
        local ws="${1}"
        local index="${2:-0}"
        local cs=$(PAGER= gh cs list -L 1 --json name -q ".[${index}].name")
        local disp=$(PAGER= gh cs list -L 1 --json displayName -q ".[${index}].displayName")
        local title=""

        if [[ ! -z "${ws}" ]]; then
            if [[ ${index} > 0 && ! -z "${disp}" ]]; then
                title="${ws} [${disp}]"
            else
                title="${ws}"
            fi
        elif [[ ! -z "${disp}" ]]; then
            title="${disp}"
        fi

        command -v kitty &>/dev/null && [[ "${TERM}" == "xterm-kitty" ]] && kitty @ set-tab-title "${title}"
        gh cs ssh -c "${cs}" -- \
            -t \
            "cd /workspaces/${ws} 2>/dev/null || cd /workspaces ; zsh"
        command -v kitty &>/dev/null && [[ "${TERM}" == "xterm-kitty" ]] && kitty @ set-tab-title ""
    }
fi
#===============================================================================

#---- JQ configuration ---------------------------------------------------------
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'
#===============================================================================

#---- Machine Specific Configuration -------------------------------------------
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

setopt +o nomatch
source ~/.*fleetrc 2>/dev/null
setopt -o nomatch
#===============================================================================

#---- Aliases ------------------------------------------------------------------
alias ls="ls --color"
alias upgrayedd="sudo systemctl start reflector ; script -qc 'yay -Syu --batchinstall --devel --overwrite \* --noconfirm' /dev/null | lolcat"
alias hc=herbstclient
alias ssh="ssh -A"

if [ -f /usr/bin/batcat ]; then
    alias bat=batcat
fi
#===============================================================================
