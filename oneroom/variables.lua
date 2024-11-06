--variables
gamecount=0
old_death_count=0
cur_death_count=0

function _init()
    scene="menu"
    level=1
    count=0
    
    countdown_timer=25
    match = {
        sp = 130,
        x = levels[level].match_info.x,
        startx=levels[level].match_info.startx,
        y = levels[level].match_info.y,
        starty=levels[level].match_info.starty,
        w = 2,
        h = 6,
        dx=0,
        dy=0,
        moving = false,
        held = false,
        anim=0,
        active=true
    }

    --end fire 
    sticks = {
        sp = 136,
        x = 296,
        y = 8,
        w = 8,
        h = 3,
        lit=false,
        lit_time=0,
    }

    player={
        sp=1,
        x=0,
        startx=0,
        starty=96,
        y=96,
        w=8,
        h=7,
        flip_x=false,
        flip_y=false,
        dx=0,
        dy=0,
        max_dx=2,
        max_dy=3,
        acc=0.5,
        boost=2,
        anim=0,
        jumping=false,
        falling=false,
        running=false,
        sliding=false,
        landed=false,
        dead=false,
        sword=false,
        gravity = 0.28,
        friction = 0.70,
    }

    

    --simple camera
    cam_x=0

    --map limits
    map_start=0
    map_end=312

   
 
end
