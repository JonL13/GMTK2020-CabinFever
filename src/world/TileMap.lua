TileMap = Class{}

local generateTiles
local TILE_EMPTY = 8

function TileMap:init(def)
    self.type = def.type
    self.visible = def.visible
    self.width = def.width
    self.height = def.height
    self.tiles = generateTiles(self, def.tileData)
end

function TileMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end

generateTiles = function(tileMap, tileData)
    local tiles = {}
    for y = 1, tileMap.height do
        table.insert(tiles, {})
        for x = 1, tileMap.width do
            local id = TILE_EMPTY
            local type = "empty"
            -- this index references the flattened x, y coordinate. Thanks Lua, for being 1 indexed. -_-
            local index = (tileMap.width * (y - 1)) + x
            local dataId = tileData[index]

            -- Tiled likes to put blank tiles as 0, but we will render them using an empty tile
            if dataId ~= 0 then
                id = dataId
                type = tileMap.type
            end

            table.insert(tiles[y], Tile{
                x = x,
                y = y,
                id = id,
                type = type
            })
        end
    end

    return tiles
end