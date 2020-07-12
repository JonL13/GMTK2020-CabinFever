PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, cabin)
    self.entity = player
    self.cabin = cabin

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 3

    self.entity:changeAnimation('walk')
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
    else
        self.entity:changeState('idle')
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        if self.entity.direction == 'left' then
        elseif self.entity.direction == 'right' then
        elseif self.entity.direction == 'up' then
        else
        end
    end
end