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
