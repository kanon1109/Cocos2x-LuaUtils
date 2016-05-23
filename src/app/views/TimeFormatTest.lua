local TimeFormat = require "app.utils.TimeFormat"
local TimeFormatTest = class("TimeFormatTest", cc.load("mvc").ViewBase)
function TimeFormatTest:onCreate()
	-- body
	release_print(TimeFormat:secondToTime(60, ":", true))
	release_print(TimeFormat:timeToSecond("00:01:00", ":"))
end
return TimeFormatTest