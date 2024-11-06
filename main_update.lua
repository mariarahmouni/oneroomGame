--update functions

function _update()
    if scene=="menu" then
        update_menu()
    elseif scene=="game" then
        update_game()
    elseif scene=="end_menu" then 
        update_end_menu()
    end
end

function _draw()
    if scene=="menu" then
        draw_menu()
    elseif scene=="reset" then 
        draw_reset_level()
    elseif scene=="nextlevel" then
        draw_next_level()
    elseif scene=="game" then
        draw_game()
    elseif scene=="timesup" then
        draw_times_up()
    end
    
end



