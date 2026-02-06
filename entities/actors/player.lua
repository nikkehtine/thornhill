local Entity = require "entities/entity"

local Player = setmetatable({}, { __index = Entity })
Player.__index = Player
-- Doing Rust style inheritance using metatables
-- https://cyevgeniy.github.io/luadocs/02_basic_concepts/ch04.html

function Player:new(x, y)
    local instance = Entity.new(self, x, y)
    instance.speed = 25
    return instance
end

-- The reason we need three separate coordinates is because they all track different things:
--  * x and y are the actual position of the player in the game world
--  * targetX and targetY are the position the player is trying to move to
--  * displayX and displayY are the position the player is currently displayed at on the screen
-- This is needed for smooth sliding animation, and because movement can be interrupted,
-- for example when player activates a trap that leaves them immobilized.

function Player:update(dt)
    local lerpSpeed = self.speed * dt

    self.displayX = self.displayX + (self.targetX - self.displayX) * lerpSpeed
    self.displayY = self.displayY + (self.targetY - self.displayY) * lerpSpeed
end

function Player:draw()
    love.graphics.setColor(0.6, 0.2, 0.25)
    love.graphics.rectangle("fill",
        self.displayX * CELLSIZE,
        self.displayY * CELLSIZE,
        CELLSIZE, CELLSIZE)

    -- love.graphics.draw(self.sprite, self.displayX, self.displayY)
end

return Player
