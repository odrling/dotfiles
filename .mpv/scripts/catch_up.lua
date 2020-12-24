
local catch_up = false
local speed_up = 1.10


function stop_catchup()
   local remaining = mp.get_property("demuxer-cache-time") - mp.get_property("playback-time")

   if remaining < 2 then
      mp.set_property("speed", 1.00)
      catch_up = false
   else
      mp.add_timeout(2, stop_catchup)
   end
end


function catchup()
   catch_up = not catch_up

   if catch_up then
      mp.set_property("speed", speed_up)
      mp.set_property("pause", "no")
      mp.add_timeout(2, stop_catchup)
   else
      mp.set_property("speed", 1.00)
   end
end


mp.add_key_binding("P", "catch_up", catchup)
