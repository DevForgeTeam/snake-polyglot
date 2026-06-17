-- based on tutorial, https://berbasoft.com/simplegametutorials/love/snake/

local draw = require("draw")
local game = require("game")

function love.load()
    love.window.setMode(800,600, {vsync=1})
end

function love.draw()
    draw.playableArea()
    draw.snake()
end

function love.update(dt)
    game.tick(dt)
end

function love.keypressed(key)
    if key == "left" or key == "up" or key == "right" or key == "down" then
        INPUT_DIRECTION = key
    end
end
