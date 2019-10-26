#!/usr/bin/env bash

WORKHOST="fab06.cecs.pdx.edu"
SCHOOLHOST="ada.cs.pdx.edu"
# alias clearall="clear && printf '\e[3J'"
# if TMUX env variable is NOT set and hostname is school or workhost, attach to tmux
# if [ -z "$TMUX" ] && { [[ "$HOSTNAME" = $WORKHOST ]] || [[ "$HOSTNAME" = $SCHOOLHOST ]]; } ; then
#    tmux a
# fi

# Conda settings
conda config --set notify_outdated_conda false
conda config --set changeps1 false
