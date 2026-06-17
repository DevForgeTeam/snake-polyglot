local Snake={}

-- Similiar to Godot's Vector2.LEFT, Vector2.RIGHT, etc. 
local dir =
{
    ["left"]  = {x=-1, y=0},
    ["up"]    = {x=0,  y=-1},
    ["right"] = {x=1,  y=0},
    ["down"]  = {x=0,  y=1},
}

local function util_vector_add(v1, v2)
    return
    {
        x = v1.x + v2.x,
        y = v1.y + v2.y,
    }
end

local function util_vector_is_zero(v)
    return v.x == 0 and v.y == 0
end


-- Returns updated coordinates of head of snake by 1 and in the particular direction "d"
function Snake.increment_head()

    local new_snakehead_coord = {x=0, y=0}
    local combined_vector = util_vector_add(dir[INPUT_DIRECTION], dir[SNAKE.DIRECTION])


    local function increment_head(d)
        return
            {
                x = SNAKE.COORDS[1].x+dir[d].x,
                y = SNAKE.COORDS[1].y+dir[d].y
            }
    end

    -- if snake and player direction is both horizontal or vertical
    if util_vector_is_zero(combined_vector) then
        -- then don't change snake direction, just increment towards same direction
        return increment_head(SNAKE.DIRECTION)
    else
        -- change snake direction to match INPUT_DIRECTION
        SNAKE.DIRECTION = INPUT_DIRECTION
        -- change snake direction by incrementing head towards INPUT_DIRECTION
        return increment_head(INPUT_DIRECTION)
    end
end

function Snake.move_snake(new_snakehead_coord)
    table.insert(SNAKE.COORDS, 1, new_snakehead_coord)
    table.remove(SNAKE.COORDS) -- removes last element from list
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