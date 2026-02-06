local ECS = {}
ECS.__index = ECS

function ECS.new()
    local ecs = setmetatable({}, ECS)
    ecs.nextEntityId = 1
    ecs.entities = {}
    ecs.components = {}
    ecs.systems = {}
    return ecs
end

function ECS:createEntity()
    local id = self.nextEntityId
    self.nextEntityId = self.nextEntityId + 1
    self.entities[id] = true
    return id
end

function ECS:addComponent(entityId, componentType, componentData)
    if not self.entities[entityId] then
        error("Entity" .. entityId .. "does not exist")
    end
    if not self.components[componentType] then
        self.components[componentType] = {}
    end
    self.components[componentType][entityId] = componentData
end

function ECS:getComponent(entityId, componentType)
    if not self.components[componentType] then
        return nil
    end
    return self.components[componentType][entityId]
end

function ECS:hasComponent(entityId, componentType)
    if not self.components[componentType] then
        return false
    end
    return self.components[componentType][entityId] ~= nil
end

return ECS
