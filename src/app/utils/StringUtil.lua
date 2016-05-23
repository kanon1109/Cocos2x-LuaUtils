local StringUtil = class("StringUtil")
--分割字符串
function StringUtil:split(str, p)
    local rt= {}
    string.gsub(str, '[^'..p..']+', function(w) table.insert(rt, w) end)
    return rt
end

--截断某段字符串
--str		目标字符串
--start		需要截断的起始索引
--len		截断长度
--order		顺序，true从字符串头部开始计算，false从字符串尾巴开始结算。
--截断后的字符串
function StringUtil:cutOff(str, start, len, order)
	local length = string.len(str)
	if start > length then
		start = length
	end
	local s = start
	local e = start + len
	local newStr
	if order == true then
		newStr = string.sub(str, 1, s - 1)..string.sub(str, e, length)
	else
		s = length - start - len;
		e = s + len;
		newStr = string.sub(str, 1, s + 1)..string.sub(str, e + 2, length);
	end
	return newStr;
end

--给数字字符前面添 "0"
--str 要进行处理的字符串
--处理后字符串的长度，如果str.length >= width，将不做任何处理直接返回原始的str。
function StringUtil:zfill(str, width)
    local slen = string.len(str)
    if slen >= width then
    	return str
    end

    local negative = false;
    if string.sub(str, 1, 1) == '-' then
    	negative = true
    	str = string.sub(str, 2, slen)
    end

	local len = width - slen
    for i = 1 , len do
    	str = '0'..str
    end
	if negative == true then
    	str = '-'..str
    end
    return str
end

function StringUtil:isWhiteSpace(str)
	if str == " " or str == "\t" or str == "\r" or str == "\n" then
		return true
	end
	return false
end

return StringUtil