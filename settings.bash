export TERM="xterm-256color"
# smart search
# bind '"\e[A":history-search-backward'
# bind '"\e[B":history-search-forward'
bind "set completion-ignore-case on"
# git completion
source /pkgs/anaconda/anaconda/etc/profile.d/conda.sh
source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/hostname
