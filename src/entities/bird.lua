Bird = Class{}

local g = 10

function Bird:init()
    self.image = love.graphics.newImage('src/assets/sprites/bird.png')
    self.width, self.height = self.image:getDimensions()
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + g * dt
    self.y = self.y + self.dy
end

function Bird:draw()
    love.graphics.draw(self.image, self.x, self.y)
end