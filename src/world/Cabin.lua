Cabin = Class{}

local generateLayers

function Cabin:init(def)
    self.width = def.width
    self.height = def.height

    self.player = def.player

    self.tiledMap = def.tiledMap

    local tiledMapFloorLayer, tiledMapWallLayer, tiledMapWallLayer2, tiledMapObjectWalkableLayer, tiledMapObjectLayer, tiledMapHumanDecorationLayer, tiledMapZombieDecorationLayer
    for _, layer in pairs(self.tiledMap.layers) do
        if layer.name == "FloorLayer" then
            tiledMapFloorLayer = layer
        elseif layer.name == "WallLayer" then
            tiledMapWallLayer = layer
        elseif layer.name == "WallLayer2" then
            tiledMapWallLayer2 = layer
        elseif layer.name == "ObjectWalkableLayer" then
            tiledMapObjectWalkableLayer = layer
        elseif layer.name == "ObjectLayer" then
            tiledMapObjectLayer = layer
        elseif layer.name == "HumanDecoration" then
            tiledMapHumanDecorationLayer = layer
        elseif layer.name == "ZombieDecoration" then
            tiledMapZombieDecorationLayer = layer
        end
    end

    self.floorLayer = TileMap{
        type = "floor",
        tileData = tiledMapFloorLayer.data,
        width = tiledMapFloorLayer.width,
        height = tiledMapFloorLayer.height,
        visible = true,
    }
    self.wallLayer = TileMap{
        type = "collidable",
        tileData = tiledMapWallLayer.data,
        width = tiledMapWallLayer.width,
        height = tiledMapWallLayer.height,
        visible = true,
    }
    self.wallLayer2 = TileMap{
        type = "collidable",
        tileData = tiledMapWallLayer2.data,
        width = tiledMapWallLayer2.width,
        height = tiledMapWallLayer2.height,
        visible = true,
    }
    self.objectWalkableLayer = TileMap{
        type = "noncollidable",
        tileData = tiledMapObjectWalkableLayer.data,
        width = tiledMapObjectWalkableLayer.width,
        height = tiledMapObjectWalkableLayer.height,
        visible = true,
    }
    self.objectLayer = TileMap{
        type = "collidable",
        tileData = tiledMapObjectLayer.data,
        width = tiledMapObjectLayer.width,
        height = tiledMapObjectLayer.height,
        visible = true,
    }
    self.humanDecorationLayer = TileMap{
        type = "noncollidable",
        tileData = tiledMapHumanDecorationLayer.data,
        width = tiledMapHumanDecorationLayer.width,
        height = tiledMapHumanDecorationLayer.height,
        visible = false,
    }
    self.zombieDecorationLayer = TileMap{
        type = "noncollidable",
        tileData = tiledMapZombieDecorationLayer.data,
        width = tiledMapZombieDecorationLayer.width,
        height = tiledMapZombieDecorationLayer.height,
        visible = true,
    }

    self.enemies = {}
    table.insert(self.enemies, Zombie{
        x = 210,
        y = 250,
        cabin = self
    })
    table.insert(self.enemies, Zombie{
        x = 17,
        y = 178,
        cabin = self
    })
    table.insert(self.enemies, Zombie{
        x = 498,
        y = 194,
        cabin = self
    })
end

function Cabin:update(dt)
    --self.floorLayer:update(dt)

    for _, enemy in pairs(self.enemies) do
        enemy:update(dt)

        if self.player:collide(enemy) then
            print('player collided with enemy')
            self.player:damage(1)
            self.player:setInvulnerableDuration(.5)
        end
    end
end

function Cabin:render()
    self.floorLayer:render()
    self.wallLayer:render()
    self.wallLayer2:render()
    self.objectWalkableLayer:render()
    self.objectLayer:render()

    if self.humanDecorationLayer.visible then
        self.humanDecorationLayer:render()
    else
        self.zombieDecorationLayer:render()
    end

    for _, enemy in pairs(self.enemies) do
        enemy:render()
    end
end

function Cabin:canMoveOnTile(tileX, tileY)
    if self.floorLayer.tiles[tileY][tileX].type == "floor"
        and self.objectLayer.tiles[tileY][tileX].type == "empty"
        and self.wallLayer.tiles[tileY][tileX].type ~= "collidable"
        and self.wallLayer2.tiles[tileY][tileX].type ~= "collidable" then
            return true
        end
    return false
end

generateLayers = function(state)

end