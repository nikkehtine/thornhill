local ECS = require "ecs/ecs"
local helpers = require "scripts/helpers"

-- Components

local Health = require "components/health"
local Name = require "components/name"
local PlayerControlled = require "components/player_controlled"
local Position = require "components/position"
local Renderable = require "components/renderable"
local TurnCounter = require "components/game_controllers/turn_counter"


--- Size of cells in pixels
CELLSIZE = 32

--- Size of the playable grid
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
end

function love.update(dt)
    local lerpSpeed = SlideSpeed * dt
end

function love.draw()
    love.graphics.clear()
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
