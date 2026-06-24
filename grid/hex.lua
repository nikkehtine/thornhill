---@class Hex
---@field q integer
---@field r integer
---@field s integer
Hex = { q = 0, r = 0, s = 0 }
Hex.__index = Hex

---Creates a new hex with given coordinates
---@param q integer
---@param r integer
---@return Hex
function Hex.new(q, r)
    local hex = setmetatable({}, Hex)

    hex.q = q
    hex.r = r
    hex.s = -q - r

    assert(hex.q + hex.r + hex.s == 0, "q + r + s must be 0")

    return hex
end

-- Equality

---@param a Hex
---@param b Hex
---@return boolean
function Hex.equals(a, b)
    return a.q == b.q and a.r == b.r
end

-- Coordinate arithmetic

---@param a Hex
---@param b Hex
---@return Hex
function Hex.add(a, b)
    return Hex.new(a.q + b.q, a.r + b.r)
end

---@param a Hex
---@param b Hex
---@return Hex
function Hex.subtract(a, b)
    return Hex.new(a.q - b.q, a.r - b.r)
end

---@param a Hex
---@param b integer
---@return Hex
function Hex.multiply(a, b)
    return Hex.new(a.q * b, a.r * b)
end

---@param a Hex
---@param b integer
---@return Hex
function Hex.divide(a, b)
    return Hex.new(a.q / b, a.r / b)
end

-- Distance

---@param hex Hex
---@return integer
function Hex.length(hex)
    return math.floor(
        (math.abs(hex.q) + math.abs(hex.r) + math.abs(hex.s)) / 2
    )
end

---@param a Hex
---@param b Hex
---@return integer
function Hex.distance(a, b)
    return Hex.length(Hex.subtract(a, b))
end

-- Neighbors

---@type Hex[]
local neighborDirections = {
    Hex.new(1, 0),
    Hex.new(1, -1),
    Hex.new(0, -1),
    Hex.new(-1, 0),
    Hex.new(-1, 1),
    Hex.new(0, 1),
}

---@param direction integer
---@return Hex
function Hex.direction(direction)
    assert(direction >= 1 and direction <= 6,
        "direction must be between 1 and 6 (inclusive)")
    return neighborDirections[direction]
end

---@param hex Hex
---@param direction integer
---@return Hex
function Hex.neighbor(hex, direction)
    return Hex.add(hex, Hex.direction(direction))
end
