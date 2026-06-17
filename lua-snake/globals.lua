-- Variables are global by default, but I just wanted to organize them in one place for readability

-- Game values
GAME =
{
    AREA =
        {
            OFFSET=100,
            WIDTH=600,
            HEIGHT=400
        },
    AREA_COLOR = {76/255,165/255,224/255},
    CELLSIZE=20,
    TIME=0,
    INTERSECTED = nil
}

--  Snake Values
SNAKE =
{
    -- X,Y coordinates of snake body segments
    -- Each value is one segment
    COORDS =
        {
            {x = 3, y = 1},
            {x = 2, y = 1},
            {x = 1, y = 1},
        },
    -- BODY_COLOR = {0,0.80,0.55},
    BODY_COLOR = {1,0,0},
    HEAD_COLOR = {0,1,0},
    DIRECTION = "right"
}

INPUT_DIRECTION = "right"
FOOD = {
    POSITION = {x = 0, y = 0},
    COLOR = {1, 0, 0},
}