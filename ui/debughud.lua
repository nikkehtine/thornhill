local DebugHUD = {}

function DebugHUD.draw()
    love.graphics.setColor(0, 0.4, 0.4, 0.5)
    love.graphics.rectangle("fill", 0, 0, 200, 100)
    love.graphics.setColor(0.9, 0.9, 0.9, 1)

    -- PlayerActor position
    love.graphics.print("PlayerActor Position:", 6, 4)
    love.graphics.print("Real: (" .. PlayerActor.x .. ", " .. PlayerActor.y .. ")", 24, 20)
    love.graphics.print("Target: (" .. PlayerActor.targetX .. ", " .. PlayerActor.targetY .. ")", 24, 36)
    love.graphics.print(
        "Display: (" .. string.format("%.2f", PlayerActor.displayX) ..
        ", " .. string.format("%.2f", PlayerActor.displayY) .. ")", 24, 52)

    -- TurnCounter
    love.graphics.print("TurnCounter:", 6, 68)
    love.graphics.print("Turn: " .. TurnCounter.turn, 24, 84)
end

return DebugHUD
