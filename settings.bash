export TERM="xterm-256color"
# smart search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind "set completion-ignore-case on"
# conda
source /pkgs/anaconda/anaconda/etc/profile.d/conda.sh
# git completion
source /usr/share/bash-completion/completions/git
# hostname completion
source /usr/share/bash-completion/completions/hostname

PATH="~/.bin:$PATH"
