###############################################################################
# Aliases
###############################################################################
if [ -f ~/.baseten_aliases ]; then
  source ~/.baseten_aliases
fi

###############################################################################
# Starship
###############################################################################
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

if which starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

###############################################################################
# Tmux
###############################################################################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SHELL=$(which zsh)

###############################################################################
# Histfile
###############################################################################
# Custom function to save history in UTF-8
function zshaddhistory_force_utf8() {
  print -sr -- "${1%%$'\n'}"
  fc -p "$HISTFILE"
  return 0
}

add-zsh-hook zshaddhistory zshaddhistory_force_utf8

setopt HIST_FCNTL_LOCK
setopt SHARE_HISTORY
unsetopt HIST_SAVE_BY_COPY
