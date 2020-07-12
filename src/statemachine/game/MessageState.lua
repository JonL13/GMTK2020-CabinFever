MessageState = Class{__includes = BaseState}

function MessageState:init(def)
    self.stateName = "MessageState"
    self.textbox = Textbox(def.x or makeEven(VIRTUAL_WIDTH/4), def.y or makeEven(VIRTUAL_HEIGHT/2 - 28) , def.width or makeEven(VIRTUAL_WIDTH/2), def.height or 48, def.text, def.font or gFonts['small'], "center")

    -- function to be called once this message is popped
    self.onClose = def.onClose or function() end

    -- whether we can detect input with this or not; true by default
    self.canInput = def.canInput or true
end

function MessageState:update(dt)
    if self.canInput then
        self.textbox:update(dt)

        if self.textbox:isClosed() then
            gStateStack:pop()
            self.onClose()
        end
    end
end

function MessageState:render()
    self.textbox:render()
end