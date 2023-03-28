
-- Description: Taskwarrior Lua script
-- Author: 2023, msk
-- License: MIT
-- Version: 0.1
--
--
local json = require("JSON")

local function get_tasks()
    local tasks = {}
    local f = io.popen("task proj.not:books due.before:today+1  status:pending export")
    local t = f:read("*a") 
    tasks = json:decode(t)
    f:close()

    return tasks
end

return {
    get_tasks = get_tasks
}

