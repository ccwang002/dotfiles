#!/usr/bin/env python3
"""\
Dotfiles setup script. Inspired by concise.

Update the symlink_setting string as the following format:

Destination         Source under $PWD
-----------         -----------------
~/.gitconfig        gitconfig


Unexisted folder will be created (but may fail).
"""
import argparse
from fnmatch import fnmatch
from pathlib import Path

symlink_settings = '''\
~/.config/mpv/                  mpv/
~/.config/omf/                  omf/
~/.config/git/gitk              gitk_config
~/.config/lsd/config.yaml       lsd_config.yaml
~/.editrc                       editrc
~/.editorconfig                 editorconfig
~/.gitconfig                    gitconfig
~/.gitignore_global             gitignore_global
~/.inputrc                      inputrc
~/.jupyter/custom/custom.css    jupyter_themes/jt_oceans16.css
~/.Rprofile                     Rprofile
~/.ssh/config                   ssh_config
~/.tmux.conf                    tmux.conf
'''


def main(patterns_to_link, dry_run):
    for setting_line in symlink_settings.splitlines():
        dest_pth, src_pth = setting_line.rstrip().split(maxsplit=1)
        # Check if user wants to link this pattern
        if patterns_to_link and \
                not any(fnmatch(dest_pth, pttn) for pttn in patterns_to_link):
            print('Skip linking', dest_pth)
            continue
        try:
            # For Python 3.5+
            dest = Path(dest_pth).expanduser()
        except AttributeError:
            import os.path as op
            dest = Path(op.expanduser(dest_pth))
        src = Path(src_pth).resolve()
        if dry_run:
            print('Will link', dest_pth, 'to', src_pth)
            continue
        print('Link', dest, '->', src)
        if dest.exists():
            print('... symlink existed ->', dest.resolve(), '(removed)')
            dest.unlink()
        if not dest.parent.exists():
            dest.parent.mkdir(mode=0o755, parents=True)
        dest.symlink_to(src)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Link dotfiles under user's home "
                    "(controlled patterns to link by --only)")
    parser.add_argument(
        '--only', action='append',
        help='Only link the files that match the shell-like pattern')
    parser.add_argument(
        '--dry-run', action='store_true',
        help='List the links to be done but no symlink will be made'
    )
    args = parser.parse_args()
    main(patterns_to_link=args.only, dry_run=args.dry_run)
