local settings = {

   host = "https://karaberus.japan7.bde.enseeiht.fr",
   token = "",

}

local opts = require 'mp.options'
opts.read_options(settings, "karaberus")

local function is_karaberus(path)
   return path:match("^" .. settings.host)
end


local function on_load()
   local path = mp.get_property("path")
   local match = path

   if is_karaberus(path) and settings.token ~= "" then
      local headers = {"Authorization: Bearer "..settings.token}
      mp.set_property_native("file-local-options/http-header-fields", headers)

      local id = path:match("^"..settings.host.."/karaoke/browse/([0-9]+)")

      if id ~= nil then
         local base_dl_url = settings.host.."/api/kara/"..id.."/download/"
         mp.set_property("stream-open-filename", base_dl_url .. "video")
         mp.commandv("sub-add", base_dl_url .. "sub")
         mp.commandv("audio-add", base_dl_url .. "audio")
      end
   end
end

mp.register_event('start-file', on_load)
