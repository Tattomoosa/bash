export TERM="xterm-256color"
# smart search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind "set completion-ignore-case on"

# conda
__CONDA_PATH=/pkgs/anaconda/anaconda/etc/profile.d/conda.sh
if test -f "$__CONDA_PATH"; then
  source "$__CONDA_PATH"
fi
# git completion
source /usr/share/bash-completion/completions/git
# hostname completion
source /usr/share/bash-completion/completions/hostname

PATH="~/.bin:$PATH"
