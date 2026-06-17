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

return Draw