if status --is-login
    # LOCALE
    set -gx LANG en_US.UTF-8
    set -gx LC_CTYPE en_US.UTF-8

    # Update PATH for homebrew
    test -d "$HOME/.cabal/bin"; and set -x PATH $HOME/.cabal/bin $PATH
    set -x PATH /usr/local/sbin /usr/local/bin $PATH

    # For rustup.rs
    # Ref: https://www.rustup.rs/
    test -d "$HOME/.cargo/bin"; and set -x PATH $HOME/.cargo/bin $PATH

    # Python environment
    # Disable Python venv prompt changing
    set -gx VIRTUAL_ENV_DISABLE_PROMPT "yes"

    # conda http://conda.pydata.org/miniconda.html
    set -l CONDA_ROOT $HOME/miniconda3
    if [ -d $CONDA_ROOT ]
        set -x PATH $HOME/miniconda3/bin $PATH
        source $CONDA_ROOT/etc/fish/conf.d/conda.fish
    end

    set -gx EDITOR (which vim)
    set -gx PAGER (which less)
end
