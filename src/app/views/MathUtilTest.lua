local MathUtil = require "app.utils.MathUtil"
local MathUtilTest = class("MathUtilTest", cc.load("mvc").ViewBase)
function MathUtilTest:onCreate()
	release_print(MathUtil:fixAngle(366))
	release_print(MathUtil:getFactorial(4))
	release_print(MathUtil:floor(1.123456789, .001))
	release_print(MathUtil:round(1.123456789, .0001))
	release_print(MathUtil:ceil(1.123456789, .001))
	release_print(MathUtil:getSlope(3, 2, 1, 1))
	local table = MathUtil:threeSidesMathAngle(3, 4, 5)
	release_print(table["A"], table["B"], table["C"])

	--旋转
	local size = cc.Director:getInstance():getWinSize()
	local center = cc.p(size.width/2 - 50, size.height/2)

	local spt = MathUtilTest:createRect(self, cc.p(size.width/2 - 50, size.height/2))
	local spt = MathUtilTest:createRect(self, cc.p(size.width/2, size.height/2))
	local spt = MathUtilTest:createRect(self, cc.p(size.width/2 + 50, size.height/2))


	local spt = MathUtilTest:createRect(self, cc.p(size.width/2 - 50, size.height/2))
	local p = MathUtil:rotate(center.x, center.y, 
							spt:getPositionX(), spt:getPositionY(), 
							math.sin(MathUtil:dgs2rds(45)), math.cos(MathUtil:dgs2rds(45)), false)
	spt:setPosition(p)

	local spt = MathUtilTest:createRect(self, cc.p(size.width/2, size.height/2))
	local p = MathUtil:rotate(center.x, center.y, 
							spt:getPositionX(), spt:getPositionY(), 
							math.sin(MathUtil:dgs2rds(45)), math.cos(MathUtil:dgs2rds(45)), false)
	spt:setPosition(p)


	local spt = MathUtilTest:createRect(self, cc.p(size.width/2 + 50, size.height/2))
	local p = MathUtil:rotate(center.x, center.y, 
							spt:getPositionX(), spt:getPositionY(), 
							math.sin(MathUtil:dgs2rds(45)), math.cos(MathUtil:dgs2rds(45)), false)
	spt:setPosition(p)

	release_print(MathUtil:getAngleQuadrant(45))

--判断重心
	local p1 = cc.p(100, 100)
	local p2 = cc.p(300, 100)
	local p3 = cc.p(300, 300)
	--local s1 = MathUtilTest:createRect(self, p1)
	--local s2 = MathUtilTest:createRect(self, p2)
	--local s3 = MathUtilTest:createRect(self, p3)
	local p = MathUtil:triangleCentroid(p1, p2, p3)
	MathUtilTest:createRect(self, p)

	release_print("isInsideTriangle", MathUtil:isInsideTriangle(p1, p2, p3, p))

	local p1 = cc.p(100, 500)
	local p2 = cc.p(500, 500)
	local p3 = cc.p(500, 100)
	local p4 = cc.p(100, 100)
	local p = cc.p(250, 180)
	release_print("p", p.x, p.y)
	MathUtilTest:createRect(self, p1)
	MathUtilTest:createRect(self, p2)
	MathUtilTest:createRect(self, p3)
	MathUtilTest:createRect(self, p4)
	MathUtilTest:createRect(self, p)

	release_print("isInsideSquare", MathUtil:isInsideSquare(p1, p2, p3, p4, p))
end

function MathUtilTest:createRect(self, p)
	local spt = cc.Sprite:create("rect.png")
	spt:setPosition(p)
	self:addChild(spt)
	return spt
end
return MathUtilTest