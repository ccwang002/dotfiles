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
            end

        case 'Linux*'
            # Check if it's in MGI Docker
            if string match '*.gsc.wustl.edu' (hostname)
                set -x SHELL /usr/bin/fish
                # Fix less coloring
                set -x LESS "-iRM"
            end

            # Settings on Linux (mostly servers)
            # Rust environment by rustup.rs
            if set -q CARGO_HOME; and set -q RUSTUP_HOME
                set -x PATH $CARGO_HOME/bin $PATH
                set -x CARGO_HOME $CARGO_HOME
                set -x RUSTUP_HOME $RUSTUP_HOME
            end

        case '*'
            echo "Unrecognized OS: "(uname -a)"!"
    end

    set -gx EDITOR (which vim)
    set -gx PAGER (which less)
end
