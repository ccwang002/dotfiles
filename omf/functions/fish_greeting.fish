function fish_greeting
    if test -f '/.dockerenv'
        # If inside Docker, print Docker-based information
        set_color $fish_color_autosuggestion
        echo "Running Docker on host: "(hostname)
        echo "Docker OS: "(grep '^PRETTY_NAME' /etc/os-release | awk -F'\"' '{print $2}')
        set_color normal
    else
        set_color $fish_color_autosuggestion
        uname -nmsr
        uptime
        set_color normal
    end
end
