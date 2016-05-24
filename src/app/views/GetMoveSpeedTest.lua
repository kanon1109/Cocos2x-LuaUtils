local GetMoveSpeed = require "app.utils.GetMoveSpeed"
local GetMoveSpeedTest = class("GetMoveSpeedTest", cc.load("mvc").ViewBase)
function GetMoveSpeedTest:onCreate()
	-- body
	local listener = cc.EventListenerTouchOneByOne:create()
    --listener:setSwallowTouches(true)
    listener:registerScriptHandler(function(touch, event)
    								local location = touch:getLocation()
    								GetMoveSpeed:initPos(location.x, location.y)
							        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    listener:registerScriptHandler(function(touch, event)
        							local location = touch:getLocation()
    								release_print(GetMoveSpeed:getSpeed(location.x, location.y)) --获取移动速度
    end, cc.Handler.EVENT_TOUCH_MOVED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end
return GetMoveSpeedTest