local helpers = require "scripts/helpers"
local player = require "entities/actors/player"
local turncounter = require "mechanics/turncounter"
local debughud = require "ui/debughud"

function love.load()
    -- Size of cells in pixels
    CELLSIZE = 32
    -- Size of the playable grid
    GRIDSIZE = {
        width = 25,
        height = 20
    }

    Debug = false

    PlayerActor = player:new(12, 9)

    TurnCounter = turncounter:new()
    TurnCounter:start()

    -- Slide speed of entity movement
    SlideSpeed = 12
end

function love.update(dt)
    local lerpSpeed = SlideSpeed * dt

    PlayerActor:moveAndSlide(lerpSpeed)

    PlayerActor.x = helpers.round(PlayerActor.displayX)
    PlayerActor.y = helpers.round(PlayerActor.displayY)
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

    PlayerActor:draw()

    if Debug then
        debughud.draw()
    end
end

function love.keypressed(key, scancode, isRepeat)
    if key == "escape" then
        love.event.quit()
    elseif key == "w" or key == "up" then
        PlayerActor:move(0, -1)
    elseif key == "s" or key == "down" then
        PlayerActor:move(0, 1)
    elseif key == "a" or key == "left" then
        PlayerActor:move(-1, 0)
    elseif key == "d" or key == "right" then
        PlayerActor:move(1, 0)
    elseif key == "space" then
        turncounter:nextTurn()
    elseif key == "f3" then
        Debug = not Debug
    end
end
