EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, cabin)
    self.entity = entity
    self.entity:changeAnimation('walk')

    self.cabin = cabin

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function EntityWalkState:update(dt, cabin)
    -- assume we didn't hit a wall
    self.bumped = false
    local tileX, tileY
    if self.entity.direction == 'left' then
        tileX, tileY = convertPixelToTile (self.entity.x - 2, self.entity.y)
    elseif self.entity.direction == 'right' then
        tileX, tileY = convertPixelToTile (self.entity.x + self.entity.width + 2, self.entity.y)
    elseif self.entity.direction == 'up' then
        tileX, tileY = convertPixelToTile (self.entity.x, self.entity.y - 2)
    else
        tileX, tileY = convertPixelToTile (self.entity.x, self.entity.y + self.entity.height + 2)
    end

    if not self.cabin:canMoveOnTile(tileX, tileY) then
        self.bumped = true
    end

    --print(string.format("bumped: %s", tostring(self.bumped)))

    if(self.bumped == false) then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        elseif self.entity.direction == 'down' then
            self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        end
    end
end

function EntityWalkState:processAI(params, dt)
    local room = params.room
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then

        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk')
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk-')
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end