local Helpers = {}

---Round a number to nearest integer
---@param number number
---@return integer
function Helpers.round(number)
    return math.floor(number + 0.5)
end

function Helpers.reverseLookup(t, value)
    for k, v in pairs(t) do
        if v == value then
            return k
        end
    end
    return nil
end

return Helpers
