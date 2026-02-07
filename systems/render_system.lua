local Components = require "components/_types"

local RenderSystem = {}

function RenderSystem.update(ECS)
    local entities = ECS:query({ Components.Position })

    for _, entity in ipairs(entities) do
        local position = ECS:getComponent(entity, Components.Position)
        print("Rendering entity at position:", position.x, position.y)

        love.graphics.circle("fill", position.x, position.y, 5)
    end
end
