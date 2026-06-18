local Draw = {}

function Draw.playableArea()

    local o = GAME.AREA.OFFSET
    local w = GAME.AREA.WIDTH
    local h = GAME.AREA.HEIGHT


    love.graphics.setColor(GAME.AREA_COLOR)
    love.graphics.rectangle("fill", o, o, w, h)
    love.graphics.setColor(1,1,1)
    love.graphics.setLineWidth(4)
    -- Love2D draws lines centered on the coordinates
    -- A 4-pixel wide border will extend 2 pixels inside and outside your specified dimensions.
    love.graphics.rectangle("line", o-2, o-2, w+2, h+2)
end

function Draw.snake()
    local o = GAME.AREA.OFFSET
    local s = GAME.CELLSIZE

    -- create head a different color
    love.graphics.setColor(SNAKE.HEAD_COLOR)
    -- cellsize - 2 = creates gap between segments
    love.graphics.rectangle("fill", o+(SNAKE.COORDS[1].x * s), o+(SNAKE.COORDS[1].y * s), s-2, s-2)


    love.graphics.setColor(SNAKE.BODY_COLOR)
    for i, position in ipairs(SNAKE.COORDS) do
        if i ~= 1 then
            love.graphics.rectangle("fill", o+(position.x * s), o+(position.y * s), s-2, s-2)
        end
    end
end

function Draw.food()
    local o = GAME.AREA.OFFSET
    local s = GAME.CELLSIZE

    love.graphics.setColor(FOOD.COLOR)
    love.graphics.rectangle("fill", o+(FOOD.POSITION.x * s), o+(FOOD.POSITION.y*s), s-2, s-2)
end

function Draw.game_over_screen()
        -- Draw Game Over background (darken the screen)
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())

        -- Draw Game Over Text
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(30))
        love.graphics.printf("GAME OVER", 0, 100, love.graphics.getWidth(), 'center')
        love.graphics.printf("Press 'Enter' to Restart", 0, 200, love.graphics.getWidth(), 'center')
        love.graphics.printf("Score: "..GAME.SCORE, 0, 300, love.graphics.getWidth(), 'center')

end

return Draw