local MathUtil = class("MathUtil")

--弧度转换成角度  radians -> degrees
function MathUtil:rds2dgs(radians)
    return MathUtil:fixAngle(radians * 180 / math.pi)
end

--角度转换成弧度 degrees -> radians
function MathUtil:dgs2rds(degrees)
    return degrees * math.pi / 180
end

--标准化角度值，将传入的角度值返回成一个确保落在 0 ~ 360 之间的数字。
function MathUtil:fixAngle(angle)
    return MathUtil:fixNumber(angle, 0, 360)
end

--修正半角
function MathUtil:fixNumber(num, min, range)
	num = num % range
	if num < min then
		return num + range
	end
    return num
end

--求取阶乘
function MathUtil:getFactorial(num)
	if num == 0 then
		return 1
	end
    return num * MathUtil:getFactorial(num - 1)
end

--对一个数保留指定的小数位数, 然后向下取整
function MathUtil:floor(num, interval)
	return math.floor(num / interval) * interval
end

--对一个数保留指定的小数位数, 然后四舍五入
function MathUtil:round(num, interval)
	return math.round(num / interval) * interval
end

--对一个数保留指定的小数位数, 然后向上取整
function MathUtil:ceil(num, interval)
	return math.ceil(num / interval) * interval
end

--斜率公式
function MathUtil:getSlope(x1, y1, x2, y2)
	return (y1 - y2) / (x1 - x2)
end

--正弦公式
--a/sinA=b/sinB=c/sinC=2R
--已知一个角度以及角度对应的边长 可以求出三角外接圆半径R的2倍
--angle               弧度
--line                弧度应的变长
--三角外接圆半径R
function MathUtil:sineLaw(angle, line)
	return line / math.sin(angle) / 2
end

--[[
 余弦公式
 CosC=(a^2+b^2-c^2)/2ab
 CosB=(a^2+c^2-b^2)/2ac
 CosA=(c^2+b^2-a^2)/2bc 
 已知3边求出某边对应的角的角度
 @param	a 边
 @param	b 边
 @param	c 边
 @return  一个对象包含三个对应的角度
--]]
function MathUtil:threeSidesMathAngle(a, b, c)
	local cosA = (c * c + b * b - a * a) / (2 * b * c)
	local cosB = (a * a + c * c - b * b) / (2 * a * c)
	local cosC = (a * a + b * b - c * c) / (2 * a * b)
	local A = math.round(MathUtil:rds2dgs(math.acos(cosA)))
	local B = math.round(MathUtil:rds2dgs(math.acos(cosB)))
	local C = math.round(MathUtil:rds2dgs(math.acos(cosC)))
	release_print(MathUtil:rds2dgs(math.pi))
	local table = {}
	table["A"] = A
	table["B"] = B
	table["C"] = C
	return table
end

--[[ 坐标旋转公式
 @param	cx			中心点x坐标
 @param	cy			中心点y坐标
 @param	x			需要旋转的物体的x坐标
 @param	y			需要旋转的物体的y坐标
 @param	sin			sin(旋转角度);
 @param	cos			cos(旋转角度);
 @param	reverse		是否逆时针旋转
 @return	旋转后坐标
]]--
function MathUtil:rotate(cx, cy, x, y, sin, cos, reverse)
	local point = cc.p(0, 0)
	local dx = x - cx
	local dy = y - cy
	if reverse then
		point.x = dx * cos + dy * sin + cx
		point.y = dy * cos - dx * sin + cy
	else
		point.x = dx * cos - dy * sin + cx
		point.y = dy * cos + dx * sin + cy
	end
	return point;
end

--求出直角坐标系 三角形的重心
--a      三角形顶点a
--b      三角形顶点b
--c      三角形顶点c
function MathUtil:triangleCentroid(a, b, c)
	return cc.p((a.x + b.x + c.x) / 3, (a.y + b.y + c.y) / 3)
end

--求三角形面积
--a		点a
--b		点b
--c		点c
function MathUtil:triangleArea(a, b, c)
	return (c.x * b.y - b.x * c.y) - (c.x * a.y - a.x * c.y) + (b.x * a.y - a.x * b.y)
end

--判断点是否在一个矩形范围内（矩形可旋转）点必须是顺时针
--@param	a		点a
--@param	b		点b
--@param	c		点c
--@param	d		点d
--@param	p		点坐标
--@return	是否在一个矩形范围内
function MathUtil:isInsideSquare(a, b, c, d, p)
	release_print(MathUtil:triangleArea(a, b, p))
	if MathUtil:triangleArea(b, a, p) > 0 or
		MathUtil:triangleArea(c, b, p) > 0 or
		MathUtil:triangleArea(d, c, p) > 0 or
		MathUtil:triangleArea(a, d, p) > 0 then
		return false
	end
	return true
end

--[[判断点是否在任意三角形内部
@param	a		三角形点a
@param	b		三角形点b
@param	c		三角形点c
@param	p		点
@return	是否在三角形内部
]]--
function MathUtil:isInsideTriangle(a, b, c, p)
	local planeAB = (a.x - p.x) * (b.y - p.y) - (b.x - p.x) * (a.y - p.y)
	local planeBC = (b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)
	local planeCA = (c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)
	return MathUtil:sign(planeAB) == MathUtil:sign(planeBC) and MathUtil:sign(planeBC) == MathUtil:sign(planeCA)
end

function MathUtil:sign(n)
	return math.abs(n) / n
end

--获取角度象限值
--@param	angle	角度
--@return	象限值
function MathUtil:getAngleQuadrant(angle)
	angle = MathUtil:fixAngle(angle)
	if angle >= 0 and angle < 90 then
		return 1
	end
	if angle >= 90 and angle < 180 then
		return 2
	end
	if angle >= 180 and angle < 270 then
		return 3
	end
	return 4;
end

return MathUtil