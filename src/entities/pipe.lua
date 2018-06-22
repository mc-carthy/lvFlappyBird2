Pipe = Class{}

PIPE_HEIGHT = 288
PIPE_WIDTH = 70
local PIPE_IMAGE = love.graphics.newImage('src/assets/sprites/pipe.png')

function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y
    self.orientation = orientation
end

function Pipe:update(dt)
end

function Pipe:draw()
    love.graphics.draw(
        PIPE_IMAGE, 
        self.x, 
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
        0,
        1,
        (self.orientation == 'top' and -1 or 1)
    )
end