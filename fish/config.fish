# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# LOCALE
set -x LANG zh_TW.UTF-8
set -x LC_CTYPE zh_TW.UTF-8

# Update PATH for homebrew
set -x PATH $HOME/.cabal/bin /usr/local/bin $PATH


# For pyenv
set -x PYENV_ROOT /usr/local/opt/pyenv
set -x PATH $PYENV_ROOT"/bin" $PATH
if begin; status --is-interactive; and type -f pyenv > /dev/null; end
    . (pyenv init -|psub)
end

# For pip
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheels"
set -x PIP_FIND_LINKS "$HOME/.pip/wheels"
set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"


# For rbenv
set -x RBENV_ROOT /usr/local/opt/rbenv
# set -x PATH $RBENV_ROOT"/bin" $PATH
if begin; status --is-interactive; and type -f rbenv > /dev/null; end
    . (rbenv init -|psub)
end


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# virtual fish
. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish

# Add aliases
set -x fish_function_path $HOME/dotfiles/fish/functions $fish_function_path

# Custom Right Prompt
function fish_right_prompt
    set_color $fish_color_autosuggestion[1]
    date "+%F (%a) %H:%M %Z"
    set_color normal
end

