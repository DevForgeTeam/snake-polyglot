-- based on tutorial, https://berbasoft.com/simplegametutorials/love/snake/
Game = {
    area = {
        x = 100,
        y = 100,
        x2 = 600,
        y2=400
    }
}

Cellsize = 20

function love.load()
    love.window.setMode(800,600, {vsync=1})
end

function love.draw()
    -- love.graphics.print("hello wolrd!", 400, 300)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", Game.area.x,Game.area.y,Game.area.x2,Game.area.y2)
    Draw_snake()
end

function love.update(dt)
end

function Draw_snake()
    local snake_segments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1},
    }

    love.graphics.setColor(0,1,0)
    -- love.graphics.rectangle("fill", Game.area.x + 5, Game.area.y+5, Game.area.x+10, Game.area.y+10)
    -- love.graphics.rectangle("fill", 5, 5, 20, 20)
    for i,position in ipairs(snake_segments) do
        -- love.graphics.rectangle("fill", Game.area.x + (5*i), Game.area.y+5, Cellsize-2,Cellsize-2)
        love.graphics.rectangle("fill", Game.area.x + (position.x * Cellsize), Game.area.y + (position.y * Cellsize), Cellsize-2,Cellsize-2)
        -- Draw_snake_segment((Game.area.x + (5*i)), Game.area.y+5, 2)
    end
end

function Draw_snake_segment(x,y,offset)
    love.graphics.rectangle("fill", x-offset, y, Cellsize-offset,Cellsize)

end