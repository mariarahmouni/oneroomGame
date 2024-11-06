--animating objects besides PC

function match_update()
    -- check collision with PC
    if collision_obj(match, player) then
        match.held = true
        mset(flr(match.x / 8), flr(match.y / 8), 0)
        match.anim = time()
    end

-- make match follow PC
    if match.held then
        match.x = player.x - 8
        match.y = player.y - 7

        if time() - match.anim > 0.3
                and player.running then
            match.anim = time()
            match.sp += 1
            if match.sp > 133 then
                match.sp = 132
            end
        end

    elseif not match.held and time() - match.anim > 0.5 then
        match.anim = time()
        match.sp += 1
        if match.sp > 131 then
            match.sp = 130
        end
    end
end

--light the fire to end the level
function stick_update()
    if btn(❎) and collision_obj(sticks, player)
            and match.held then
        sticks.lit = true
        sticks.sp = 135
        match.held = false
        match.active = false
        if player.x > sticks.x then
            player.x = sticks.x + 5
        else
            player.x = sticks.x - 5
        end
    end

--move on to the next level
    if sticks.lit then
        count += 1
        sfx(4,-1,1,3)
        if count == 60 and level ~=5 then
            scene = "nextlevel"
        elseif count==60 and level==5 then 
            scene="end_menu"
        end
    end
end