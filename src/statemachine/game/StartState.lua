StartState = Class{__includes = BaseState}

function StartState:init()
end

function StartState:enter(params)
    gMusic['intro-music']:setLooping(true)
    gMusic['intro-music']:play()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(MessageState {
            y = VIRTUAL_HEIGHT / 2 - 16,
            text = "Ouch! I almost made it to Cliff's cabin when I got bit at the supermarket. It's been 6 days since the outbreak of Cozid-20. Thankfully I'm here now but I'm running a bit of a fever...",
            onClose = function()
                gStateStack:push(MessageState {
                    text = "Press arrow keys or WASD to move.\nPress spacebar to attack.\nPress escape to quit.",
                    height = 32,
                    y = VIRTUAL_HEIGHT / 2 - 16,
                    onClose = function()
                        gStateStack:push(MessageState {
                            text = "Don't let the zombies touch you.\nBreak your fever.\nSurvive and kill zombies.",
                            height = 32,
                            y = VIRTUAL_HEIGHT / 2 - 16,
                            onClose = function()
                                gStateStack:pop()
                                gStateStack:push(PlayState())
                            end
                        })
                    end
                })
            end
        })
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