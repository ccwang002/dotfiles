function gitlog --description "show git log tree with preferreed settings"
    git log --graph --all --decorate --oneline $argv
end
