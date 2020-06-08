-- caffeine script - don't lock the screen and disable redshift when mpv is open
local utils = require 'mp.utils'

local function start_caffeine()
    mp.commandv("run", "caffeine", "enable")
    mp.commandv("run", "control_redshift", "disable")
end

local function stop_caffeine()
    mp.commandv("run", "caffeine", "disable")
    mp.commandv("run", "control_redshift", "enable")
end

mp.register_event('shutdown', stop_caffeine)
mp.register_event('file-loaded', start_caffeine)
