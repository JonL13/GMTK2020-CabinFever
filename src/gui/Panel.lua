Panel = Class{}

function Panel:init(x, y, width, height, activeColor, inactiveColor)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.activeColor = activeColor or {.3, .3, .3, 1}
    self.inactiveColor = inactiveColor or {.15, .15, .15, 1}

    self.visible = true
    self.isActive = true
end

function Panel:update(dt)

end

function Panel:render()
    if self.visible then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
        if self.isActive then
            love.graphics.setColor(self.activeColor)
        else
            love.graphics.setColor(self.inactiveColor)
        end
        love.graphics.rectangle('fill', self.x + 2, self.y + 2, self.width - 4, self.height - 4, 3)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Panel:toggle()
    self.visible = not self.visible
end