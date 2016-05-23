local StringUtil = require "app.utils.StringUtil"
local Language = class("Language")
local dict = {}
--初始化方法列表
function Language:init(filePath)
--读取文件
	local data = cc.FileUtils:getInstance():getStringFromFile(filePath)
	release_print(data)
--按行划分
	local lineStr = StringUtil:split(data, "\n\r")
--按，号划分
	for _, s in ipairs(lineStr) do
		local str = StringUtil:split(s, ",")
		dict[str[1]] = str[2]
	end
end

--根据key获取language的值
function Language:get(key)
	if dict[key] == nil then
		return key.."@error"
	end
	return dict[key]
end

--根据key获取language的值
function Language:get(key, ...)
	if dict[key] == nil then
		return key.."@error"
	end
	return string.format(dict[key], ...)
end

return Language