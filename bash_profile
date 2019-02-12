# .bash_profile

# All developments are under workspace
readonly WORKSPACE=/diskmnt/Projects/Users/lwang
# Root of the Linuxbrew
readonly HOMEBREW_PREFIX=$WORKSPACE/.linuxbrew
# Where the fish shell should be
readonly FISH_BIN=$HOMEBREW_PREFIX/bin/fish

setup_shell_env() {
    # User specific environment and startup programs
    # Default to a larger temporary directory
    export TMPDIR="/run/user/$(id --user)"

    # Linuxbrew settings
    HOMEBREW_CELLAR=$HOMEBREW_PREFIX/Cellar
    HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX

    PATH=$WORKSPACE/local/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
    MANPATH=$WORKSPACE/local/share/man:$HOMEBREW_PREFIX/share/man:$MANPATH
    INFOPATH=$HOMEBREW_PREFIX/share/info:$INFOPATH
    HOMEBREW_CACHE=$WORKSPACE/.cache/Homebrew
    HOMEBREW_LOGS=$HOMEBREW_CACHE/Logs
    HOMEBREW_TEMP=$TMPDIR
    HOMEBREW_MAKE_JOBS=6

    export HOMEBREW_PREFIX HOMEBREW_CELLAR HOMEBREW_REPOSITORY \
           HOMEBREW_CACHE HOMEBREW_LOGS HOMEBREW_TEMP HOMEBREW_MAKE_JOBS
    export PATH MANPATH INFOPATH

    # Set default permission
    umask 002
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
