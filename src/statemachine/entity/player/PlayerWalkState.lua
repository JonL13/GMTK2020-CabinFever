PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, cabin)
    self.entity = player
    self.cabin = cabin
    self.entity.walkSpeed = PLAYER_WALK_SPEED

    self.entity:changeAnimation('walk')
end

function PlayerWalkState:update(dt)
    if love.keyboard.wasPressed('space') then
        self.entity:changeState('attack')
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.entity.direction = 'left'
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.entity.direction = 'right'
    elseif love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        self.entity.direction = 'up'
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.entity.direction = 'down'
    else
        self.entity:changeState('idle')
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end