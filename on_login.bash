WORKHOST="fab06.cecs.pdx.edu"
SCHOOLHOST="ada.cs.pdx.edu"
# alias clearall="clear && printf '\e[3J'"
# if TMUX env variable is NOT set and hostname is school or workhost, attach to tmux
if [ -z "$TMUX" ] && { [[ "$HOSTNAME" = $WORKHOST ]] || [[ "$HOSTNAME" = $SCHOOLHOST ]]; } ; then
    tmux a
fi

