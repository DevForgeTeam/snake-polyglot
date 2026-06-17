local Game = {}

require("globals") -- ensures the variables in this file are init. upon game start
local snake = require("snake")

function Game.bounds_touched(coords)
    local head = coords

    local top_left = { 
        x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE),
        y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE)
    }
    local bottom_right = { 
        x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE) + GAME.CELLSIZE - 2,
        y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE) + GAME.CELLSIZE - 2
    }

    -- print("top left"..top_left.y)

    local intersected_right = bottom_right.x > GAME.AREA.WIDTH + GAME.AREA.OFFSET - 2
    local intersected_left = top_left.x < GAME.AREA.OFFSET
    local intersected_top = top_left.y < GAME.AREA.OFFSET
    local intersected_bottom = bottom_right.y > GAME.AREA.HEIGHT + GAME.AREA.OFFSET - 2

    if (intersected_right) then return "right"
    elseif (intersected_left) then return "left"
    elseif (intersected_top) then return "up"
    elseif (intersected_bottom) then return "down"
    else return nil end

end

function Game.restart_game()
    love.event.quit("restart")
end

-- Runs every frame (inside update() function)
function Game.tick(dt)
    -- Increment game timer
    GAME.TIME = GAME.TIME + dt

    -- Once game timer reaches 0.20 seconds, then check game lose condtions and move snake
    if GAME.TIME >= 0.20 then
        GAME.TIME = 0
        local new_snakehead_coords = snake.increment_head()

        -- snake touched walls = game over
        if Game.bounds_touched(new_snakehead_coords) then
            Game.restart_game()
        else
            snake.move_snake(new_snakehead_coords)
        end
    end
end

return Game

-- I don't remember why I made this function...maybe for debugging?
-- function Game.bounds_touched_x()
--     local head = SNAKE.COORDS[1]

--     local top_left = { 
--         x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE),
--         y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE)
--     }
--     local bottom_right = { 
--         x = GAME.AREA.OFFSET + (head.x * GAME.CELLSIZE) + GAME.CELLSIZE - 2,
--         y = GAME.AREA.OFFSET + (head.y * GAME.CELLSIZE) + GAME.CELLSIZE - 2
--     }

--     local intersected_right = bottom_right.x >= GAME.AREA.WIDTH + GAME.AREA.OFFSET - 2
--     local intersected_left = top_left.x <= GAME.AREA.OFFSET
--     local intersected_top = top_left.y <= GAME.AREA.OFFSET
--     local intersected_bottom = bottom_right.y >= GAME.AREA.HEIGHT + GAME.AREA.OFFSET - 2

--     if (intersected_right) then GAME.INTERSECTED = "right"
--     elseif (intersected_left) then GAME.INTERSECTED = "left"
--     elseif (intersected_top) then GAME.INTERSECTED = "up"
--     elseif (intersected_bottom) then GAME.INTERSECTED = "down"
--     else GAME.INTERSECTED = nil end

-- end