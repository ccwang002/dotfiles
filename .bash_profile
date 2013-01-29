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

# For Node.js nvm version control
. ~/.nvm/nvm.sh

# homebrew path
export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/share/python3:/usr/local/share/pypy:$PATH

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

PS1="\[\e[01;33m\]\u@Air\[\e[00m\]:\[\e[01;32m\]\W\[\e[00m\]\$(__git_ps1) \$ "

# perlbrew 
. ~/perl5/perlbrew/etc/bashrc

