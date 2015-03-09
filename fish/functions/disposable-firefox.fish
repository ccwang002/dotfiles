function disposable-firefox --description "Execute a clean firefox without settings."
    switch (uname)
        case Darwin
            # thanks concise for the idea
            /Applications/Firefox.app/Contents/MacOS/firefox -no-remote -profile /tmp/.disposable-firefox $argv >/dev/null 2>&1 &
        case '*'
            echo 'Unknown os to open firefox' >/dev/stderr
    end
end
