local TurnCounter = {}
TurnCounter.__index = TurnCounter

function TurnCounter:new()
    local self = setmetatable(self, TurnCounter)
    self.turn = 0
    return self
end

function TurnCounter:start()
    self.turn = 1
end

function TurnCounter:nextTurn()
    self.turn = self.turn + 1
end

return TurnCounter
