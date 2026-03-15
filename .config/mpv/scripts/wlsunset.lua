-- wlsunset.lua - disable wlsunset while mpv is playing a video
-- could use USR1 but I find it not as easy to use for this purpose
local settings = {
    on_focus = true,
    on_vo_configuration = false,
}

local opts = require("mp.options")
opts.read_options(settings, "wlsunset")

local manual = false
local wlsunset_state

local function reset_manual()
    manual = false
end

local function update_wlsunset()
    if wlsunset_state then
        mp.commandv("run", "rc-service", "-U", "wlsunset", "stop")
    else
        mp.commandv("run", "rc-service", "-U", "wlsunset", "start")
    end
end

local function toggle_wlsunset()
    manual = true
    wlsunset_state = not wlsunset_state
    update_wlsunset()
end

local function control_wlsunset(name, value)
    if not manual then
        wlsunset_state = value
        update_wlsunset()
    end
end

local function restart_wlsunset()
    mp.commandv("run", "rc-service", "-U", "wlsunset", "start")
end

if settings.on_focus then
    mp.observe_property("focused", "bool", control_wlsunset)
end
if settings.on_vo_configuration then
    mp.observe_property("focused", "bool", control_wlsunset)
end
mp.register_event("shutdown", restart_wlsunset)

mp.add_key_binding("Ctrl+f", "toggle", toggle_wlsunset)
mp.add_key_binding("Alt+f", "reset_manual", reset_manual)
