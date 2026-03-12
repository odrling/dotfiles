-- wlsunset.lua - disable wlsunset while mpv is playing a video
-- could use USR1 but I find it not as easy to use for this purpose

local function control_wlsunset(name, value)
	if value then
		mp.commandv("run", "rc-service", "-U", "wlsunset", "stop")
	else
		mp.commandv("run", "rc-service", "-U", "wlsunset", "start")
	end
end

local function restart_wlsunset()
	mp.commandv("run", "rc-service", "-U", "wlsunset", "start")
end

mp.observe_property("vo-configured", "bool", control_wlsunset)
mp.register_event("shutdown", restart_wlsunset)
control_wlsunset("vo-configured", mp.get_property("vo-configured", true))
