PlayScreenState = Class{ __includes = BaseState }

local spawnPeriod = 2

function PlayScreenState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(80) + GROUND_HEIGHT
end

function PlayScreenState:update(dt)
    self.timer = self.timer + dt
    if self.timer > 2 then
        local y = math.max(
            -PIPE_HEIGHT + GROUND_HEIGHT,
            math.min(
                self.lastY + math.random(-20, 20),
                VIRTUAL_HEIGHT - (GROUND_HEIGHT + PIPE_HEIGHT)
            )
        )

        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
    end
    
    for k, pipePair in pairs(self.pipePairs) do

        if not pipePair.scored then
            if pipePair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                sounds.score:play()
                pipePair.scored = true
            end
        end

        pipePair:update(dt)
    end

    for k, pipePair in pairs(self.pipePairs) do
        if pipePair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)

    for k, pipePair in pairs(self.pipePairs) do
        for _, pipe in pairs(pipePair.pipes) do
            if self.bird:collides(pipe) then
                sounds.explosion:play()
                sounds.hurt:play()
                stateMachine:change('score', { score = self.score })
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT - GROUND_HEIGHT or self.bird.y < -self.bird.h then
        sounds.explosion:play()
        sounds.hurt:play()
        stateMachine:change('score', { score = self.score })
    end
    
end

function PlayScreenState:draw()
    for _, pipePair in pairs(self.pipePairs) do
        pipePair:draw()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:draw()
end