
settings = {

   speed_up = 1.10,
   catchup_until = 3,

}

local opts = require 'mp.options'
opts.read_options(settings, "catch_up")


local catch_up = false
local catch_up_timeout = 1
local catchup_until = settings.catchup_until


function stop_catchup()
   local remaining = mp.get_property_number("demuxer-cache-duration")

   if remaining < catchup_until then
      mp.set_property("speed", 1.00)
      catch_up = false
   else
      mp.add_timeout(catch_up_timeout, stop_catchup)
   end
end


function catchup()
   catch_up = not catch_up

   if catch_up then
      mp.set_property("speed", settings.speed_up)
      mp.set_property("pause", "no")
      mp.add_timeout(catch_up_timeout, stop_catchup)
   else
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


mp.add_key_binding("P", "catch_up", catchup)
mp.add_key_binding("Ctrl+p", "increase_catch_up", increase_catch_up)
mp.add_key_binding("Ctrl+P", "decrease_catch_up", decrease_catch_up)
