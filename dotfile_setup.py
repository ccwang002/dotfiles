#!/usr/bin/env python3
"""\
Dotfiles setup script. Inspired by concise.

Update the symlink_setting string as the following format:

Destination         Source under $PWD
-----------         -----------------
~/.gitconfig        gitconfig


Unexisted folder will be created (but may fail).
"""
from pathlib import Path

symlink_settings = '''\
~/.config/mpv/input.conf        mpv/input.conf
~/.config/mpv/mpv.conf          mpv/mpv.conf
~/.config/mpv/scripts/autoload.lua  mpv/scripts/autoload.lua
~/.config/mpv/scripts/stats.lua     mpv/scripts/stats.lua
~/.config/omf                   omf
~/.ctags                        ctags
~/.editrc                       editrc
~/.editorconfig                 editorconfig
~/.gitconfig                    gitconfig
~/.gitignore_global             gitignore_global
~/.hgrc                         hgrc
~/.hgignore_global              hgignore_global
~/.inputrc                      inputrc
~/.jupyter/custom/custom.css    ipy_profile/ipython3/custom_light.css
~/.Rprofile                     Rprofile
~/.screenrc                     screenrc
~/.ssh/config                   ssh_config
~/.tmux.conf                    tmux.conf
'''


def main():
    for setting_line in symlink_settings.splitlines():
        dest_pth, src_pth = setting_line.rstrip().split(maxsplit=1)
        try:
            # For Python 3.5+
            dest = Path(dest_pth).expanduser()
        except AttributeError:
            import os.path as op
            dest = Path(op.expanduser(dest_pth))
        src = Path(src_pth).resolve()
        print('Linking', dest, '->', src)
        if dest.exists():
            print('... symlink existed ->', dest.resolve(), '(removed)')
            dest.unlink()
        if not dest.parent.exists():
            dest.parent.mkdir(mode=0o755, parents=True)
        dest.symlink_to(src)

if __name__ == '__main__':
    main()
