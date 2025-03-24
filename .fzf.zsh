# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dangle/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/dangle/.fzf/bin"
fi

source <(fzf --zsh)
