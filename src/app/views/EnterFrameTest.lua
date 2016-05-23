local EnterFrame = require "app.utils.EnterFrame"
local EnterFrameTest = class("EnterFrameTest", cc.load("mvc").ViewBase)
local x = 1
local pause = false
function EnterFrameTest:onCreate()
	release_print("onCreate", type(self))
	-- body
	EnterFrame:init(24)
	EnterFrame:push(self.update1)
	EnterFrame:push(self.update2)
	EnterFrame:start()

	local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(self.onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

-- handling touch events
function EnterFrameTest:onTouchBegan(touch, event)
	release_print("onTouchBegan2")
	pause = not pause
	if pause == true then
		EnterFrame:stop()
	else
		EnterFrame:start()
	end
    return true
end

function EnterFrameTest:update1()
	-- body
	x = x + 1
	if x > 1 then
		EnterFrame:pop(1)
	end
	release_print("x", x)
end

function EnterFrameTest:update2()
	-- body
	release_print("call update2")
end

return EnterFrameTest