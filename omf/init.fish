# LOCALE
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Update PATH for homebrew
test -d "$HOME/.cabal/bin"; and set -x PATH $HOME/.cabal/bin $PATH
set -x PATH /usr/local/sbin /usr/local/bin $PATH

# 256 color term
# See Arch wiki: https://wiki.archlinux.org/index.php/Home_and_End_keys_not_working
# Usually is a bad idea to set $TERM in config instead let terminal to decide
# set -x TERM "xterm-256color"

# For rustup.rs
# Ref: https://www.rustup.rs/
test -d "$HOME/.cargo/bin"; and set -x PATH $HOME/.cargo/bin $PATH

# For pyenv (init at the end of config)
set -x PYENV_ROOT $HOME/.pyenv
# set -x PATH $PYENV_ROOT/bin $PATH

# For virtualfish
# newer virtualfish after `pip install virtualfish`
#   eval (python -m virtualfish)

# For pip
set -x PIP_USE_WHEEL "true"

# Init pyenv
if begin; status --is-interactive; and which pyenv > /dev/null; end
    source (pyenv init - | psub)
    if which  pyenv-virtualenv-init > /dev/null
        source (pyenv virtualenv-init - | psub)
    end
end


set -x EDITOR (which vim)
set -x PAGER (which less)
