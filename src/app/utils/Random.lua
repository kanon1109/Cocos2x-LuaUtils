local Random = class("Random")
--在 start 与 stop之间取一个随机整数，可以用step指定间隔， 但不包括较大的端点（start与stop较大的一个）
--Random.randrange(1, 10, 3) 
--则返回的可能是   1 或  4 或  7  , 注意 这里面不会返回10，因为是10是大端点 
function Random:randrange(start, stop, step)
	if step == 0 then
		return 0
	end
	local width = stop - start
	if width == 0 then
		return 0
	end
	if width < 0 then
		width = start - stop
	end
	local n = math.floor((width + step - 1) / step)
    return math.floor(math.random() * n) * step + math.min(start, stop)
end

--打乱数组
function Random:shuffle(array)
    local counter = #array
    while counter > 1 do
        local index = math.random(counter)
        array[index], array[counter] = array[counter], array[index]
        counter = counter - 1
    end
end

--概率
function Random:boolean(chance)
	chance = chance or 0.5
	return (math.random() < chance) 
end

--随机采样
--tb 数组
--采样数量
function Random:sample(tb, num)
	local len = table.nums(tb)
	if num <= 0 or len < num then
		return
	end
	local selected = {}
	local indices = {}
	for i = 1, num do
		local index = math.random(1, len)
		while table.indexof(indices, index, 1) ~= false do
			index = math.random(1, len)
		end
		selected[i] = tb[index]
		indices[i] = index
	end
    return selected;
end

return Random