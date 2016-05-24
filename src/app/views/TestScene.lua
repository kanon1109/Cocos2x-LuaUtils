--创建测试类
local EnterFrameTest = require "app.views.EnterFrameTest"
local LanguageTest = require "app.views.LanguageTest"
local TimeFormatTest = require "app.views.TimeFormatTest"
local RandomTest = require "app.views.RandomTest"
local GetMoveSpeedTest = require "app.views.GetMoveSpeedTest"
local MathUtilTest = require "app.views.MathUtilTest"
local MyApp = require "app.MyApp"
local TestScene = class("TestScene", cc.load("mvc").ViewBase)
function TestScene:onCreate()
	--EnterFrameTest:create("EnterFrameTest"):addTo(self)
	--LanguageTest:create("LanguageTest"):addTo(self)
	--RandomTest:create("RandomTest"):addTo(self)
	--GetMoveSpeedTest:create("GetMoveSpeedTest"):addTo(self)
	--TimeFormatTest:create("TimeFormatTest"):addTo(self)
	--release_print(StringUtil:cutOff("123456789", 4, 2, false))
	--release_print(StringUtil:zfill('12', 5))
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6)) 
	MathUtilTest:create("MathUtilTest"):addTo(self)
end

return TestScene

