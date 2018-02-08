function vmssh --wraps 'ssh' --description 'use ssh without key nor host check'
    ssh -o UserKnownHostsFile=/tmp/vm_known_hosts $argv
end
