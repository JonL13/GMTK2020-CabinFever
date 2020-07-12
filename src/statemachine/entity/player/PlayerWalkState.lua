PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, cabin)
    self.entity = player
    self.cabin = cabin


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
end