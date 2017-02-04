function __bobthefish_git_branch -S -d 'Get the current git branch (or commitish)'
  set -l ref (command git symbolic-ref HEAD ^/dev/null)
    and echo $ref | sed -e "s#refs/heads/#$__bobthefish_branch_glyph #" -e "s# master# #"
    and return

  set -l tag (command git describe --tags --exact-match ^/dev/null)
    and echo "$__bobthefish_tag_glyph $tag"
    and return

  set -l branch (command git show-ref --head -s --abbrev | head -n1 ^/dev/null)
  echo "$__bobthefish_detached_glyph $branch"
end
