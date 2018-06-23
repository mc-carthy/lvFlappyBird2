Bird = Class{}

local g = 20
local jumpSpeed = 5
local collisionPadding = 3

function Bird:init()
    self.image = love.graphics.newImage('src/assets/sprites/bird.png')
    self.w, self.h = self.image:getDimensions()
    self.x = VIRTUAL_WIDTH / 2 - self.w / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.h / 2
    self.dy = 0
end

function Bird:collides(other)
    if 
        self.x + collisionPadding > other.x + other.w or
        self.x + self.w - collisionPadding < other.x or
        self.y + collisionPadding > other.y + other.h or
        self.y + self.h - collisionPadding < other.y
    then 
        return false
    end

    return true
end

function Bird:update(dt)
    self.dy = self.dy + g * dt
    self.y = self.y + self.dy

    if love.keyboard.wasPressed('space') then
        self.dy = -jumpSpeed
        sounds.jump:stop()
        sounds.jump:play()
    end
end

function Bird:draw()
    love.graphics.draw(self.image, self.x, self.y)
end