# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish

# Set custom fish functions which is not part of plugins
set fish_function_path $HOME/dotfiles/fish/functions $fish_function_path

# Theme settings
set -g theme_display_virtualenv yes
set -g theme_display_hg yes
set -g theme_display_user yes
set -g default_user liang

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to #FISH/custom/plugins
# Actually load the themes and plugings
Theme 'bobthefish'
Plugin 'conda'

# LOCALE
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Update PATH for homebrew
set -x PATH $HOME/.cabal/bin /usr/local/bin $PATH

# 256 color term
# See Arch wiki: https://wiki.archlinux.org/index.php/Home_and_End_keys_not_working
# Usually is a bad idea to set $TERM in config instead let terminal to decide
# set -x TERM "xterm-256color"

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
