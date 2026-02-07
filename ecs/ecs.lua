local Components = require "components/_types"
local Helpers = require "scripts/helpers"

local ECS = {}
ECS.__index = ECS

---Create an ECS instance
---@return table
function ECS.new()
    local ecs = setmetatable({}, ECS)
    ecs.entityCount = 0
    ecs.nextEntityId = 1
    ecs.entities = {}
    ecs.components = {}
    ecs.systems = {}
    return ecs
end

---Create a new entity
---@return EntityId
function ECS:createEntity()
    local id = self.nextEntityId
    self.nextEntityId = self.nextEntityId + 1
    self.entityCount = self.entityCount + 1
    self.entities[id] = true
    return id
end

---Destroy an entity
---@param entity EntityId
---@return boolean
function ECS:destroyEntity(entity)
    if not self.entities[entity] then
        error("Entity" .. entity .. "does not exist")
        return false
    end
    for componentType, _ in pairs(self.components) do
        self.components[componentType][entity] = nil
    end
    self.entities[entity] = nil
    self.entityCount = self.entityCount - 1
    return true
end

---Check if an entity exists
---@param entity EntityId
---@return boolean
function ECS:isEntityValid(entity)
    return self.entities[entity] ~= nil
end

---Add a component to an entity
---@param entity EntityId
---@param componentType ComponentType
---@param componentData any
function ECS:addComponent(entity, componentType, componentData)
    if not self.entities[entity] then
        error("Entity" .. entity .. "does not exist")
    end

    if not self.components[componentType] then
        self.components[componentType] = {}
    end

    self.components[componentType][entity] = componentData
end

---Get the data of a component from an entity
---@param entity EntityId
---@param componentType ComponentType
---@return any|nil
function ECS:getComponent(entity, componentType)
    if not self.components[componentType] then
        return nil
    end

    return self.components[componentType][entity]
end

---Get all components of an entity
---@param entity EntityId
---@return table<ComponentType>
function ECS:getAllComponents(entity)
    if not self.entities[entity] then
        error("Entity" .. entity .. "does not exist")
        return {}
    end

    local components = {}

    for componentType, _ in pairs(self.components) do
        local component = self:getComponent(entity, componentType)
        if component then
            table.insert(components, component)
        end
    end

    return components
end

---Check if an entity has a component
---@param entity EntityId
---@param componentType ComponentType
---@return boolean
function ECS:hasComponent(entity, componentType)
    if not self.components[componentType] then
        return false
    end
    return self.components[componentType][entity] ~= nil
end

---Check how many entities have a given component
---@param componentType ComponentType
---@return number
function ECS:getComponentCount(componentType)
    if not self.components[componentType] then
        return 0
    end

    local count = 0
    for _ in pairs(self.components[componentType]) do
        count = count + 1
    end
    return count
end

---Remove a component from an entity
---@param entity EntityId
---@param componentType ComponentType
---@return boolean result Whether the operation was successful
function ECS:removeComponent(entity, componentType)
    if not self.entities[entity] then
        error("Entity" .. entity .. "does not exist")
        return false
    end

    if not self.components[componentType] then
        return false
    end

    local hadComponent = self.components[componentType][entity] ~= nil
    self.components[componentType][entity] = nil

    return hadComponent
end

---Get an entity's debug information
---@param entity EntityId
---@return nil
function ECS:printEntityDebugInfo(entity)
    if not self.entities[entity] then
        error("Entity" .. entity .. "does not exist")
    end

    print("Entity #" .. entity)
    for componentType, _ in pairs(self.components) do
        if self:hasComponent(entity, componentType) then
            print("  " .. Helpers.reverseLookup(Components, componentType) .. ":")
            for key, value in pairs(self.components[componentType][entity]) do
                print("    " .. key .. ": " .. tostring(value))
            end
        end
    end
end

---Query entities with specific components
---@vararg ComponentType
---@return table<EntityId>
function ECS:query(...)
    local componentTypes = { ... }
    local results = {}

    for entityId in pairs(self.entities) do
        local hasAll = true

        for _, componentType in pairs(componentTypes) do
            if not self:hasComponent(entityId, componentType) then
                hasAll = false
                break
            end
        end

        if hasAll then
            table.insert(results, entityId)
        end
    end

    return results
end

---Query a single entity
---You should use this for singletons, i.e. TurnCounter, because it stops querying after finding the first match
---@vararg ComponentType
---@return EntityId|nil
function ECS:querySingle(...)
    local componentTypes = { ... }

    for entityId in pairs(self.entities) do
        local hasAll = true

        for _, componentType in pairs(componentTypes) do
            if not self:hasComponent(entityId, componentType) then
                hasAll = false
                break
            end
        end

        if hasAll then
            return entityId
        end
    end

    return nil
end

return ECS
