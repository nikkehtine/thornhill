return function(current, max, temp)
    max = max or 18
    return {
        current = current or max,
        max = max,
        temp = temp or 0
    }
end
