function vmrsync --wraps 'rsync' --description 'Rsync via ssh to a throwaway machine'
    rsync -e 'ssh -o UserKnownHostsFile=/tmp/vm_known_hosts' $argv
end
