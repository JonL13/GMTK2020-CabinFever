Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
sti = require "lib/sti"


require 'src/Constants'

require 'src/statemachine/BaseState'
require 'src/statemachine/StateMachine'
require 'src/statemachine/StateStack'
require 'src/statemachine/game/StartState'
require 'src/statemachine/game/PlayState'

require 'src/util/DebugUtil'
require 'src/util/GraphicsUtil'

require 'src/world/House'
require 'src/world/Tile'
require 'src/world/TileConstants'
require 'src/world/TileMap'


gTextures = {
    ['title-background'] = love.graphics.newImage('graphics/mountain.png'),
}

gFrames = {
    --['horrorHouse'] = GenerateQuads(gTextures['horrorHouse'], 16, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
}