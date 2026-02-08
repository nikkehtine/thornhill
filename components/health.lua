---Set entity's health.
---You can specify one parameter for same max and current HP.
---@param max number
---@param current number?
---@param temp number?
return function(max, current, temp)
    return {
        max = max,
        current = current or max,
        temp = temp or 0
    }
end
