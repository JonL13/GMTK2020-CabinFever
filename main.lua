love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'

function love.load()
    jDebug = false
    math.randomseed(os.time())
    love.window.setIcon(gImageData['cabin-fever-icon'])
    love.window.setTitle('Cabin Fever')
    love.mouse.setVisible(false)

    for _, source in pairs(gSoundEffects) do
        source:setVolume(1)
    end

    for _, source in pairs(gMusic) do
        source:setVolume(.6)
    end

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateStack = StateStack()
    gStateStack:push(StartState())


    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end