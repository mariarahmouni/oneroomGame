--draw functions

local timer = 0
local delay = 20
local is_resetting = false

local rect_timer = 0
local show_pc = false

local display_text = true

function draw_menu()
    cls()
    camera(0, 0)
    if gamecount == 0 then
        print("press ❎ to start", 30, 63)
    else
        if old_death_count <= 5 then
            print("YOU FINISHED WITH\n " .. old_death_count .. " DEATHS \n ... DID YOU CHEAT?", 30, 30, 7)
        elseif old_death_count > 5 and old_death_count < 10 then
            print("YOU FINISHED WITH \n" .. old_death_count .. " DEATHS... \nA FEW MISTAKES NEVER \nHURT ANYBODY ", 20, 30, 7)
        elseif old_death_count > 10 and old_death_count < 20 then
            print("YOU FINISHED WITH\n " .. old_death_count .. " DEATHS! \n(MY GRANDMOTHER DID BETTER)", 20, 30, 7)
        elseif old_death_count > 20 and old_death_count < 30 then
            print("YOU FINISHED WITH " .. old_death_count .. " DEATHS! \n..THAT'S A LOT..", 20, 30, 7)
        elseif old_death_count > 30 then
            print("YOU FINISHED WITH .......\n" .. old_death_count .. " DEATHS.....\n WERE YOU EVEN TRYING?", 20, 30, 7)
        end
        print("press x to restart", 30, 65, 12)
    end
end

function draw_reset_level()
    if not is_resetting then
        is_resetting = true
        reset_timer = 0
        show_pc = false
        display_text = true
        if level == 5 then
            countdown_timer = 30
        end
    end

    if match.held then
        match.held = false
    end

    if is_resetting then
        reset_timer += 1
        if reset_timer >= delay then
            if level == 3 then
                show_pc = true
            end
            player.sp = 1
            player.dead = false
            player.x = player.startx
            player.y = player.starty
            match.x = levels[level].match_info.startx
            match.y = levels[level].match_info.starty
            match.held = false
            scene = "game"
            is_resetting = false
        end
    end
end

function draw_next_level()
    level += 1
    player.sp = 1
    player.dead = false
    player.x = player.startx
    player.y = player.starty
    match.x = levels[level].match_info.startx
    match.y = levels[level].match_info.starty
    match.held = false
    match.active = true
    sticks.lit = false
    sticks.sp = 136
    count = 0
    display_text = true
    sfx(5)
    scene = "game"
end

function draw_game()
    cls()
    map(0, 0)

    rect_timer += 1
    if rect_timer % 120 == 0 then
        show_pc = not show_pc
        rect_timer = 0
    end

    if level == 3 then
        if show_pc then
            spr(player.sp, player.x, player.y, 1, 1, player.flip)

            if rect_timer >= 120 then
                show_pc = false
                rect_timer = 0
            end
        else
            rectfill(player.x, player.y - 6, player.x + 6, player.y, 0)
        end
    else
        spr(player.sp, player.x, player.y, 1, 1, player.flip)
    end

    if level == 5 then
        if not sticks.lit then
            if countdown_timer > 0 then
                countdown_timer -= 1 / 30
            end
            if countdown_timer <= 0 then
                scene = "timesup"
            end
        end
        if player.x > 136 then
            print("time: " .. flr(countdown_timer), 166, 2, 8)
        else
            print("time: " .. flr(countdown_timer), 97, 2, 8)
        end
    end

    if level == 1 then
        if player.x < 112 then
            print("its cold..", 30, 15, 12)
        else
            print("a match! \nwonder if there are \nsome sticks around.. ", 112, 15, 12)
        end
        if player.x > 264 and player.y < 24 then
            print("press ❎ to \nstart a fire", 264, 33, 12)
        end
    elseif level == 2 then
        if player.y > 45 and display_text then
            print("it's snow joke..", 30, 15, 12)
            print("mind your balance", 26, 40, 12)
        else
            display_text = false
        end
    elseif level == 3 then
        if player.y > 45 and display_text then
            print("it gets a bit dark", 30, 15, 12)
            print("watch your step", 26, 40, 12)
        else
            display_text = false
        end
    elseif level == 4 then
        if player.y > 45 and display_text then
            print("as the saying goes..what", 20, 9, 12)
            print("goes down must come up", 21, 15, 12)
            print("wait..\n did i get \nthat left?", 26, 30, 12)
        else
            display_text = false
        end
    else
        if player.y > 45 and display_text then
            print("its icy again.. and backwords.. \nand timed..", 12, 15, 12)
        else
            display_text = false
        end
    end

    print("deaths: " .. cur_death_count, 10, 2, 135)

    if match.active then
        objdraw(match)
    end

    if sticks.lit then
        spr(135, sticks.x, sticks.y, 1, 1)
    else
        spr(136, sticks.x, sticks.y, 1, 1)
    end

    print("   ⬆️", cam_x, 113, 5)
    print(" ⬅️  ➡️", cam_x, 118, 5)
    print("level: "..level,cam_x+90, 113,5)
end

function draw_times_up()
    local x = (128 - 32) / 2 + cam_x
    local y = (128 - 8) / 2
    rectfill(x, y, x + 32, y + 8, 6)

    print("too slow", x, y + 2, 0)

    countdown_timer = 30
    cur_death_count += 1
    scene = "reset"
end

function objdraw(o)
    spr(o.sp, o.x, o.y, 1, 1)
end