local EntityEnum = require "entities/enums"

local Entity = {}
Entity.__index = Entity

function Entity:new(x, y)
    local instance = setmetatable({
        x = x or 0,
        y = y or 0,
        targetX = x or 0,
        targetY = y or 0,
        displayX = x or 0,
        displayY = y or 0,
        isMoving = false,
        speed = 0,
        size = EntityEnum.Size.MEDIUM
    }, self)
    return instance
end

-- Move the entity to a new position (intent)
function Entity:move(x, y)
    if self.isMoving then return end

    local newX = self.targetX + x
    local newY = self.targetY + y

    -- Boundary checks
    if newX >= 0 and newX < GRIDSIZE.width and
        newY >= 0 and newY < GRIDSIZE.height then
        self.targetX = newX
        self.targetY = newY
        self.isMoving = true
    end
end

function Entity:moveAndSlide(lerpSpeed)
    self.displayX = self.displayX + (self.targetX - self.displayX) * lerpSpeed
    self.displayY = self.displayY + (self.targetY - self.displayY) * lerpSpeed

    -- Snap to target
    if math.abs(self.targetX - self.displayX) < 0.01 and
        math.abs(self.targetY - self.displayY) < 0.01 then
        self.displayX = self.targetX
        self.displayY = self.targetY
        self.isMoving = false
    end
end

return Entity
