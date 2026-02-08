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

        love.graphics.setColor(color.red, color.green, color.blue, color.alpha)
        love.graphics.rectangle("fill",
            position.x * CELLSIZE,
            position.y * CELLSIZE,
            CELLSIZE, CELLSIZE)
    end
end

return RenderSystem
