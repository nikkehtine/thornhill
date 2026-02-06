return function(current, max)
    max = max or 18
    return {
        current = current or max,
        max = max
    }
end
