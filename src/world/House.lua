House = Class{}

function House:init()
    self.width = 24
    self.height = 13

    self.baseLayer = TileMap(self.width, self.height)
    self.itemLayer = TileMap(self.width, self.height)
    self:createBaseLayer()
    --self:createItemLayer()
end

function House:createBaseLayer()
    for y = 1, self.height do
        table.insert(self.baseLayer.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY
            local type = "empty"


            if x == 1 and y == 1 then
                id = TILE_BORDER_TOP_LEFT
                type = "border"
            elseif x == self.width and y == 1 then
                id = TILE_BORDER_TOP_RIGHT
                type = "border"
            elseif x == 1 and y == self.height then
                id = TILE_BORDER_BOTTOM_LEFT
                type = "border"
            elseif x == self.width and y == self.height then
                id = TILE_BORDER_BOTTOM_RIGHT
                type = "border"

            -- wall
            elseif x == 2 and y == 2 then
                id = TILE_WALL_TOP_LEFT
                type = "wall"
            elseif x == self.width - 1 and y == 2 then
                id = TILE_WALL_TOP_RIGHT
                type = "wall"
            elseif x == 2 and y == 4 then
                id = TILE_WALL_BOTTOM_LEFT
                type = "wall"
            elseif x == self.width - 1 and y == 4 then
                id = TILE_WALL_BOTTOM_RIGHT
                type = "wall"
            elseif x == 2 and y == 3 then
                id = TILE_WALL_MIDDLE_LEFT
                type = "wall"
            elseif x == self.width - 1 and y == 3 then
                id = TILE_WALL_MIDDLE_RIGHT
                type = "wall"

            elseif x == 1 then
                id = TILE_BORDER_LEFT
                type = "border"
            elseif x == self.width then
                id = TILE_BORDER_RIGHT
                type = "border"
            elseif y == 1 then
                id = TILE_BORDER_TOP_MIDDLE
                type = "border"
            elseif y == self.height then
                id = TILE_BORDER_BOTTOM
                type = "border"

            elseif y == 2 then
                id = TILE_WALL_TOP_MIDDLE
                type = "wall"
            elseif y == 3 then
                id = TILE_WALL_MIDDLE_MIDDLE
                type = "wall"
            elseif y == 4 then
                id = TILE_WALL_BOTTOM_MIDDLE
                type = "wall"

            else
                id = TILE_FLOOR_WOOD
                type = "floor"
            end

            local tile = Tile(x, y, type, id)
            table.insert(self.baseLayer.tiles[y], tile)
        end
    end
end

function House:createItemLayer()
    for y = 1, self.height do
        table.insert(self.itemLayer.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY
            local type = "empty"

            --if x ==



        end
    end
end

function House:render()
    self.baseLayer:render()
    --self.itemLayer:render()
end