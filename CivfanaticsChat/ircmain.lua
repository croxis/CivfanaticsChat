-- ircmain
-- Author: croxis
-- DateCreated: 1/5/2013 4:00:35 PM
--------------------------------------------------------------
print("Testing socket class")
local sock = include("socket.lua")
--include("lua\\socket")
--include("Lua\\socket.lua")
print("Sock version" .. sock._VERSION)
local http = include("socket.http")
print(http.request("http://www.cs.princeton.edu/~diego/professional/luasocket"))

--[[local g_errorStr = "none"
local function Traceback(str)
	print(str)
	if not debug then return str end
	if str == g_errorStr then		--debug.getinfo is slow, so don't run 1000 times for the same error
		return str 
	end
	g_errorStr = str
	print("stack traceback:")
	str = str .. "[NEWLINE]stack traceback:"	--str is only needed after this point for the popup
	local level = 2		--level 1 is this function
	while true do
		local info = debug.getinfo(level)
		if not info then break end
		local errorLine = ""
		if info.what == "C" then   -- is a C function?
			errorLine = string.format("%d: %s", level, "C function")
		elseif info.source == "=(tail call)" then
			errorLine = string.format("%d: %s", level, "Tail call")
		elseif not info.name or info.name == "" then
			errorLine = string.format("%d: %s: %d", level, (info.source or "nil"), (info.currentline or "-1"))
		else 
			errorLine = string.format("%d: %s %s: %d", level, (info.name or "nil"), (info.source or "nil"), (info.currentline or "-1"))
		end
		print(errorLine)
		str = str .. "[NEWLINE]" .. errorLine
		level = level + 1
	end
	return str
end

function HandleError(f, ...)
	--f can have any number of args and return values
	local g = function() return f(unpack(arg)) end --need wrapper since xpcall won't take function args
	local result = {xpcall(g, Traceback)}
	if result[1] then
		return unpack(result, 2)
	end
	--DoErrorPopup(result[2])
end

function HandleError41(f, arg1, arg2, arg3, arg4)
	--f can have up to 4 args and 0 or 1 return value
	local g = function() return f(arg1, arg2, arg3, arg4) end --need wrapper since xpcall won't take function args
	local success, value = xpcall(g, Traceback)
	if success then
		return value
	end
	--DoErrorPopup(value)	
end
 
-- Calls someDangerousFunction with the given error handler
--xpcall(someDangerousFunction, errorHandler)
--include("socket.lua")
--include("lua\\socket")
--include("Lua\\socket.lua")


--xpcall(test, errorHandler)
local files = include("socket.lua")
for i, v in ipairs(files) do
	print("Loaded Popup - "..v);
	local socket = v
	print(socket._VERSION)
end
print("Load attempt complete")
--local socket = HandleError(include, "socket.lua")]]--
