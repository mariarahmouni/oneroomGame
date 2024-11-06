--collisions
--obj = game object
--aim = object direction

function collide_map(obj, aim, flag)
    local x = obj.x
    local y = obj.y
    local w = obj.w
    local h = obj.h

    local x1 = 0
    local x2 = 0
    local y1 = 0
    local y2 = 0

    if aim == "left" then
        x1 = x 
        y1 = y+2
        x2 = x 
        y2 = y + h - 1
    elseif aim == "right" then
        x1 = x + w 
        y1 = y+2
        x2 = x + w 
        y2 = y + h - 1
    elseif aim == "up" then
        x1 = x + 2 
        y1 = y 
        x2 = x + w - 3 
        y2 = y+h-3
    elseif aim == "down" then
        x1 = x + 2 
        y1 = y + h
        x2 = x + w - 3 
        y2 = y + h
    end


    x1r = x1
    x2r = x2
    y1r = y1
    y2r = y2

    --change pixels to tiles

    x1 /= 8
    y1 /= 8
    x2 /= 8
    y2 /= 8

    if fget(mget(x1, y1), flag)
            or fget(mget(x1, y2), flag)
            or fget(mget(x2, y1), flag)
            or fget(mget(x2, y2), flag) then
        return true
    else
        return false
    end
end

function collision_obj(obj1, obj2)
    if obj1.x < obj2.x + obj2.w
            and obj1.x + obj1.w + 4 > obj2.x
            and obj1.y < obj2.y + obj2.h
            and obj1.y + obj1.h + 4 > obj2.y then
        if obj1 == match then
            sfx(6)
        end
        return true
    else
        return false
    end
end