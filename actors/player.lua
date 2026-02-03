local Player = {}

function Player:new(x, y)
    local self = {
        x = x,
        y = y,
        targetX = x,
        targetY = y,
        displayX = x,
        displayY = y,
        speed = 25,
    }
    return self
end

function Player:update(dt)
    local lerpSpeed = self.speed * dt

    self.displayX = self.displayX + (self.targetX - self.displayX) * lerpSpeed
    self.displayY = self.displayY + (self.targetY - self.displayY) * lerpSpeed
end

function Player:draw()
    love.graphics.setColor(0.4, 0.1, 0.15)
    love.graphics.rectangle("fill",
        self.displayX * CELLSIZE,
        self.displayY * CELLSIZE,
        CELLSIZE, CELLSIZE)

    -- love.graphics.draw(self.sprite, self.displayX, self.displayY)
end

return Player
