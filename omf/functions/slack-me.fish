function slack-me --wraps 'slack-cli' --description "Slack myself a job's ended"
    # Capture the previous job status
    set -l prev_status $status
    slack-cli --team mgidinglab -d bobo "A job on "(hostname)" has ended (exit status $prev_status): $argv"
end
