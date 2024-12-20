alias python=python3
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
alias ls="ls --color=auto -F"
alias l="ls --color=auto -F"
alias ll="ls -Al"
alias la="ls -A"
alias lla="ls -lA"
alias lal="ls -Al"
alias c="clear"
alias dk="docker kill"
alias dps="docker ps"
alias dka="echo Killing containers:&& docker ps -q | xargs docker kill"
alias dca="docker image prune -f && docker container prune -f && docker system prune -f"
alias dwa="watch docker ps"
alias gst="git status"
alias ga="git add ."
alias gac="git add . && git commit"
alias gc="git commit"
alias gd="git diff"
alias gcm="git checkout master"
alias gco="git checkout"
alias gcoo="git checkout -- ."
alias gpl="git pull"
alias gps="git push"
alias gp="git pull"
alias gf="git fetch"
export PATH=$HOME/bin:$PATH

# Up/down uses current prefix to search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Get vscode extensions into vcs
local CODE_EXTENSION_FILE=$HOME/Library/Application\ Support/Code/User/extensions.json
persist-code-extensions() {
  code --list-extensions --show-versions > $CODE_EXTENSION_FILE
}
load-code-extensions() {
    echo "Todo..."
}

# Autoload zsh's `add-zsh-hook` and `vcs_info` functions
# (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info

# Set prompt substitution so we can use the vcs_info_message variable
setopt prompt_subst

# Run the `vcs_info` hook to grab git info before displaying the prompt
add-zsh-hook precmd vcs_info

# Style the vcs_info message
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%b%u%c'
# Format when the repo is in an action (merge, rebase, etc)
zstyle ':vcs_info:git*' actionformats '%F{14}⏱ %*%f'
zstyle ':vcs_info:git*' unstagedstr '*'
zstyle ':vcs_info:git*' stagedstr '+'
# This enables %u and %c (unstaged/staged changes) to work,
# but can be slow on large repos
zstyle ':vcs_info:*:*' check-for-changes true

# Set the right prompt to the vcs_info message
export RPROMPT='${vcs_info_msg_0_}'
export PROMPT='%f %2~ > '