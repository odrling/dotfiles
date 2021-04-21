
settings = {

   speed_up = 1.05,
   catchup_until = 4,

}

local opts = require 'mp.options'
opts.read_options(settings, "catch_up")


local catch_up = false
local catch_up_timeout = 1
local catchup_until = settings.catchup_until


function catchup_loop()
   local remaining = mp.get_property_number("demuxer-cache-duration", 0)

   if remaining < catchup_until then
      mp.set_property("speed", 1.00)
   else
      mp.set_property("speed", settings.speed_up)
   end

   if catch_up then
      mp.add_timeout(catch_up_timeout, catchup_loop)
   else
      mp.set_property("speed", 1.00)
   end
end


function catchup()
   catch_up = not catch_up

   if catch_up then
      mp.set_property("pause", "no")
      mp.osd_message("catch up enabled")
      catchup_loop()
   else
      mp.osd_message("catch up disabled")
      mp.set_property("speed", 1.00)
   end
end

local UPDATE_AMOUNT = 1

function update_catch_up_until(amount)
   catchup_until = catchup_until + amount
   mp.osd_message(("catch up until: %d"):format(catchup_until))
end

function increase_catch_up()
   update_catch_up_until(1)
end

function decrease_catch_up()
   update_catch_up_until(-1)
end

function on_load()
   catch_up = not mp.get_property_bool("seekable") and mp.get_property_bool("demuxer-via-network")

   if catch_up then
      catchup_loop()
   end
end

mp.register_event('file-loaded', on_load)

mp.add_key_binding("P", "catch_up", catchup)
mp.add_key_binding("Ctrl+p", "increase_catch_up", increase_catch_up)
mp.add_key_binding("Ctrl+P", "decrease_catch_up", decrease_catch_up)
