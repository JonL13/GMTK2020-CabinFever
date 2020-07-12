Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
sti = require "lib/sti"
--camera = require "lib/camera"
gamera = require "lib/gamera"

require 'src/Constants'

require 'src/data/entity_data'
require 'src/data/maps/cabin_map'

require 'src/statemachine/BaseState'
require 'src/statemachine/StateMachine'
require 'src/statemachine/StateStack'
require 'src/statemachine/entity/EntityIdleState'
require 'src/statemachine/entity/EntityWalkState'
require 'src/statemachine/entity/player/PlayerIdleState'
require 'src/statemachine/entity/player/PlayerWalkState'

require 'src/statemachine/game/StartState'
require 'src/statemachine/game/PlayState'

require 'src/util/DebugUtil'
require 'src/util/GraphicsUtil'
require 'src/util/TileUtil'

require 'src/world/Cabin'
require 'src/world/Tile'
require 'src/world/TileMap'

require 'src/Animation'
require 'src/Entity'
require 'src/Player'

gTextures = {
    ['title-background'] = love.graphics.newImage('graphics/mountain.png'),
    ['sprites'] = love.graphics.newImage('graphics/sprites.png'),
    ['tilesheet'] = love.graphics.newImage('graphics/HorrorHouse.png'),
}

gFrames = {
    ['sprites'] = GenerateQuads(gTextures['sprites'], 16, 16),
    ['tilesheet'] = GenerateQuads(gTextures['tilesheet'], 16, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
}

gMusic = {
    ['intro-music'] = love.audio.newSource('sounds/music/cabin-fever-main-theme.wav', 'stream'),
}