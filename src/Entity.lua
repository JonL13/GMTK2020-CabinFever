Entity = Class{}

function Entity:init(def)
    self.animations = self:createAnimations(def.animations)

    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed
    self.health = def.health

    self.invulnerableDuration = 0
    self.isAlive = true -- ?? for zombies?
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:damage(dmg)
    if self.invulnerableDuration <= 0 then
        self.health = self.health - dmg
        -- TODO: add sound
        if self.health <= 0 then
            self.isAlive = false
        end
    end
end

function Entity:collide(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
            self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:setInvulnerableDuration(time)
    if self.invulnerableDuration <= 0 then
        self.invulnerableDuration = time
    end
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    if self.invulnerableDuration > 0 then
        self.invulnerableDuration = self.invulnerableDuration - dt
    end
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setColor(255, 255, 255, 255)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end