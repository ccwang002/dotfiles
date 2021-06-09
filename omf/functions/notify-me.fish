function notify-me --description "Notify myself a job's ended on macOS"
    # Capture the previous job status
    set -l prev_status $status

    set -l msg "A job has ended (exit $prev_status): $argv"
    /usr/bin/osascript \
        -e 'display notification "'$msg'" with title "Terminal"'
end
