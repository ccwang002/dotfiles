if status --is-login; and not set -q TMUX
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

            # Google Cloud SDK
            if test -d "$HOME/google-cloud-sdk"
                source "$HOME/google-cloud-sdk/path.fish.inc"
                # So far no completion for fish shell, use bass
                # bass source "$HOME/google-cloud-sdk/completion.bash.inc"
            end

            # conda http://conda.pydata.org/miniconda.html
            # soft link ~/miniconda3/etc/fish/conf.d/conda.fish
            # to ~/.config/fish/functions/
            # if set -q CONDA_ROOT; and test -d $CONDA_ROOT
            #     set -x PATH $CONDA_ROOT/bin $PATH
            # end

        case 'Linux*'
            # Check if it's in MGI Docker
            if string match '*.gsc.wustl.edu' (hostname)
                source $HOME/docker_clean_env.fish
            end

            # Settings on Linux (mostly servers)
            # Rust environment by rustup.rs
            if set -q CARGO_HOME; and set -q RUSTUP_HOME
                set -x PATH $CARGO_HOME/bin $PATH
                set -x CARGO_HOME $CARGO_HOME
                set -x RUSTUP_HOME $RUSTUP_HOME
            end

            # Conda
            # if set -q CONDA_ROOT; and test -d $CONDA_ROOT
            #     set -x PATH $CONDA_ROOT/bin $PATH
            #     source $CONDA_ROOT/etc/fish/conf.d/conda.fish
            # end
        case '*'
            echo "Unrecognized OS: (uname -a)!"
    end

    # Python environment
    # Disable Python venv prompt changing
    # set -gx VIRTUAL_ENV_DISABLE_PROMPT "yes"

    set -gx EDITOR (which vim)
    set -gx PAGER (which less)
end
