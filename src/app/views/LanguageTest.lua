local Language = require "app.utils.Language"
local LanguageTest = class("LanguageTest", cc.load("mvc").ViewBase)
function LanguageTest:onCreate()
	-- body
	Language:init("language.csv")
	release_print(Language:get("test"))

	local size = cc.Director:getInstance():getWinSize()
	local tf = cc.Label:create()
	--字符串相加
	tf:setString(Language:get("test")..Language:get("welcome"))
	tf:setSystemFontSize(20)
	tf:setPosition( cc.p(size.width/2, size.height * 0.7) )
	self:addChild(tf)

	release_print(Language:get("test1", 1, "s", "d"))

end
return LanguageTest