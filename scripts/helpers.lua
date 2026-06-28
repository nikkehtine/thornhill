---Round a number to nearest integer
---@param number number
---@return integer
function Round(number)
    return math.floor(number + 0.5)
end

---Reverse lookup a value in a table
---@param t table
---@param value unknown
---@return unknown
function ReverseLookup(t, value)
    for k, v in pairs(t) do
        if v == value then
            return k
        end
    end
    return nil
end
