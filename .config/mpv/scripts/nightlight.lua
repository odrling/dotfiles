-- nightlight.lua - disable nightlight while mpv is playing a video
-- could use USR1 but I find it not as easy to use for this purpose
local settings = {
    on_focus = false,
    on_vo_configuration = true,
    backend = 'noctalia'
}

local opts = require("mp.options")
opts.read_options(settings, "wlsunset")

local manual = false
local nightlight_state

local function reset_manual()
    manual = false

    nightlight_state = (
        settings.on_focus and mp.get_property("focused") and
        settings.on_vo_configuration and mp.get_property("vo-configured")
    )
    update_wlsunset()
end

local function update_wlsunset()
    if nightlight_state then
        if settings.backend == "noctalia" then
            mp.commandv("run", "noctalia", "msg", "nightlight-disable")
        elseif settings.backend == "wlsunset" then
            mp.commandv("run", "rc-service", "-U", "wlsunset", "stop")
        end
    else
        if settings.backend == "noctalia" then
            mp.commandv("run", "noctalia", "msg", "nightlight-enable")
        elseif settings.backend == "wlsunset" then
            mp.commandv("run", "rc-service", "-U", "wlsunset", "start")
        end
    end
end

local function toggle_wlsunset()
    manual = true
    nightlight_state = not nightlight_state
    update_wlsunset()
end

local function control_wlsunset(name, value)
    if not manual then
        nightlight_state = value
        update_wlsunset()
    end
end

local function restart_wlsunset()
    nightlight_state = false
    update_wlsunset()
end

if settings.on_focus then
    mp.observe_property("focused", "bool", control_wlsunset)
end
if settings.on_vo_configuration then
    mp.observe_property("vo-configured", "bool", control_wlsunset)
end
mp.register_event("shutdown", restart_wlsunset)

mp.add_key_binding("Ctrl+f", "toggle", toggle_wlsunset)
mp.add_key_binding("Alt+f", "reset_manual", reset_manual)
