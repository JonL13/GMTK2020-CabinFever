PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
end

function PlayerIdleState:update(dt)
    if love.keyboard.wasPressed('space') then
        self.entity:changeState('attack')
    end

    if love.keyboard.isDown('left')
            or love.keyboard.isDown('right')
            or love.keyboard.isDown('up')
            or love.keyboard.isDown('down')
            or love.keyboard.isDown('w')
            or love.keyboard.isDown('a')
            or love.keyboard.isDown('s')
            or love.keyboard.isDown('d') then
        self.entity:changeState('walk')
    end
end