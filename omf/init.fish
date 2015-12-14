# LOCALE
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Update PATH for homebrew
set -x PATH $HOME/.cabal/bin /usr/local/sbin /usr/local/bin $PATH

# 256 color term
# See Arch wiki: https://wiki.archlinux.org/index.php/Home_and_End_keys_not_working
# Usually is a bad idea to set $TERM in config instead let terminal to decide
# set -x TERM "xterm-256color"

# For pyenv (init at the end of config)
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH

# For virtualfish
# newer virtualfish after `pip install virtualfish`
#   eval (python -m virtualfish)

# For pip
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheel"
set -x PIP_FIND_LINKS "file://$PIP_WHEEL_DIR"

# Init pyenv
if begin; status --is-interactive; and type -f pyenv > /dev/null; end
    . (pyenv init -|psub)
end
