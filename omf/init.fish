if status --is-login; and not set -q TMUX
    # LOCALE
    set -gx LANG en_US.UTF-8
    set -gx LC_CTYPE en_US.UTF-8

    switch (uname)
        case 'Darwin*'
        case 'Linux*'
            # Check if it's in MGI Docker
            if string match '*.gsc.wustl.edu' (hostname)
                set -x SHELL /usr/bin/fish
                # Fix less coloring
                set -x LESS "-iRM"
            end

            # Check if it's in RIS Docker
            # .ris.wustl.edu
            if string match 'compute1-*.ris.wustl.edu' (hostname)
                set -x SHELL /usr/bin/fish
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
