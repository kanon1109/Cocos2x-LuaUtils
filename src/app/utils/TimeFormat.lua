local StringUtil = require "app.utils.StringUtil"
local TimeFormat = class("TimeFormat")
--秒数转换成时间格式
--second 	秒数
--partition 分割符
--showHour 	是否显示小时
function TimeFormat:secondToTime(second, partition, showHour)
	-- body
	local h = math.floor(second / 3600)
	local m = math.floor(second % 3600 / 60)
	local s = math.floor(second % 3600 % 60)

	local hStr = h
	local mStr = m
	local sStr = s

	if h < 10 then
		--todo
		hStr = "0"..h
	end
	if m < 10 then
		--todo
		mStr = "0"..m
	end
	if s < 10 then
		--todo
		sStr = "0"..s
	end

	local result
	if showHour then
		result = hStr..partition..mStr..partition..sStr
	else
		result = mStr..partition..sStr
	end
	return result
end

function TimeFormat:timeToSecond(timeStr, partition)
	-- body
	local ary = StringUtil:split(timeStr, partition)
	local count = table.getn(ary)
	local time = 0
	for i = 1, count do
		local n = ary[i]
		time = time + (n * math.pow(60, (count - i)))
	end
	return time
end

return TimeFormat