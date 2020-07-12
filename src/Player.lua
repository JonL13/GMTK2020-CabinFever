Player = Class{__includes = Entity}

function Player:init(def)
    def.offsetX = 1
    def.offsetY = 5
    Entity.init(self, def)
    self.cabin = def.cabin

    self.isCrazy = false
    self.craziness = 30
    self.crazyTimer = 0
    self.crazyDuration = math.random(40)

    self.zombiesKilled = 0

    self.stateMachine = StateMachine{
        ['idle'] = function() return PlayerIdleState(self, self.cabin) end,
        ['walk'] = function() return PlayerWalkState(self, self.cabin) end,
        ['attack'] = function() return PlayerAttackState(self, self.cabin) end,
        ['crazy'] = function() return PlayerCrazyState(self, self.cabin) end,
    }
    self:changeState('idle')
end

function Player:update(dt)
    if self.crazyTimer > self.crazyDuration then
        self.crazyTimer = 0
        self.crazyDuration = math.random(40)
        self:changeState('crazy')
    end
    self.crazyTimer = self.crazyTimer + dt

    Entity.update(self, dt)
end

function Player:collide(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2

    return not (self.x + self.width < target.x or self.x > target.x + target.width or
            selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:render()
    Entity.render(self)
end