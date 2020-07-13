Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
gamera = require "lib/gamera"

require 'src/Constants'

require 'src/data/entity_data'
require 'src/data/maps/cabin_map'

require 'src/gui/Panel'
require 'src/gui/ProgressBar'
require 'src/gui/TextBox'

require 'src/statemachine/BaseState'
require 'src/statemachine/StateMachine'
require 'src/statemachine/StateStack'

require 'src/statemachine/entity/EntityIdleState'
require 'src/statemachine/entity/EntityWalkState'
require 'src/statemachine/entity/player/PlayerAttackState'
require 'src/statemachine/entity/player/PlayerCrazyState'
require 'src/statemachine/entity/player/PlayerIdleState'
require 'src/statemachine/entity/player/PlayerWalkState'
require 'src/statemachine/entity/zombie/ZombieIdleState'
require 'src/statemachine/entity/zombie/ZombieWalkState'

require 'src/statemachine/game/MessageState'
require 'src/statemachine/game/PlayState'
require 'src/statemachine/game/StartState'

require 'src/util/DebugUtil'
require 'src/util/GraphicsUtil'
require 'src/util/TileUtil'

require 'src/world/Cabin'
require 'src/world/Tile'
require 'src/world/TileMap'

require 'src/Animation'
require 'src/Entity'
require 'src/Hitbox'
require 'src/Player'
require 'src/Zombie'

gTextures = {
    ['title-background'] = love.graphics.newImage('graphics/mountain.png'),
    ['sprites'] = love.graphics.newImage('graphics/sprites.png'),
    ['tilesheet'] = love.graphics.newImage('graphics/HorrorHouse.png'),
    ['smoke-effect'] = love.graphics.newImage('graphics/smoke-effect.png'),
}

gFrames = {
    ['sprites'] = GenerateQuads(gTextures['sprites'], 16, 16),
    ['tilesheet'] = GenerateQuads(gTextures['tilesheet'], 16, 16),
    ['smoke-effect'] = GenerateQuads(gTextures['smoke-effect'], 16, 16),
}

gImageData = {
    ['cabin-fever-icon'] = love.image.newImageData('graphics/cabin-fever-icon.png'),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
}

gMusic = {
    ['intro-music'] = love.audio.newSource('sounds/music/intro-theme.wav', 'stream'),
    ['main-music'] = love.audio.newSource('sounds/music/cabin-fever-main-theme.wav', 'stream'),
    ['fever-rising-music'] = love.audio.newSource('sounds/music/fever-rising.wav', 'stream'),
}

gSoundEffects = {
    ['hit'] = love.audio.newSource('sounds/soundeffects/thud.wav', 'static'),
    ['player-attacked'] = love.audio.newSource('sounds/soundeffects/player-attacked-male.wav', 'static'),
    ['zombiegrunt1'] = love.audio.newSource('sounds/soundeffects/ZombieGrunts1.wav', 'static'),
    ['zombiegrunt2'] = love.audio.newSource('sounds/soundeffects/ZombieGrunts2.wav', 'static'),
    ['zombiegrunt3'] = love.audio.newSource('sounds/soundeffects/ZombieGrunts3.wav', 'static'),
    ['zombiegrunt4'] = love.audio.newSource('sounds/soundeffects/ZombieGrunts4.wav', 'static'),
    ['zombiegrunt5'] = love.audio.newSource('sounds/soundeffects/ZombieGrunts5.wav', 'static'),
}