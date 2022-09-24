-- redshift.lua - disable redshift while mpv is playing a video

local function control_redshift(name, value)
	if value then
		mp.commandv("run", "control_redshift", "disable")
	else
		mp.commandv("run", "control_redshift", "enable")
	end
end

local function restart_redshift()
	mp.commandv("run", "control_redshift", "enable")
end

mp.observe_property("vo-configured", "bool", control_redshift)
mp.register_event("shutdown", restart_redshift)
control_redshift("vo-configured", mp.get_property("vo-configured", true))
