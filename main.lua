WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GROUND_HEIGHT = 16
GROUND_SPEED = 100

-- require('src.utils.debug')
Push = require('src.lib.push')
Class = require('src.lib.class')

require('src.entities.bird')
require('src.entities.pipe')
require('src.entities.pipePair')

require('src.lib.stateMachine')
require('src.states.baseState')
require('src.states.playScreenState')
require('src.states.titleScreenState')
require('src.states.scoreState')
require('src.states.countdownState')


local background = love.graphics.newImage('src/assets/sprites/background.png')
local backgroundScroll = 0
local BACKGROUND_SPEED = 30
local BACKGROUND_LOOP = 413

local ground = love.graphics.newImage('src/assets/sprites/ground.png')
local groundScroll = 0

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy Bird')

    smallFont = love.graphics.newFont('src/assets/fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('src/assets/fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('src/assets/fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('src/assets/fonts/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    stateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayScreenState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end
    }
    stateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SPEED * dt) % BACKGROUND_LOOP
    groundScroll = (groundScroll + GROUND_SPEED * dt) % VIRTUAL_WIDTH

    stateMachine:update(dt)
        
    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    
    stateMachine:draw()
    
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - GROUND_HEIGHT)
    
    Push:finish()
end