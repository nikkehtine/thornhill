local player = require "actors/player"

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

    if math.abs(PlayerActor.displayX - PlayerActor.targetX) < 0.0001 then
        PlayerActor.displayX = PlayerActor.targetX
    end
    if math.abs(PlayerActor.displayY - PlayerActor.targetY) < 0.0001 then
        PlayerActor.displayY = PlayerActor.targetY
    end
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
    love.graphics.setColor(0.4, 0.1, 0.15)
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
        moveActor(PlayerActor, 0, -1)
    elseif key == "s" or key == "down" then
        moveActor(PlayerActor, 0, 1)
    elseif key == "a" or key == "left" then
        moveActor(PlayerActor, -1, 0)
    elseif key == "d" or key == "right" then
        moveActor(PlayerActor, 1, 0)
    elseif key == "space" then
        moveActor(PlayerActor, 2, 3)
    end
end

function moveActor(actor, x, y)
    local newX = actor.targetX + x
    local newY = actor.targetY + y
    -- Boundary checks
    if newX >= 0 and newX < GRIDSIZE.width and
        newY >= 0 and newY < GRIDSIZE.height then
        actor.targetX = newX
        actor.targetY = newY
    end
end
