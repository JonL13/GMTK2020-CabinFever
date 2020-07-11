StartState = Class{__includes = BaseState}

function StartState:init()
end

function StartState:enter(params)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(PlayState())
    end
end

function StartState:render()
    love.graphics.draw(gTextures['title-background'], 0, 0, 0,
            VIRTUAL_WIDTH / gTextures['title-background']:getWidth(),
            VIRTUAL_HEIGHT / gTextures['title-background']:getHeight())

    love.graphics.setColor(94/255, 117/255, 40/255, 1)
    love.graphics.setFont(gFonts['gothic-medium'])
    love.graphics.printf('Cabin\nFever', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(.1, .1, .1, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(.6, 0, 0, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('A game for GMTK 2020 Game Jam\nCode by Jon Lamont\nMusic by Jon Braun', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH - 16, 'right')
end