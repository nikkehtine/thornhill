local ECS = require "ecs/ecs"
local Position = require "components/position"
local Health = require "components/health"
local ComponentsType = require "components/_types"
local helpers = require "scripts/helpers"

local World = ECS.new()

--- Size of cells in pixels
CELLSIZE = 32
-- Size of the playable grid
GRIDSIZE = {
    width = 25,
    height = 20
}
Debug = false
IsRunning = true
-- Slide speed of entity movement
SlideSpeed = 12

function love.load()
    Creature = World:createEntity()
    World:addComponent(Creature, ComponentsType.Position, Position(5, 5))
    print("Added creature with ID", Creature)
end

function love.update(dt)
    local lerpSpeed = SlideSpeed * dt
end

function love.draw()
    love.graphics.clear()

    -- Grid
    love.graphics.setColor(0.2, 0.6, 0.5)
    for x = 0, GRIDSIZE.width do
        love.graphics.line(x * CELLSIZE, 0, x * CELLSIZE, GRIDSIZE.height * CELLSIZE)
    end
    for y = 0, GRIDSIZE.height do
        love.graphics.line(0, y * CELLSIZE, GRIDSIZE.width * CELLSIZE, y * CELLSIZE)
    end
end

function love.keypressed(key, scancode, isRepeat)
    if key == "escape" then
        love.event.quit()
        -- elseif key == "w" or key == "up" then
        --     PlayerActor:move(0, -1)
        -- elseif key == "s" or key == "down" then
        --     PlayerActor:move(0, 1)
        -- elseif key == "a" or key == "left" then
        --     PlayerActor:move(-1, 0)
        -- elseif key == "d" or key == "right" then
        --     PlayerActor:move(1, 0)
        -- elseif key == "space" then
        --     turncounter:nextTurn()
    elseif key == "f3" then
        Debug = not Debug
    end
end
