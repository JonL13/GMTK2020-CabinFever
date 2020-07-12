PlayerAttackState = Class{__includes = BaseState}

-- forward declaration for local functions
local generateHeart

function PlayerAttackState:init(player, cabin)
    self.player = player
    self.cabin = cabin

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 16
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y - 1
    elseif direction == 'right' then
        hitboxWidth = 16
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y - 1
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 16
        hitboxX = self.player.x - 1
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 16
        hitboxX = self.player.x - 1
        hitboxY = self.player.y + self.player.height
    end

    self.attackHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.player:changeAnimation('attack')

    self.smokeAnimation = Animation{
        texture = "smoke-effect",
        interval = .15,
        frames = {1,2,3},
        looping = false
    }
end

function PlayerAttackState:enter(params)
    gSoundEffects['hit']:stop()
    gSoundEffects['hit']:play()
    self.player.currentAnimation:refresh()
end

function PlayerAttackState:update(dt)
    -- check if hitbox collides with any entities in the scene
    for _, enemy in pairs(self.cabin.enemies) do

        if enemy:collide(self.attackHitbox) then
            enemy:damage(1)
            enemy:setInvulnerableDuration(.3)
        end
    end

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('attack')
    end

    self.smokeAnimation:update(dt)
end

function PlayerAttackState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    love.graphics.draw(
            gTextures[self.smokeAnimation.texture],
            gFrames[self.smokeAnimation.texture][self.smokeAnimation:getCurrentFrame()],
            self.attackHitbox.x, self.attackHitbox.y
    )
     --debug for player and hurtbox collision rects
     --love.graphics.setColor(255, 0, 255, 255)
     --love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
     --love.graphics.rectangle('line', self.attackHitbox.x, self.attackHitbox.y,
     --    self.attackHitbox.width, self.attackHitbox.height)
     --love.graphics.setColor(255, 255, 255, 255)
end