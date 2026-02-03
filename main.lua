local player = require "actors/player"
local helpers = require "helpers"

function love.load()
    -- Name of the game
    TITLE = "Thornhill"
    -- Size of cells in pixels
    CELLSIZE = 32
    -- Size of the playable grid
    GRIDSIZE = {
        width = 25,
        height = 20
    }

    PlayerActor = player:new(12, 9)

    -- Slide speed of entity movement
    SlideSpeed = 12

    love.window.setTitle(TITLE)
end

function love.update(dt)
    local lerpSpeed = SlideSpeed * dt

    PlayerActor.displayX = PlayerActor.displayX + (PlayerActor.targetX - PlayerActor.displayX) * lerpSpeed
    PlayerActor.displayY = PlayerActor.displayY + (PlayerActor.targetY - PlayerActor.displayY) * lerpSpeed

    if math.abs(PlayerActor.displayX - PlayerActor.targetX) < 0.001 then
        PlayerActor.displayX = PlayerActor.targetX
    end
    if math.abs(PlayerActor.displayY - PlayerActor.targetY) < 0.001 then
        PlayerActor.displayY = PlayerActor.targetY
    end

    -- if PlayerActor.displayX == PlayerActor.targetX and
    --     PlayerActor.displayY == PlayerActor.targetY
    -- then
    --     PlayerActor.x = PlayerActor.targetX
    --     PlayerActor.y = PlayerActor.targetY
    -- end
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

    -- PlayerActor
    love.graphics.setColor(0.6, 0.2, 0.25)
    love.graphics.rectangle("fill",
        PlayerActor.displayX * CELLSIZE,
        PlayerActor.displayY * CELLSIZE,
        CELLSIZE, CELLSIZE)

    -- HUD
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.print("Hello, World!", 360, 300)

    -- Debug HUD
    love.graphics.setColor(0, 0.4, 0.4, 0.5)
    love.graphics.rectangle("fill", 0, 0, 200, 100)
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    -- PlayerActor position
    love.graphics.print("PlayerActor Position:", 6, 4)
    love.graphics.print("Real: (" .. PlayerActor.x .. ", " .. PlayerActor.y .. ")", 24, 20)
    love.graphics.print("Target: (" .. PlayerActor.targetX .. ", " .. PlayerActor.targetY .. ")", 24, 36)
    love.graphics.print("Display: (" .. PlayerActor.displayX .. ", " .. PlayerActor.displayY .. ")", 24, 52)
end

function love.keypressed(key, scancode, isRepeat)
    if key == "escape" then
        love.event.quit()
    elseif key == "w" or key == "up" then
        helpers.moveActor(PlayerActor, 0, -1)
    elseif key == "s" or key == "down" then
        helpers.moveActor(PlayerActor, 0, 1)
    elseif key == "a" or key == "left" then
        helpers.moveActor(PlayerActor, -1, 0)
    elseif key == "d" or key == "right" then
        helpers.moveActor(PlayerActor, 1, 0)
    elseif key == "space" then
        helpers.moveActor(PlayerActor, 2, 3)
    end
end
