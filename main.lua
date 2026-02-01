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

    Player = {
        x = 12,
        y = 9,
    }
    Player.targetX = Player.x
    Player.targetY = Player.y
    Player.displayX = Player.x
    Player.displayY = Player.y

    -- Slide speed of entity movement
    SlideSpeed = 8

    love.window.setTitle(TITLE)
end

function love.update(dt)
    local lerpSpeed = SlideSpeed * dt

    Player.displayX = Player.displayX + (Player.targetX - Player.displayX) * lerpSpeed
    Player.displayY = Player.displayY + (Player.targetY - Player.displayY) * lerpSpeed

    if math.abs(Player.displayX - Player.targetX) < 1 then
        Player.x = Player.targetX
    end
    if math.abs(Player.displayY - Player.targetY) < 1 then
        Player.y = Player.targetY
    end

    Player.x = Player.x + lerpSpeed
    Player.y = Player.y + lerpSpeed
end

function love.draw()
    love.graphics.clear()

    -- Grid
    love.graphics.setColor(0, 0.4, 0.4)
    for x = 0, GRIDSIZE.width do
        love.graphics.line(x * CELLSIZE, 0, x * CELLSIZE, GRIDSIZE.height * CELLSIZE)
    end
    for y = 0, GRIDSIZE.height do
        love.graphics.line(0, y * CELLSIZE, GRIDSIZE.width * CELLSIZE, y * CELLSIZE)
    end

    -- Player
    love.graphics.setColor(0.4, 0.1, 0.15)
    love.graphics.rectangle("fill", Player.displayX * CELLSIZE, Player.displayY * CELLSIZE, CELLSIZE, CELLSIZE)

    -- HUD
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.print("Hello, World!", 360, 300)
end
