function fish_right_prompt
    set_color $fish_color_autosuggestion[1]
        if test \( -n "$TMUX" \) -o \( -n "$STY" \)
            # in tmux or screen
            date "+%a %H:%M"
        else
            date "+%F %a %H:%M"
        end
    set_color normal
end
