require("globals") -- ensures the variables in this file are init. upon game start
local util = require("utils")
local snake = require("snake")

local Game = {}


local function util_get_top_left_coord(coord)
    return {
        x = GAME.AREA.OFFSET + (coord.x * GAME.CELLSIZE),
        y = GAME.AREA.OFFSET + (coord.y * GAME.CELLSIZE)
    }
end

local function util_get_bottom_right_coord(coord)
    return {
        x = GAME.AREA.OFFSET + (coord.x * GAME.CELLSIZE) + GAME.CELLSIZE - 2,
        y = GAME.AREA.OFFSET + (coord.y * GAME.CELLSIZE) + GAME.CELLSIZE - 2
    }
end

local function generate_unoccupied_coords()
    local coords = {}

    local max_width  = math.floor((GAME.AREA.WIDTH/GAME.CELLSIZE))-1
    local max_height =  math.floor((GAME.AREA.HEIGHT/GAME.CELLSIZE))-1

    for x=0,max_width do
        for y=0,max_height do
            local coord = {x=x,y=y}
            local key = util.generate_lookup_key(coord)
            if SNAKE.LOOKUP[key] == nil then
                table.insert(coords, coord)
            end
        end
    end

    return coords
end

local function display_coords_table(coords)
    for i, v in ipairs(coords) do print(util.generate_lookup_key(v)) end
end

function Game.bounds_touched(coords)

    local top_left = util_get_top_left_coord(coords)
    local bottom_right = util_get_bottom_right_coord(coords)

    -- print("top left"..top_left.y)

    -- not using =, to allow snake to touch wall so player can move along wall
    local intersected_right = bottom_right.x > GAME.AREA.WIDTH + GAME.AREA.OFFSET
    local intersected_left = top_left.x < GAME.AREA.OFFSET
    local intersected_top = top_left.y < GAME.AREA.OFFSET
    local intersected_bottom = bottom_right.y > GAME.AREA.HEIGHT + GAME.AREA.OFFSET

    if (intersected_right) then return "right"
    elseif (intersected_left) then return "left"
    elseif (intersected_top) then return "up"
    elseif (intersected_bottom) then return "down"
    else return nil end
end

function Game.snake_touched(new_head)
    if SNAKE.LOOKUP[util.generate_lookup_key(new_head)] ~= nil then
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        print("snake touched!")
        print("x: " .. new_head.x .. ", y: ".. new_head.y)
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
    end
    return SNAKE.LOOKUP[util.generate_lookup_key(new_head)] ~= nil
end

function Game.food_touched()
    local snake_top_left = util_get_top_left_coord(SNAKE.COORDS[1])
    local snake_bottom_right = util_get_bottom_right_coord(SNAKE.COORDS[1])

    local food_top_left = util_get_top_left_coord(FOOD.POSITION)
    local food_bottom_right = util_get_bottom_right_coord(FOOD.POSITION)


    local snake_head_cell = {
        x1 = snake_top_left.x,
        x2 = snake_bottom_right.x,
        y1 = snake_top_left.y,
        y2 = snake_bottom_right.y
    }

    local food_cell = {
        x1 = food_top_left.x,
        x2 = food_bottom_right.x,
        y1 = food_top_left.y,
        y2 = food_bottom_right.y
    }

    local on_same_row = snake_head_cell.y1 >= food_cell.y1 and snake_head_cell.y2 <= food_cell.y2
    local on_same_column = snake_head_cell.x1 >= food_cell.x1 and snake_head_cell.x2 <= food_cell.x2

    return on_same_row and on_same_column
end

function Game.restart_game()
    love.event.quit("restart")
end

function Game.spawn_food()

    local unoccupied_coords = generate_unoccupied_coords()
    local index = love.math.random(1,#unoccupied_coords+1)

    FOOD.POSITION = {
        x = unoccupied_coords[index].x,
        y = unoccupied_coords[index].y
    }
end

function Game.old_spawn_food()
    FOOD.POSITION = {
        x = love.math.random(0, math.floor((GAME.AREA.WIDTH/GAME.CELLSIZE)-1)),
        y = love.math.random(0, math.floor((GAME.AREA.HEIGHT/GAME.CELLSIZE)-1)),
    }

    -- if not food_spawned then

        -- FOOD.POSITION = {
            -- x = love.math.random(0, math.floor((GAME.AREA.WIDTH/GAME.CELLSIZE)-1)),
            -- y = love.math.random(0, math.floor((GAME.AREA.HEIGHT/GAME.CELLSIZE)-1)),
        -- }

        -- Confirmed apple spawns right next to walls
        -- FOOD.POSITION = {
        --     x = (GAME.AREA.WIDTH/GAME.CELLSIZE)-1,
        --     y = (GAME.AREA.HEIGHT/GAME.CELLSIZE)-1
        -- }

        -- FOOD.POSITION = {x=0,y=19}

        -- food_spawned = true
        -- print("food spawned!")
        -- print(FOOD.POSITION.x .. ", " .. FOOD.POSITION.y)
    -- else
        -- return
    -- end
end

-- Runs every frame (inside update() function)
function Game.tick(dt)
    -- Increment game timer
    GAME.TIME = GAME.TIME + dt

    -- Once game timer reaches 0.20 seconds, then check game lose condtions and move snake
    if GAME.TIME >= GAME.TICK_TIME then
        GAME.TIME = 0
        local new_snakehead_coords = snake.get_new_head_coord()

        -- snake touched walls = game over
        if Game.bounds_touched(new_snakehead_coords) or Game.snake_touched(new_snakehead_coords) then
            -- Game.restart_game()
            GAME.PLAYING = false
        -- elseif Game.snake_touched(new_snakehead_coords) then
            -- print("touched!")
        end

        snake.increment_head(new_snakehead_coords)

        if Game.food_touched() then
            GAME.SCORE = GAME.SCORE + 1
            if GAME.TICK_TIME >= 0.15 then
                GAME.TICK_TIME = GAME.TICK_TIME-0.05
            -- elseif GAME.TICK_TIME < 0.15 and GAME.TICK_TIME >= 0.08 then
                -- GAME.TICK_TIME = GAME.TICK_TIME-0.01
            end
            Game.spawn_food()
        else
            snake.decrement_tail()
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