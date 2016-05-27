function vmssh --description 'use ssh without key nor host check'
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv
end
