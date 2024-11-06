--player functions

function player_update()
    --phsyics
    if level~=1 then
        player.dy += levels[2].gravity
        player.dx *= levels[2].friction
    else
        player.dy += player.gravity
        player.dx *= player.friction
    end


    if not player.dead then
        --reverse controls for level 4
        if level == 4 or level==5 then
            if btn(➡️) then
                player.dx -= player.acc
                player.running = true
                player.flip = true
            end
            if btn(⬅️) then
                player.dx += player.acc
                player.running = true
                player.flip = false
            end

            --slide
            if player.running
                    and not btn(⬅️)
                    and not btn(➡️)
                    and not player.falling
                    and not player.jumping then
                player.running = false
                player.sliding = true
            end

            --jump
            if btn(⬇️) then
                if player.landed then
                    player.dy -= player.boost
                    player.landed = false
                    player.jumping = true
                    player.jump_time = time()
                    sfx(3)
                elseif player.jumping then
                    -- if player jumping and button still pressed do big jump
                    if time() - player.jump_time < 0.15 then
                        player.dy -= player.boost * 0.22
                    else
                        player.jumping = false
                    end
                else
                    player.jupming = false
                end
            end

            --normal controls
        else
            if btn(⬅️) then
                player.dx -= player.acc
                player.running = true
                player.flip = true
            end
            if btn(➡️) then
                player.dx += player.acc
                player.running = true
                player.flip = false
            end

            --slide
            if player.running
                    and not btn(⬅️)
                    and not btn(➡️)
                    and not player.falling
                    and not player.jumping then
                player.running = false
                player.sliding = true
            end

            --jump
            if btn(⬆️) then
                if player.landed then
                    player.dy -= player.boost
                    player.landed = false
                    player.jumping = true
                    player.jump_time = time()
                    sfx(3)
                elseif player.jumping then
                    -- if player jumping and button still pressed do big jump
                    if time() - player.jump_time < 0.15 then
                        player.dy -= player.boost * 0.22
                    else
                        player.jumping = false
                    end
                else
                    player.jupming = false
                end
            end
        end
    end

    --check collisions up and down
    if player.dy > 0 then
        player.falling = true
        player.landed = false
        player.jumping = false

        player.dy = limit_speed(player.dy, player.max_dy)

        if collide_map(player, "down", 0) then
            player.landed = true
            player.falling = false
            player.dy = 0
            player.y -= (player.y + player.h + 1) % 8 - 1
        end 
    elseif player.dy < 0 then
        player.jumping = true

        if collide_map(player, "up", 1) then
            player.dy = 0
        end
    end

    --check collisions left and right
    if player.dx < 0 then
        player.dx = limit_speed(player.dx, player.max_dx)
        if collide_map(player, "left", 1) then
            player.dx = 0
        end
    elseif player.dx > 0 then
        player.dx = limit_speed(player.dx, player.max_dx)
        if collide_map(player, "right", 1) then
            player.dx = 0
        end
    end

    --spike collision
    if collide_map(player, "up", 2) or collide_map(player, "down", 2)
            or collide_map(player, "right", 2) or collide_map(player, "left", 2) then
        player.dead = true
        cur_death_count += 1
        scene = "reset"
    end

    --match collect
    if collide_map(player, "up", 3) or collide_map(player, "down", 3)
            or collide_map(player, "right", 3) or collide_map(player, "left", 3) then
        levels[level].objs.match.held = true
    end

    --stop sliding
    if player.sliding then
        if abs(player.dx) < .2
                or player.running then
            player.dx = 0
            player.sliding = false
        end
    end
    player.x += player.dx
    player.y += player.dy

    --limit player to map
    if player.x < map_start then
        player.x = map_start
    end
    if player.x > map_end - player.w then
        player.x = map_end - player.w
    end
end

function player_animate()
    if player.dead then
        player.sp = 9
        sfx(1)
    elseif player.jumping then
        player.sp = 6
    elseif player.falling then
        player.sp = 7
    elseif player.sliding then
        player.sp = 8
    elseif player.running then
        if time() - player.anim > .1 then
            player.anim = time()
            player.sp += 1
            if player.sp > 6 then
                player.sp = 3
            end
        end
    else
        --player idle
        if time() - player.anim > .3 then
            player.anim = time()
            player.sp += 1
            if player.sp > 2 then
                player.sp = 1
            end
        end
    end

end


function limit_speed(num, max)
    return mid(-max, num, max)
end