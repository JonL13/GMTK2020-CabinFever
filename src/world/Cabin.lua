Cabin = Class{}

local generateLayers
local zombieSpawnPoints = {{x = 210, y = 322}, {x = 17, y = 178}, {x = 498, y = 194}}

function Cabin:init(def)
    self.width = def.width
    self.height = def.height

    self.player = def.player

    self.tiledMap = def.tiledMap

    self.zombieSpawnTimer = 0
    self.zombieSpawnDuration = math.random(10)

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
    --table.insert(self.enemies, Zombie{
    --    x = 210,
    --    y = 322,
    --    cabin = self
    --})
    --table.insert(self.enemies, Zombie{
    --    x = 17,
    --    y = 178,
    --    cabin = self
    --})
    --table.insert(self.enemies, Zombie{
    --    x = 498,
    --    y = 194,
    --    cabin = self
    --})
end

function Cabin:update(dt)
    --self.floorLayer:update(dt)

    for _, enemy in pairs(self.enemies) do
        enemy:update(dt)

        if enemy.isAlive and self.player:collide(enemy) then
            self.player:damage(1)
            self.player:setInvulnerableDuration(.5)
        end
    end

    for i = #self.enemies, 1, -1 do
        if not self.enemies[i].isAlive then
            table.remove(self.enemies, i)
        end
    end

    if self.zombieSpawnTimer > self.zombieSpawnDuration then
        print('spawning zombie!')
        self.zombieSpawnTimer = 0
        self.zombieSpawnDuration = math.random(15)
        local spawnPoint = zombieSpawnPoints[math.random(#zombieSpawnPoints)]
        print_r(spawnPoint)
        table.insert(self.enemies, Zombie{
            x = spawnPoint.x,
            y = spawnPoint.y,
            cabin = self
        })
    end
    self.zombieSpawnTimer = self.zombieSpawnTimer + dt
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