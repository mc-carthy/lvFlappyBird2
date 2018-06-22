-- require('src.utils.debug')
Push = require('src.lib.push')
Class = require('src.lib.class')
require('src.entities.bird')
require('src.entities.pipe')
require('src.entities.pipePair')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GROUND_HEIGHT = 16

local background = love.graphics.newImage('src/assets/sprites/background.png')
local backgroundScroll = 0
local BACKGROUND_SPEED = 30
local BACKGROUND_LOOP = 413

local ground = love.graphics.newImage('src/assets/sprites/ground.png')
local groundScroll = 0
GROUND_SPEED = 100

local bird
local pipePairs = {}
local spawnTimer = 0
local spawnPeriod = 2
local lastY = -PIPE_HEIGHT + math.random(80) + GROUND_HEIGHT

function love.load()
    math.randomseed(os.time())
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
    
    spawnTimer = spawnTimer + dt
    if spawnTimer > 2 then
        local y = math.max(
            -PIPE_HEIGHT + GROUND_HEIGHT,
            math.min(
                lastY + math.random(-20, 20),
                VIRTUAL_HEIGHT - (GROUND_HEIGHT + PIPE_HEIGHT)
            )
        )

        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end
    
    for k, pipePair in pairs(pipePairs) do
        pipePair:update(dt)
        
        if pipePair.x < -PIPE_WIDTH then
            table.remove(pipePair, k)
        end
    end
    
    bird:update(dt)
    
    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    
    for _, pipePair in pairs(pipePairs) do
        pipePair:draw()
    end
    
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - GROUND_HEIGHT)

    bird:draw()
    
    Push:finish()
end