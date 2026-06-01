-- Variables are global by default, but I just wanted to organize them in one place for readability

-- Game values
GAME =
{
    AREA =
        {
            OFFSET=50,
            WIDTH=640,
            HEIGHT=640
        },
    AREA_COLOR = {76/255,165/255,224/255},
    CELLSIZE=32,
    TIME=0,
    TICK_TIME=0.40,
    INTERSECTED = nil,
    PLAYING = true,
    SCORE = 0
}

--  Snake Values
SNAKE =
{
    -- X,Y coordinates of snake body segments
    -- Each value is one segment
    COORDS =
        {
            {x = 10, y = 10},
            {x = 9, y = 10},
            {x = 8, y = 10},
        },
    -- LOOKUP = {},
    LOOKUP =
        {
            ["10,10"]={x = 10, y = 10},
            ["9,10"]={x = 9, y = 10},
            ["8,10"]={x = 8, y = 10},
        },
    BODY_COLOR = {0,0.80,0.55},
    -- BODY_COLOR = {1,0,0},
    HEAD_COLOR = {0,1,0},
    DIRECTION = "right"
}

INPUT_DIRECTION = "right"
FOOD = {
    POSITION = {x = 0, y = 0},
    COLOR = {1, 0, 0},
}