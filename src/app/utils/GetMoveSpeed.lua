local GetMoveSpeed = class("GetMoveSpeed")

local prevX
local prevY

--初始化位置
function GetMoveSpeed:initPos(x, y)
	prevX = x
	prevY = y
end

--计算移动速度
function GetMoveSpeed:getSpeed(x, y)
	local xSpeed = math.abs(x - prevX);
	local ySpeed = math.abs(y - prevY);
	prevX = x;
	prevY = y;
	return xSpeed + ySpeed;
end

return GetMoveSpeed