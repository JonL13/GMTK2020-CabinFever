Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.cabin = def.cabin

    self.stateMachine = StateMachine{
        ['idle'] = function() return PlayerIdleState(self, self.cabin) end,
        ['walk'] = function() return PlayerWalkState(self, self.cabin) end,
    }
    self:changeState('idle')
end

function Player:update(dt)
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