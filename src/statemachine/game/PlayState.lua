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
        --print_r(object.layer.name)
        if object.layer.name == "Player" then
            print_r(object)
            local stiMapPlayer = object
            break
        end
    end

    --self.house = House()
    -- create player
    -- create house

end

function PlayState:enter(params)

end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.map:update()

    --self.dungeon:update(dt)
end

function PlayState:render()
    --self.house:render()
    self.map:draw()
end