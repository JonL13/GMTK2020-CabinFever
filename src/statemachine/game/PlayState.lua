PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,

        x = 368,
        y = 90,

        health = ENTITY_DEFS['player'].maxHealth,
        width = 8,
        height = 8,
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
end

function PlayState:enter(params)
    gMusic['intro-music']:stop()
    gMusic['main-music']:setLooping(true)
    gMusic['main-music']:play()
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('p') then
        print(string.format('x: %d y: %d', self.player.x, self.player.y))
    end

    self.cabin:update(dt)
    self.player:update(dt)

    self.cam:setPosition(math.floor(self.player.x), math.floor(self.player.y))

    if self.player.health <= 0 then
        local endText
        if self.player.zombiesKilled == 0 then
            endText = string.format("I didn't kill a single one of them...", self.player.zombiesKilled)
        elseif self.player.zombiesKilled < 5 then
            endText = string.format("Only killed %d of them...", self.player.zombiesKilled)
        elseif self.player.zombiesKilled >= 5 and self.player.zombiesKilled < 10  then
            endText = string.format("Mom would be proud, I killed %d of them...", self.player.zombiesKilled)
        else
            endText = string.format("BRAINS AND GUTS, I KILLED %d OF 'EM...", self.player.zombiesKilled)
        end

        gStateStack:push(MessageState {
            text = endText,
            height = 16,
            onClose = function()
                gStateStack:pop()
                gStateStack:push(StartState())
            end
        })
    end
end

function PlayState:render()
    self.cam:draw(function()
        self.cabin:render()
        self.player:render()
    end)

    local heartFrame
    if self.player.health == 3 then
        heartFrame = 1
    elseif self.player.health == 2 then
        heartFrame = 3
    elseif self.player.health == 1 then
        heartFrame = 5
    else
        heartFrame = 7
    end
    love.graphics.draw(gTextures['tilesheet'], gFrames['tilesheet'][heartFrame], 10, 10)

    if self.player.isCrazy then
        self.player.stateMachine.current.crazyBar:render()
    end
end