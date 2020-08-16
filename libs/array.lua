Array = {buffer = {}};

function Array:new (o, ...)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    self.buffer = ... or {};
    return o;

end

-- Slices a chunk out of the Arraya
function Array:slice(start, finish)
    if start == nil then 
        start = 0; 
    elseif start < 0 then 
        start = (#self.buffer - math.abs(start)); 
    elseif start > #self.buffer then 
        return {}; 
    end
    if finish > #self.buffer or finish == nil then finish = #self.buffer; end

    local temp = {};
    for i=start, i <= finish do
        table.insert(temp, self.buffer[i]);
    end

    self.buffer = temp;
end

-- Remove last element
function Array:pop()
    self:slice(1, (#self.buffer - 1));
end
-- Remove first element and return it
function Array:shift()
    local temp = self.buffer[0];
    self:slice(2, #self.buffer);
    return temp;
end
-- Add elements to front
function Array:unshift(...)
    local temp = {};

    for k,v in pairs(...) do
        table.insert(temp, k, v);
    end
    local offset = k;

    for k,v in pairs(self.buffer) do
        table.insert(temp, (offset+k), v);
    end

    self.buffer = temp;
end