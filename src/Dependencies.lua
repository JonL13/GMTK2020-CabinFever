Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'

require 'src/statemachine/BaseState'
require 'src/statemachine/StateMachine'
require 'src/statemachine/game/StartState'

gTextures = {
    ['title-background'] = love.graphics.newImage('graphics/mountain.png')
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    --['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    --['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32)
}