--level configurations

levels = {
    [1] = {
        --normal level 
        match_info = {
            sp = 130,
            x = 168,
            startx = 168,
            y = 72,
            starty = 72,
            w = 2,
            h = 6,
            dx = 0,
            dy = 0,
            moving = false,
            held = false,
            anim = 0,
            active = true
        }
    },
    [2] = {
        -- slippery platforms
        gravity = 0.30,
        friction = .93, 
        match_info = {
            sp = 130,
            x = 114,
            startx = 114,
            starty = 64,
            y = 64,
            dx = 0,
            dy = 0,
            w = 2,
            h = 6,
            moving = false,
            held = false,
            anim = 0,
            active = true

        }
    },
    [3] = {
        --player blackout
        gravity=.3,
        friction=.8,
        match_info = {
            sp = 130,
            x = 216, 
            startx=216,
            starty=80,
            y = 80,
            w = 2,
            h = 6,
            moving = false,
            held = false,
            anim = 0,
            active = true
        },

    },
    [4] = {
        -- reverse controls
        gravity=.3,
        friction=.8,
        match_info = {
            sp = 130,
            x = 296, 
            startx=296,
            starty=88,
            y = 88,
            w = 2,
            h = 6,
            moving = false,
            held = false,
            anim = 0,
            active = true
        }
    },
    [5] = { 
        --timed level (30 seconds)
        --reverse directions and lightly less slippery
        gravity = 0.30,
        friction = .85, 
        match_info = {
            sp = 130,
            x = 144, 
            y = 88,
            startx=144,
            starty=88,
            w = 2,
            h = 6,
            moving = false,
            held = false,
            anim = 0,
            active = true
        }
    }
}
