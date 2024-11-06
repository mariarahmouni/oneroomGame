--draws

function update_menu()
    if btn(❎) then
        sfx(7,-2)
       scene = "game"
    end
end

function update_end_menu()
    sfx(7)
    gamecount+=1
    old_death_count=cur_death_count
    cur_death_count=0
    _init()
end

function update_game()
    stick_update()
    match_update()
    player_update()
    player_animate()

    --simple camera
    cam_x = player.x - 64 + player.w / 2
    if cam_x < map_start then
        cam_x = map_start
    end

    if cam_x > map_end - 128 then
        cam_x = map_end - 128
    end
    

    camera(cam_x, 0)
end