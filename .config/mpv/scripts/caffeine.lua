-- caffeine script - don't lock the screen when mpv is open

local function start_caffeine()
    mp.commandv("run", "caffeine", "enable")
end

local function stop_caffeine()
    mp.commandv("run", "caffeine", "disable")
end

mp.register_event('shutdown', stop_caffeine)
mp.register_event('file-loaded', start_caffeine)
