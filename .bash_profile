# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for Homebrew
export PATH=/usr/local/bin:$PATH


# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

PS1="\[\e[01;33m\]\u@Air\[\e[00m\]:\[\e[01;32m\]\W\[\e[00m\]\$(__git_ps1) \$ "

export PYTHONPATH=~/code/code_in_lab/ngs-scripts:$PYTHONPATH

# Google App Engine
export PATH=/usr/local/google_appegine:$PATH
