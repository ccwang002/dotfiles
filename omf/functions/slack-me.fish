function slack-me --description "Slack myself a job's ended"
    # Capture the previous job status
    set -l prev_status $status

    if not set -q SLACK_BOT_TOKEN; or not set -q SLACK_BOT_CHANNEL
        echo -s "Error: Slack bot integration is not set up. " \
            "Configure the shell variables below:"\n \
            "  set -U SLACK_BOT_TOKEN 'xoxb-....'"\n \
            "  set -U SLACK_BOT_CHANNEL 'channel_id'" \
            1>&2
        return 1
    end

    /usr/bin/curl \
        -F token="$SLACK_BOT_TOKEN" \
        -F channel="$SLACK_BOT_CHANNEL" \
        -F text="A job on "(hostname)" has ended (exit $prev_status): $argv" \
        https://slack.com/api/chat.postMessage
end
