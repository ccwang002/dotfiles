function vmscp --wraps 'scp' --description 'use scp without key nor host check'
    scp -o UserKnownHostsFile=/tmp/vm_known_hosts -o StrictHostKeyChecking=no $argv
end
