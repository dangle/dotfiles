#---- Spaceship Prompt Configuration ------------------------------------------
export SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  package
  node
  golang
  rust
  docker
  aws
  venv
  pyenv
  kubectl
  terraform
  exec_time
  line_sep
  jobs
  exit_code
  char
)
export SPACESHIP_EXIT_CODE_SHOW
export DISABLE_AUTO_TITLE="true"
#==============================================================================



#---- ZSH Plugins -----------------------------------------------------------------
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

antigen theme denysdovhan/spaceship-prompt

antigen apply
#==============================================================================



#---- ZSH Configuration ----------------------------------------------------
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

unsetopt correct_all
setopt extended_glob
setopt HIST_IGNORE_ALL_DUPS

# Configure special keys for some terminals
bindkey '\eOH'  beginning-of-line  # Home
bindkey '\e[2~' overwrite-mode     # Insert
bindkey '\e[3~' delete-char        # Delete
bindkey '\eOF'  end-of-line        # End

# Configure OSX special keys
bindkey '^[[H'  beginning-of-line  # Home
bindkey "^[[2~" overwrite-mode     # Insert
bindkey "^[[3~" delete-char        # Delete
bindkey '^[[F'  end-of-line        # End

# Configure keys for the history-substring-search plugin
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export PATH="$PATH:$HOME/bin"
#==============================================================================



# ---- SSH Agents -------------------------------------------------------------
if [[ $(uname) == "Linux" && -n "$DESKTOP_SESSION" ]]
then
    eval $(gnome-keyring-daemon --start 2>/dev/null)
    export SSH_AUTH_SOCK
fi
#==============================================================================



#---- Python Configuration ---------------------------------------------------
export PYTHONDONTWRITEBYTECODE=1

if command -v pyenv &>/dev/null
then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
#=============================================================================



#---- NPM Configuration ------------------------------------------------------
export PATH="$HOME/.npm-packages/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#=============================================================================



#---- Golang Configuration ---------------------------------------------------
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"
#=============================================================================



#---- Rust Configuration -----------------------------------------------------
export PATH="$HOME/.cargo/bin:$PATH"
#=============================================================================



#---- Editor Configuration ----------------------------------------------------
export EDITOR=nvim
export QUOTING_STYLE=literal

alias vi=nvim
alias vim=nvim
#==============================================================================



#---- Kubernetes Configuration ------------------------------------------------
source <(kubectl completion zsh)
#==============================================================================



#---- Machine Specific Configuration ------------------------------------------
if [ -f ~/.zshrc.local ]
then
    source ~/.zshrc.local
fi
#==============================================================================


alias ls="ls --color"
alias upgrayedd="script -qc 'yay -Syyuu --batchinstall --noconfirm' /dev/null | lolcat"
