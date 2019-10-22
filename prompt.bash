#!/usr/bin/env bash

source ~/.config/bash/git_status.bash

COLOR_GREY=90
COLOR_GIT_CLEAN=92
COLOR_GIT_DIRTY=91
COLOR_TIME=37
COLOR_HOST=35
COLOR_CONDA=96
COLOR_PATH=95
COLOR_PROMPT_SYMBOL=$COLOR_GREY
COLOR_BG=49
PROMPT_SYMBOL=":"

if [ "$TERM" != "linux" ]; then
    export _POWERLINE_ARROW=""
    export _POWERLINE_BRANCH=" "
fi

_get_prompt_color() {
    local ERR="$?"
    # Default Blue
    local path_color=$COLOR_PATH
    # Command Retuned error? Then Red
    [ "$ERR" != "0" ] && path_color=31
    # Is Root? Then White
    [ "$(id -u)" == "0" ] && path_color=35
    echo "$path_color"
}

_path() {
    local path_fg=$(_get_prompt_color)
    local path_bg=$COLOR_BG
    local path_rep='\w'
    local ps1=""
    ((COLUMNS < 50)) && path_rep="$(basename "$PWD")"
    ps1="\[\033[${path_bg};${path_fg}m\]$path_rep"
    ((COLUMNS < 50)) && ps1="$ps1"$'\n'
    echo "$ps1"
}

_reload_history() {
    history -a
    history -n
}

_pre_newline() {
    PS1=$'\n'"$PS1"
}

_zsh_newline() {
    # Detect whether or not the command has a new line ending
    unset PROMPT_SP
    # Credit to Dennis Williamson on serverfault.com
    for ((i = 1; i<= $COLUMNS + 52; i++ )); do
        PROMPT_SP+=' ';
    done
    PS1='\[\e[7m%\e[m\]${PROMPT_SP: -$COLUMNS+1}\015'"$PS1"
}

_conda() {
    if [ -n "$CONDA_DEFAULT_ENV" ]; then
        local brace_fg=$COLOR_GREY
        local brace_fg=$COLOR_GREY
        local conda_fg=$COLOR_CONDA
        local bg=$COLOR_BG
        local conda=""
        str=""
        str="$str\[\033[${bg};${brace_fg}m\]"
        # str="$str("
        str="$str\[\033[${bg};${conda_fg}m\]"
        str="$str$CONDA_DEFAULT_ENV"
        str="$str\[\033[${bg};${brace_fg}m\]"
        # str="$str)"
        str="$str:"
        echo "$str"
    fi
}

_set_color() {
    local bg = $1
    local bg = $2
}

_git() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null; then
        # local Git_branch="$(basename "$(git symbolic-ref HEAD 2>/dev/null)")"
        local Git_branch="$(_git_branch_name)"
        local Git_status=""
        local Git_fg=0
        local brace_fg=$COLOR_GREY
        local bg=$COLOR_BG
        local delim="|"
        # Is clean working tree
        if [ -n "$(_git_dirty)" ]; then
            Git_fg=$COLOR_GIT_CLEAN
            Git_status=""
            delim=""
        else
            Git_fg=$COLOR_GIT_DIRTY
            Git_status="+"
            Git_status="$Git_status$(_git_unpushed)"
        fi
        # Make it all a string, relying on \w for directory
        local str=""
        str="$str\[\033[${bg};${brace_fg}m\]"
        str="$str["
        str="$str\[\033[${bg};${Git_fg}m\]"
        str="$str$Git_status"
        str="$str\[\033[${bg};${brace_fg}m\]"
        str="$str$delim"
        str="$str\[\033[${bg};${Git_fg}m\]"
        str="$str$Git_branch"
        str="$str\[\033[${bg};${brace_fg}m\]"
        str="$str]"
        echo "$str "
    fi
}

_host() {
    if [ -n "$SSH_CONNECTION" ] ||
        [ -n "$TMUX" ] ||
        [ -n "$SUDO_COMMAND" ]; then
        local fg=$COLOR_HOST
        local brace_fg=$COLOR_GREY
        local bg=$COLOR_BG
        local hostname="$(</etc/hostname)"
        local hostname="${hostname/.*}"
        local str=""
        str="$str\[\033[${bg};${fg}m\]"
        str="$str$hostname"
        str="$str\[\033[${bg};${brace_fg}m\]"
        str="$str:"
        echo "$str"
    fi
}

_time() {
    local time=$(date +"%T")
    local time_fg=$COLOR_TIME
    local brace_fg=$COLOR_GREY
    local bg=$COLOR_BG
    local str="\[\033[${bg};${brace_fg}m\]["
    local str="$str\[\033[${bg};${time_fg}m\]${time}\]"
    local str="$str\[\033[${bg};${brace_fg}m\]]"
    echo "$str"
}

_reset() {
    echo "\[\033[0m\]"
}

_symbol() {
    local fg=$COLOR_PROMPT_SYMBOL
    local bg=$COLOR_BG
    local str="\[\033[${bg};${fg}m\]${PROMPT_SYMBOL}"
    echo "$str "
}

_prompt() {
    # _base_prompt
    # _reload_history
    local topline="$(_git)"
    if [ -n "$topline" ]; then
        topline="$topline\n"
    fi
    PS1="$topline$(_time) $(_host)$(_conda)$(_path)$(_symbol)$(_reset)"
    _pre_newline
}

PROMPT_COMMAND=_prompt
