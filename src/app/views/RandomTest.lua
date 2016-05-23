local Random = require "app.utils.Random"
local RandomTest = class("RandomTest", cc.load("mvc").ViewBase)
function RandomTest:onCreate()
	for i = 1, 10 do
		release_print(Random:randrange(1, 30, 3))
	end

	local tb = {1,2,3,4,5,6}
	Random:shuffle(tb)
	release_print(table.concat(tb, ", "))
	release_print(Random:boolean())
	for i = 1, 10 do
		release_print(table.concat(Random:sample(tb, 4), ", "))
	end
end
return RandomTest