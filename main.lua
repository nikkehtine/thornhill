local ECS = require "ecs/ecs"
local helpers = require "scripts/helpers"

local RenderSystem = require "systems/render_system"

local Components = require "components/_types"
local Health = require "components/health"
local Name = require "components/name"
local PlayerControlled = require "components/player_controlled"
local Position = require "components/position"
local Renderable = require "components/renderable"
local TurnCounter = require "components/game_controllers/turn_counter"


--- Size of cells in pixels
CELLSIZE = 32
-- Size of the playable grid
GRIDSIZE = {
    width = 40,
    height = 23
}
Debug = false
IsRunning = true
-- Slide speed of entity movement
SlideSpeed = 12

function love.load()
    GameFont = love.graphics.newFont(
        "assets/fonts/Germania_One/GermaniaOne-Regular.ttf",
        16)
    love.graphics.print("Hello World!", 100, 100)

    World = ECS.new()

    TurnManager = World:createEntity()
    World:addComponent(TurnManager, Components.TurnCounter, TurnCounter(1))
    World:printEntityDebugInfo(TurnManager)

    Player = World:createEntity()
    World:addComponent(Player, Components.Name, Name("Jacques"))
    World:addComponent(Player, Components.Position, Position(20, 11))
    World:addComponent(Player, Components.Health, Health(15))
    World:addComponent(Player, Components.Renderable, Renderable(0.6, 0.2, 0.25))
    World:addComponent(Player, Components.PlayerControlled, PlayerControlled(1))
    World:printEntityDebugInfo(Player)

    for i = 1, 5 do
        local Boulder = World:createEntity()
        World:addComponent(Boulder, Components.Name, Name("Rock"))
        World:addComponent(Boulder, Components.Position,
            Position(love.math.random(GRIDSIZE.width), love.math.random(GRIDSIZE.height)))
        World:addComponent(Boulder, Components.Renderable, Renderable(0.6, 0.6, 0.6))
        World:printEntityDebugInfo(Boulder)
    end

    for i = 1, 5 do
        local Goblin = World:createEntity()
        World:addComponent(Goblin, Components.Name, Name("Goblin #" .. i))
        World:addComponent(Goblin, Components.Position,
            Position(love.math.random(GRIDSIZE.width), love.math.random(GRIDSIZE.height - 1)))
        World:addComponent(Goblin, Components.Health, Health(5))
        World:addComponent(Goblin, Components.Renderable, Renderable(0.2, 0.6, 0.3))
        World:printEntityDebugInfo(Goblin)
    end
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

    RenderSystem.draw(World)
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
