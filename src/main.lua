
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")



require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end

-- for CCLuaEngine traceback  
function __G__TRACKBACK__(msg)
	release_print("----------------------------------------")
	release_print("LUA ERROR: " .. tostring(msg) .. "\n")
	release_print(debug.traceback())  
	release_print("----------------------------------------")
	return msg
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
