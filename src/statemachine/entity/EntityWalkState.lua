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

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    if jDebug then
        love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end