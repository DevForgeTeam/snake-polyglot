local Draw = {}

function Draw.playableArea(width, height, offset,color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", offset,offset,width,height)
    love.graphics.setColor(1,1,1)
    love.graphics.setLineWidth(4)
    -- Love2D draws lines centered on the coordinates. A 4-pixel wide border will extend 2 pixels inside and 2 pixels outside your specified dimensions.
    love.graphics.rectangle("line", offset-2,offset-2,width+2,height+2)
end

function Draw.snake(coords, bodyColor, headColor, offset, cellSize)
    love.graphics.setColor(headColor)
    love.graphics.rectangle("fill", offset+(coords[1].x * cellSize), offset+(coords[1].y * cellSize), cellSize-2, cellSize-2)


    love.graphics.setColor(bodyColor)
    for i, position in ipairs(coords) do
        if i ~= 1 then
            love.graphics.rectangle("fill", offset+(position.x * cellSize), offset+(position.y * cellSize), cellSize-2, cellSize-2)
        end
    end
end

return Draw