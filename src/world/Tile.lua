Tile = Class{}

function Tile:init(def)
    self.x = def.x
    self.y = def.y
    self.id = def.id
    self.type = def.type
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][self.id],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end