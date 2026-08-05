function fish_prompt
    echo (set_color brblack) ''(prompt_pwd --dir-length=3) (set_color white)
    echo ' > '
end

function fish_right_prompt
    echo (set_color brblack)
    date "+%H:%M"
end
