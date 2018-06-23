PlayScreenState = Class{ __includes = BaseState }

local bird
local pipePairs = {}
local spawnTimer = 0
local spawnPeriod = 2
local lastY = -PIPE_HEIGHT + math.random(80) + GROUND_HEIGHT

function PlayScreenState:init()
    bird = Bird()
end

function PlayScreenState:update(dt)
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
        
        for _, pipe in pairs(pipePair.pipes) do
            if bird:collides(pipe) then
                stateMachine:change('title')
            end
        end

        if pipePair.x < -PIPE_WIDTH then
            table.remove(pipePair, k)
        end
    end

    if bird.y > VIRTUAL_HEIGHT - GROUND_HEIGHT then
        stateMachine:change('title')
    end
    
    bird:update(dt)
end

function PlayScreenState:draw()
    for _, pipePair in pairs(pipePairs) do
        pipePair:draw()
    end

    bird:draw()
end