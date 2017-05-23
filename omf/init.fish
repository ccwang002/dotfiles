if status --is-login
    # LOCALE
    set -gx LANG en_US.UTF-8
    set -gx LC_CTYPE en_US.UTF-8

    switch (uname)
        case 'Darwin*'
            # Settings on MacOS
            # Update PATH for homebrew
            set -x PATH /usr/local/sbin /usr/local/bin $PATH

            test -d "$HOME/.cabal/bin"; and set -x PATH $HOME/.cabal/bin $PATH

            # For rustup.rs
            # Ref: https://www.rustup.rs/
            test -d "$HOME/.cargo/bin"; and set -x PATH $HOME/.cargo/bin $PATH

            # conda http://conda.pydata.org/miniconda.html
            if [ -d $CONDA_ROOT ]
                set -x PATH $HOME/miniconda3/bin $PATH
                source $CONDA_ROOT/etc/fish/conf.d/conda.fish
            end

        case 'Linux*'
            # Settings on Linux (mostly servers)
            # Rust environment by rustup.rs
            if [ -n $CARGO_HOME -a -n $RUSTUP_HOME ]
                set -x PATH $CARGO_HOME/bin $PATH
                set -x CARGO_HOME $CARGO_HOME
                set -x RUSTUP_HOME $RUSTUP_HOME
            end

            # Conda
            if [ -d $CONDA_ROOT ]
                set -x PATH $CONDA_ROOT/bin $PATH
                source $CONDA_ROOT/etc/fish/conf.d/conda.fish
            end
        case '*'
            echo "Unrecognized OS: (uname -a)!"
    end

    # Python environment
    # Disable Python venv prompt changing
    set -gx VIRTUAL_ENV_DISABLE_PROMPT "yes"

    set -gx EDITOR (which vim)
    set -gx PAGER (which less)
end
