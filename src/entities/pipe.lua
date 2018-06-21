Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('src/assets/sprites/pipe.png')

function Pipe:init()
    self.width, self.height = PIPE_IMAGE:getDimensions()
    self.x = VIRTUAL_WIDTH
    self.y = VIRTUAL_HEIGHT - (GROUND_HEIGHT + math.random(50, 100))
    self.dy = 0
end

function Pipe:update(dt)
    self.x = self.x - GROUND_SPEED * dt
end

function Pipe:draw()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end