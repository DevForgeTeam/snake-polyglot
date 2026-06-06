-- based on tutorial, https://berbasoft.com/simplegametutorials/love/snake/

local draw = require("draw")

GAME = {
    AREA = {
        OFFSET=100,
        WIDTH=600,
        HEIGHT=400
    },
    AREA_COLOR = {76/255,165/255,224/255},
    CELLSIZE=20
}

SNAKE = {
    COORDS = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1},
    },
    BODY_COLOR = {0,0.80,0.55},
    HEAD_COLOR = {0,1,0}
}

function love.load()
    love.window.setMode(800,600, {vsync=1})
end

function love.draw()
    draw.playableArea(GAME.AREA.WIDTH, GAME.AREA.HEIGHT, GAME.AREA.OFFSET,GAME.AREA_COLOR)
    draw.snake(SNAKE.COORDS, SNAKE.BODY_COLOR, SNAKE.HEAD_COLOR, GAME.AREA.OFFSET,GAME.CELLSIZE)
end

function love.update(dt)
end

