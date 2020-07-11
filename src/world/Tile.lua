Tile = Class{}

function Tile:init(x, y, type, id)
    self.x = x
    self.y = y
    self.type = type
    self.id = id
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.draw(gTextures['horrorHouse'], gFrames['horrorHouse'][self.id],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    love.graphics.setFont(gFonts['small'])
    --love.graphics.printf(string.format("%d,%d", self.x, self.y), (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end