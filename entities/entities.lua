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

function EntityHelpers.moveAndSlide(entity, lerpSpeed)
    entity.displayX = entity.displayX + (entity.targetX - entity.displayX) * lerpSpeed
    entity.displayY = entity.displayY + (entity.targetY - entity.displayY) * lerpSpeed

    -- Snap to target
    if math.abs(entity.targetX - entity.displayX) < 0.01 and
        math.abs(entity.targetY - entity.displayY) < 0.01 then
        entity.displayX = entity.targetX
        entity.displayY = entity.targetY
    end
end

return EntityHelpers
