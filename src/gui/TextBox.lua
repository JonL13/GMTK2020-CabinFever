Textbox = Class{}

function Textbox:init(x, y, width, height, text, font, align)
    self.panel = Panel(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.font = font or gFonts['small']
    _, self.textChunks = self.font:getWrap(self.text, self.width - 12)

    self.chunkCounter = 1
    self.endOfText = false
    self.closed = false
    self.align = align or 'left'

    self:next()
end

function Textbox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 4 do
        table.insert(chunks, self.textChunks[i])

        -- if we've reached the number of total chunks, we can return
        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:next()
    end
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()

    love.graphics.setFont(self.font)

    if self.align == 'center' then
        for i = 1, #self.displayingChunks do
            love.graphics.printf(self.displayingChunks[i], self.x, self.y + 3 + (i - 1) * self.font:getHeight(), self.width, self.align)
        end
    else
        for i = 1, #self.displayingChunks do
            love.graphics.printf(self.displayingChunks[i], self.x + 3, self.y + 3 + (i - 1) * self.font:getHeight(), self.width, self.align)
        end
    end
end