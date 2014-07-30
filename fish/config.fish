# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# LOCALE
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Update PATH for homebrew
set -x PATH $HOME/.cabal/bin /usr/local/bin $PATH


# 256 color term
set -x TERM "xterm-256color"


 #For pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH
if begin; status --is-interactive; and type -f pyenv > /dev/null; end
    . (pyenv init -|psub)
end

# For pip
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheel"
set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
set -x PIP_FIND_LINKS "file://$PIP_WHEEL_DIR"


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
        if test \( -n "$TMUX" \) -o \( -n "$STY" \)
            # in tmux or screen
            date "+%a %H:%M"
        else
            date "+%F %a %H:%M"
        end
    set_color normal
end
