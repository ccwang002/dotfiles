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
status --is-interactive; and . (pyenv init -|psub)

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

