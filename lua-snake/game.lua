local Game = {}

function Game.bounds_touched()
    local head = SNAKE.COORDS[1]

    local top_left = { 
        x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE),
        y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE)
    }
    local bottom_right = { 
        x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE) + GAME.CELLSIZE - 2,
        y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE) + GAME.CELLSIZE - 2
    }

    -- print("top left"..top_left.y)

    local intersected_right = bottom_right.x >= GAME.AREA.WIDTH + GAME.AREA.OFFSET - 2
    local intersected_left = top_left.x <= GAME.AREA.OFFSET
    local intersected_top = top_left.y <= GAME.AREA.OFFSET
    local intersected_bottom = bottom_right.y >= GAME.AREA.HEIGHT + GAME.AREA.OFFSET - 2

    if (intersected_right) then GAME.INTERSECTED = "right"
    elseif (intersected_left) then GAME.INTERSECTED = "left"
    elseif (intersected_top) then GAME.INTERSECTED = "up"
    elseif (intersected_bottom) then GAME.INTERSECTED = "down"
    else GAME.INTERSECTED = nil end

    -- if (intersected_right) then print("right " .. bottom_right.x)
    -- elseif (intersected_left) then print("left " .. top_left.x)
    -- elseif (intersected_top) then print("top " .. top_left.y)
    -- elseif (intersected_bottom) then print("bottom " .. bottom_right.y) end

    -- if (intersected_right) then return "right"
    -- elseif (intersected_left) then return "left"
    -- elseif (intersected_top) then return "up"
    -- elseif (intersected_bottom) then return "down"
    -- else return nil end

    -- if (intersected_right) then print("right " .. bottom_right.x) end
    -- if (intersected_left) then print("left " .. top_left.x) end
    -- if (intersected_top) then print("top " .. top_left.y) end
    -- if (intersected_bottom) then print("bottom " .. bottom_right.y) end

    -- return intersected_right or intersected_left or intersected_top or intersected_bottom
end

return Game