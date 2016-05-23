local EnterFrame = class("EnterFrame")
--获取定时器对象
local scheduler = cc.Director:getInstance():getScheduler()
--创建存放方法的列表
local funList = nil
--存放回调方法id的列表
local funIdList = nil
--方法列表的索引
local index = 0
--执行速度
local second
--初始化方法列表
function EnterFrame:init(fps)
	--self.stop()
	funList = {}
	funIdList = {}
	second = 1 / fps
end
--添加需要帧循环的方法
function EnterFrame:push(fun)
	funList[index] = fun
	index = index + 1
	return index - 1
end
--删除不需要的方法
function EnterFrame:pop(index)
	if funList == nil or funIdList == nil then
		return
	end
	local fun = funList[index]
	local schedulerID = funIdList[fun]
	scheduler:unscheduleScriptEntry(schedulerID)
	table.remove(funList, index)
	release_print(table.nums(funList))
end

--开启enterFrame
function EnterFrame:start()
	release_print("EnterFrame start")
	for key, fun in pairs(funList) do  
        local schedulerID = scheduler:scheduleScriptFunc(fun, second, false)
        funIdList[fun] = schedulerID
    end  
end

--关闭enterfame
function EnterFrame:stop()
	if funIdList == nil then
		return
	end
	for key, schedulerID in pairs(funIdList) do  
        scheduler:unscheduleScriptEntry(schedulerID)
    end
end

return EnterFrame