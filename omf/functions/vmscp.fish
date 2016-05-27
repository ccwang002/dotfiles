function vmscp --description 'use scp without key nor host check'
    scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv
end
