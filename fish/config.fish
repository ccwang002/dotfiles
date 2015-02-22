# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish

# Set custom fish functions which is not part of plugins
set fish_function_path $HOME/dotfiles/fish/functions $fish_function_path

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to #FISH/custom/plugins
# Example format: set fish_plugins autojump bundler
set fish_plugins conda

# Theme
set fish_theme bobthefish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# LOCALE
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Update PATH for homebrew
set -x PATH $HOME/.cabal/bin /usr/local/bin $PATH

# 256 color term
set -x TERM "xterm-256color"

#For pyenv (init at the end of config)
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH

# For pip
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheel"
set -x PIP_FIND_LINKS "file://$PIP_WHEEL_DIR"

# virtual fish
. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish

# Init pyenv
if begin; status --is-interactive; and type -f pyenv > /dev/null; end
    . (pyenv init -|psub)
end
