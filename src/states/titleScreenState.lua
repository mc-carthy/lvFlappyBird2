TitleScreenState = Class{ __includes = BaseState }

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('countdown')
    end
end

function TitleScreenState:draw()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Start!', 0, 100, VIRTUAL_WIDTH, 'center')
end