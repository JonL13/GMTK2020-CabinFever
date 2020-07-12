ZombieWalkState = Class{__includes = BaseState}

function ZombieWalkState:init(entity, cabin)
    self.entity = entity
    self.entity:changeAnimation('walk')

    self.cabin = cabin

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function ZombieWalkState:update(dt)
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        -- set an initial move duration and direction
        self.moveDuration = math.random(9)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk')
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(5) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(6)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk')
        end
    end
    self.movementTimer = self.movementTimer + dt

    EntityWalkState.update(self, dt)

    --if(self.bumped == false) then
    --    if self.entity.direction == 'left' then
    --        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    --    elseif self.entity.direction == 'right' then
    --        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    --    elseif self.entity.direction == 'up' then
    --        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    --    elseif self.entity.direction == 'down' then
    --        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    --    end
    --end
end
--
--function ZombieWalkState:processAI(params, dt)
--    local cabin = params.cabin
--    local directions = {'left', 'right', 'up', 'down'}
--
--    if self.moveDuration == 0 or self.bumped then
--
--        -- set an initial move duration and direction
--        self.moveDuration = math.random(9)
--        self.entity.direction = directions[math.random(#directions)]
--        self.entity:changeAnimation('walk')
--    elseif self.movementTimer > self.moveDuration then
--        self.movementTimer = 0
--
--        -- chance to go idle
--        if math.random(5) == 1 then
--            self.entity:changeState('idle')
--        else
--            self.moveDuration = math.random(6)
--            self.entity.direction = directions[math.random(#directions)]
--            self.entity:changeAnimation('walk')
--        end
--    end
--
--    self.movementTimer = self.movementTimer + dt
--end

function ZombieWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

     --love.graphics.setColor(255, 0, 255, 255)
     --love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
     --love.graphics.setColor(255, 255, 255, 255)
end