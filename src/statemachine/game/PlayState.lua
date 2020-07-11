--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    --self.map = sti("src/data/maps/cabin_map.lua")
    --
    --local stiMapPlayer
    --for _, object in pairs(self.map.objects) do
    --    if object.layer.name == "Player" then
    --        stiMapPlayer = object
    --        break
    --    end
    --end

    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        map = self.map,

        x = 209,
        y = 321,

        health = ENTITY_DEFS['player'].maxHealth,
        width = 12,
        height = 12,
    }

    self.cabin = Cabin{
        width = 38,
        height = 23,
        player = self.player,
        tiledMap = cabin_map
    }
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.cabin:update(dt)
end

function PlayState:render()
    self.player:render()
    self.cabin:render()
end