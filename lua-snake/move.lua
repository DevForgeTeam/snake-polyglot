local Move={}

local game = require("game")

local dir = {
    ["left"]={x=-1,y=0},
    ["up"]={x=0,y=-1},
    ["right"]={x=1,y=0},
    ["down"]={x=0,y=1},
}

local touching_bounds = false

local function move(d)
    local temp = {x=SNAKE.COORDS[1].x+dir[d].x, y=SNAKE.COORDS[1].y+dir[d].y}
    table.insert(SNAKE.COORDS, 1, temp)
    table.remove(SNAKE.COORDS)
end

-- debug ---------------------------
local function printCoords()
    for i, v in ipairs(SNAKE.COORDS) do
        print("x: " .. v.x .. "   y: " .. v.y)
    end
    print()
end
------------------------------------

function Move.tick(dt, direction)
    GAME.TIME = GAME.TIME + dt

    if GAME.TIME >= 0.40 then
        GAME.TIME = 0

        if not touching_bounds or GAME.INTERSECTED ~= direction then
            move(direction)
            game.bounds_touched()
        else
            love.event.quit("restart")
        end

        touching_bounds = GAME.INTERSECTED ~= nil

    end
end

return Move