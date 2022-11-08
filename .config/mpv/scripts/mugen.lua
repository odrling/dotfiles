local utils = require("mp.utils")

local function get_kdata(kid)
    local resp = mp.command_native({
        name = "subprocess",
        args = { "curl", "-s", "https://kara.moe/api/karas/" .. kid },
        capture_stdout = true,
    })

    return utils.parse_json(resp.stdout)
end

local function on_load()
    local path = mp.get_property("path")
    local kid = path:match("^https://kara.moe/kara/.-([0-9a-z-]+)$")
    if kid == nil then
        kid = path:match("^https://live.karaokes.moe/%?video=([0-9a-z-]+)$")
    end
    if kid ~= nil then
        local kdata = get_kdata(kid)
        local mediafile = "https://kara.moe/downloads/medias/" .. kdata.mediafile
        local subfile = "https://kara.moe/downloads/lyrics/" .. kdata.subfile
        mp.set_property("stream-open-filename", mediafile)
        mp.set_property("replaygain-fallback", kdata.gain)
        mp.commandv("sub-add", subfile)
    end
end

mp.register_event("start-file", on_load)
