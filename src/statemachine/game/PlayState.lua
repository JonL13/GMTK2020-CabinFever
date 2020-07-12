--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,

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

    self.player.cabin = self.cabin

    self.cam = gamera.new(0,0,WINDOW_WIDTH, WINDOW_HEIGHT)
    self.cam:setWindow(0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)

    gMusic['intro-music']:setLooping(true)
    gMusic['intro-music']:play()
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.cabin:update(dt)
    self.player:update(dt)

    self.cam:setPosition(self.player.x, self.player.y)
end

function PlayState:render()
    self.cam:draw(function()
        self.cabin:render()
        self.player:render()
    end)
end