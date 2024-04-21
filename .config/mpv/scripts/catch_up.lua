local settings = {
	catch_up = false,
	speed_up = 1.05,
	catchup_until = 4,
}

local opts = require("mp.options")
opts.read_options(settings, "catch_up")

local paused_for_cache = false
local catch_up_timeout = 0.5
local catchup_until = settings.catchup_until

local function catchup_loop()
	local remaining = mp.get_property_number("demuxer-cache-duration", 0)

	if remaining < catchup_until then
		if paused_for_cache then
			mp.set_property("speed", 1.00 - (settings.speed_up - 1.00))
		else
			mp.set_property("speed", 1.00)
		end
	else
		paused_for_cache = false
		if mp.get_property_number("speed") < settings.speed_up then
			mp.set_property("speed", settings.speed_up)
		end
	end

	if settings.catch_up then
		mp.add_timeout(catch_up_timeout, catchup_loop)
	else
		mp.set_property("speed", 1.00)
	end
end

local function catchup()
	settings.catch_up = not settings.catch_up

	if settings.catch_up then
		mp.set_property("pause", "no")
		mp.osd_message("catch up enabled")
		catchup_loop()
	else
		mp.osd_message("catch up disabled")
		mp.set_property("speed", 1.00)
	end
end

local function update_catch_up_until(amount)
	catchup_until = catchup_until + amount
	mp.osd_message(("catch up until: %d"):format(catchup_until))
end

local function increase_catch_up()
	update_catch_up_until(1)
end

local function decrease_catch_up()
	update_catch_up_until(-1)
end

local function on_load()
	if settings.catch_up then
		catchup_loop()
	end
end

local function on_pause_for_cache(name, value)
	if value and settings.catch_up then
		paused_for_cache = true
	end
end

mp.observe_property("paused-for-cache", "bool", on_pause_for_cache)

mp.register_event("file-loaded", on_load)

mp.add_key_binding("P", "catch_up", catchup)
mp.add_key_binding("Ctrl+p", "increase_catch_up", increase_catch_up)
mp.add_key_binding("Ctrl+P", "decrease_catch_up", decrease_catch_up)
