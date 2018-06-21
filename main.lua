require('src.utils.debug')
Push = require('src.lib.push')
Class = require('src.lib.class')
require('src.entities.bird')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('src/assets/sprites/background.png')
local backgroundScroll = 0
local BACKGROUND_SPEED = 30
local BACKGROUND_LOOP = 413

local ground = love.graphics.newImage('src/assets/sprites/ground.png')
local groundScroll = 0
local GROUND_SPEED = 60

local bird

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy Bird')

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    bird = Bird()

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
    bird:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    bird:draw()
    
    Push:finish()
end