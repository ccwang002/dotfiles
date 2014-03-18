function vmssh --description 'use ssh but no key nor host check'
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv
end
