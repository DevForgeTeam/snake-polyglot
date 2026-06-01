local Util={}

-- Similiar to Godot's Vector2.LEFT, Vector2.RIGHT, etc. 
Util.dir =
{
    ["left"]  = {x=-1, y=0},
    ["up"]    = {x=0,  y=-1},
    ["right"] = {x=1,  y=0},
    ["down"]  = {x=0,  y=1},
}

function Util.vector_add(v1, v2)
    return
    {
        x = v1.x + v2.x,
        y = v1.y + v2.y,
    }
end

function Util.vector_is_zero(v)
    return v.x == 0 and v.y == 0
end

function Util.generate_lookup_key(coord)
    -- print(coord.x .. "," .. coord.y)
    return coord.x .. "," .. coord.y
end

return Util