Zombie = Class{__includes = Entity}

function Zombie:init(def)
    def.animations = ENTITY_DEFS['zombie'].animations
    def.walkSpeed = ENTITY_DEFS['zombie'].walkSpeed

    def.offsetX = 3
    def.offsetY = 3

    def.width = 8
    def.height = 8
    def.health = 3

    Entity.init(self, def)
    self.cabin = def.cabin

    self.stateMachine = StateMachine{
        ['idle'] = function() return ZombieIdleState(self, self.cabin) end,
        ['walk'] = function() return ZombieWalkState(self, self.cabin) end,
    }
    self:changeState('walk')
end

function Zombie:update(dt)
    Entity.update(self, dt)
end

function Zombie:render()
    Entity.render(self)
end