--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.map = sti("src/assets/maps/cabinmap.lua")
    local stiMapPlayer
    for _, object in pairs(self.map.objects) do
        if object.layer.name == "Player" then
            stiMapPlayer = object
            break
        end
    end

    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        map = self.map,

        x = stiMapPlayer.x,
        y = stiMapPlayer.y,

        health = ENTITY_DEFS['player'].maxHealth,
        width = 12,
        height = 12,
    }
    self.player:changeState('idle')



end

function PlayState:enter(params)

end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.map:update()
end

function PlayState:render()
    self.map:draw()
    self.player:render()
end