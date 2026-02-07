local ECS = require "ecs/ecs"
local helpers = require "scripts/helpers"

local Components = require "components/_types"
local Position = require "components/position"
local Health = require "components/health"
local PlayerControlled = require "components/player_controlled"
local TurnCounter = require "components/game_controllers/turn_counter"

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
    TurnManager = World:createEntity()
    World:addComponent(TurnManager, Components.TurnCounter, TurnCounter(1))

    Player = World:createEntity()
    World:addComponent(Player, Components.Position, Position(8, 12))
    World:addComponent(Player, Components.Health, Health(15))
    World:addComponent(Player, Components.PlayerControlled, PlayerControlled())

    Boulder = World:createEntity()
    World:addComponent(Boulder, Components.Position, Position(10, 10))

    Creature = World:createEntity()
    World:addComponent(Creature, Components.Position, Position(5, 5))
    World:addComponent(Creature, Components.Health, Health(5))

    -- Print debug information for each entity using World:printEntityDebugInfo()
    World:printEntityDebugInfo(Player)
    World:printEntityDebugInfo(Boulder)
    World:printEntityDebugInfo(Creature)
    World:printEntityDebugInfo(TurnManager)
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
