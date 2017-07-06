# .bash_profile

# All developments are under workspace
readonly WORKSPACE=/diskmnt/Projects/Users/lwang
# Where the fish shell should be
readonly FISH_BIN=$WORKSPACE/.linuxbrew/bin/fish

setup_shell_env() {
    # User specific environment and startup programs
    # Default to a larger temporary directory
    export TMPDIR="/run/user/$(id --user)"

    # Linuxbrew settings
    PATH=$WORKSPACE/local/bin:$WORKSPACE/.linuxbrew/bin:$WORKSPACE/.linuxbrew/sbin:$PATH
    MANPATH=$WORKSPACE/.linuxbrew/share/man:$MANPATH
    INFOPATH=$WORKSPACE/.linuxbrew/share/info:$INFOPATH
    HOMEBREW_CACHE=$WORKSPACE/.cache/Homebrew
    HOMEBREW_MAKE_JOBS=6

    export PATH MANPATH INFOPATH HOMEBREW_CACHE HOMEBREW_MAKE_JOBS
}

replace_bash_with_fish() {
    # we first check whether fish can be executed, otherwise the
    # replacement will cause immediate crash at login (not fun)
    if "$FISH_BIN" -l -c 'echo "Test fish running" >/dev/null' ; then
        export SHELL=$FISH_BIN
        echo "One can launch the fish shell by:"
        echo 'exec -l $SHELL -l'
        exec -l $SHELL -l   # launch the fish login shell
    else
        echo "Failed to launch fish shell. Go check its installation!"
        echo "Fall back to default shell $SHELL ..."
    fi
}

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -z "$TMUX" ]; then
    setup_shell_env

    # The replacement is only done in non-fish login interactive shell in
    # SSH connection and fish executable exists.
    if [                                                            \
         "$SHELL" != "$FISH_BIN" -a -n "$SSH_TTY" -a -x "$FISH_BIN" \
    ] ; then
        replace_bash_with_fish
    fi
fi
