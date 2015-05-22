function vmmosh --description 'mosh without no key nor host check, pass certfile as 1st argument'
    mosh --ssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv[2..-1]" $argv[1]
end
