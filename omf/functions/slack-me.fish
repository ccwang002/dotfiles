function slack-me --wraps 'slack-cli' --description "Slack myself a job's ended"
    slack-cli --team mgidinglab -d bobo "A job on "(hostname)" has ended (exit status $status)" $argv
end
