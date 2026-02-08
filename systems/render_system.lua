local Components = require "components/_types"

local RenderSystem = {}

local showedWarning = false

function RenderSystem.draw(world)
    local entities = world:query(Components.Renderable, Components.Position)

    if #entities == 0 and not showedWarning then
        print("No renderable entities found!")
        showedWarning = true
    end

    for _, entity in pairs(entities) do
        local position = world:getComponent(entity, Components.Position)
        local color = world:getComponent(entity, Components.Renderable)
        local name = world:getComponent(entity, Components.Name)

        local pixelX = position.x * CELLSIZE
        local pixelY = position.y * CELLSIZE

        love.graphics.setColor(color.red, color.green, color.blue, color.alpha)
        love.graphics.rectangle("fill",
            pixelX, pixelY, CELLSIZE, CELLSIZE)

        if name then
            local textWidth = love.graphics.getFont():getWidth(name)
            local textHeight = love.graphics.getFont():getHeight(name)

            local centeredX = pixelX + (CELLSIZE - textWidth) / 2
            local centeredY = pixelY + (CELLSIZE - textHeight) / 2

            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(GameFont)
            love.graphics.print(name, centeredX, centeredY)
        end
    end
end

return RenderSystem
