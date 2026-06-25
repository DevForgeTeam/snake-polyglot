-- based on tutorial, https://berbasoft.com/simplegametutorials/love/snake/

local draw = require("draw")
local game = require("game")

function love.load()
    love.window.setMode(740,740, {vsync=1})
    game.spawn_food()
end

function love.draw()
    draw.playableArea()
    draw.snake()
    draw.food()
    draw.displayScore()

    if not GAME.PLAYING then draw.game_over_screen() end
end

function love.update(dt)
    if GAME.PLAYING then game.tick(dt) end
end

function love.keypressed(key)
    if key == "left" or key == "up" or key == "right" or key == "down" then
        INPUT_DIRECTION = key
    elseif key == "return" then
        game.restart_game()
    end
end
