PlayerCrazyState = Class{__includes = BaseState}

function PlayerCrazyState:init(player, cabin)
    self.entity = player
    self.cabin = cabin

    self.entity.isCrazy = true
    self.entity:changeAnimation('crazy')
    self.entity.walkSpeed = PLAYER_CRAZY_SPEED

    self.moveDuration = 0
    self.movementTimer = 0

    self.sanity = 0

    self.cabin:switchDecoration("zombie")

    self.crazyBar = ProgressBar{
        x = VIRTUAL_WIDTH / 4,
        y = (VIRTUAL_HEIGHT / 4) * 3,
        width = VIRTUAL_WIDTH / 2,
        height = 16,
        value = self.sanity,
        max = player.craziness,
        color = {r = .29, g = .41, b = .18},
    }
end

function PlayerCrazyState:update(dt)
    local directions = {'left', 'right', 'up', 'down'}

    if love.keyboard.wasPressed('space')
            or love.keyboard.wasPressed('w') or love.keyboard.wasPressed('a') or love.keyboard.wasPressed('s') or love.keyboard.wasPressed('d')
            or love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') or love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then
        self.sanity = self.sanity + 1
    end

    self.crazyBar.value = self.sanity

    if self.moveDuration == 0 or self.bumped then
        -- set an initial move duration and direction
        self.moveDuration = math.random(3)
        self.entity.direction = directions[math.random(#directions)]
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0
        -- chance to go idle
        if math.random(30) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(6)
            self.entity.direction = directions[math.random(#directions)]
        end
    end

    if self.sanity > self.entity.craziness then
        self.entity.isCrazy = false
        self.cabin:switchDecoration("human")
        self.entity:changeState('idle')
    end

    EntityWalkState.update(self, dt)
end

function PlayerCrazyState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end