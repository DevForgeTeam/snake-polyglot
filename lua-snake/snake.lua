local util = require("utils")

local Snake={}

-- Returns updated coordinates of head of snake by 1 and in the particular direction "d"
function Snake.get_new_head_coord()

    local combined_vector = util.vector_add(util.dir[INPUT_DIRECTION], util.dir[SNAKE.DIRECTION])

    local function increment_head(d)
        return
            {
                x = SNAKE.COORDS[1].x+util.dir[d].x,
                y = SNAKE.COORDS[1].y+util.dir[d].y
            }
    end

    -- if snake and player direction is both horizontal or vertical
    if util.vector_is_zero(combined_vector) then
        -- then don't change snake direction, just increment towards same direction
        return increment_head(SNAKE.DIRECTION)
    else
        -- change snake direction to match INPUT_DIRECTION
        SNAKE.DIRECTION = INPUT_DIRECTION
        -- change snake direction by incrementing head towards INPUT_DIRECTION
        return increment_head(INPUT_DIRECTION)
    end
end

-- Move snake 
function Snake.move(new_snakehead_coord)
    table.insert(SNAKE.COORDS, 1, new_snakehead_coord)
    SNAKE.LOOKUP[util.generate_lookup_key(new_snakehead_coord)] = new_snakehead_coord
end

-- removes last element from list
function Snake.decrement_tail()
    -- [#SNAKE.COORDS] returns last element of table
    local key = util.generate_lookup_key(SNAKE.COORDS[#SNAKE.COORDS])
    SNAKE.LOOKUP[key] = nil
    -- for k,v in pairs(SNAKE.LOOKUP) do print("key: " ..k, "value: " ..v.x..","..v.y) end
    -- print("---------------------------------------")
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

return Snake