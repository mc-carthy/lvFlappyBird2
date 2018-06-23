CountdownState = Class{ __includes = BaseState }

COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count < 0 then
            stateMachine:change('play')
        end
    end
end

function CountdownState:draw()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
end