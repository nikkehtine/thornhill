local EntityHelpers = {}

function EntityHelpers.moveActor(actor, x, y)
    local newX = actor.targetX + x
    local newY = actor.targetY + y
    -- Boundary checks
    if newX >= 0 and newX < GRIDSIZE.width and
        newY >= 0 and newY < GRIDSIZE.height then
        actor.targetX = newX
        actor.targetY = newY
    end
end

return EntityHelpers
