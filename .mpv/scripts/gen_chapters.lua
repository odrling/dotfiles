local utils = require("mp.utils")

local new_chapters = true

function add_chapter()
    local time = format(mp.get_property_number("time-pos"))
    local title = mp.get_property("media-title")
    local out = utils.join_path(utils.getcwd(), title.." chapters.ass")
    local file
    if new_chapters then
        file = io.open(out, "w")
        file:write("[Script Info]\nTitle: "..title.."\n\n[Events]\nFormat: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text\n")

        new_chapters = false
    else
        file = io.open(out, "a")
    end

    file:write("Comment: 0,"..time..","..time..",Default,chapter,0,0,0,,\n")
    file:close()

    mp.osd_message("added chapter at "..time)
end

function format(seconds)
    local result = ""
    if seconds <= 0 then
        return "0:00:00.00";
    else
        hours = string.format("%01.f", math.floor(seconds/3600))
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
        secs = string.format("%02.f", math.floor(seconds - hours*60*60 - mins*60))
        msecs = string.format("%02.f", seconds*1000 - hours*60*60*1000 - mins*60*1000 - secs*1000)
        result = hours..":"..mins..":"..secs.."."..msecs
    end
    return result
end

function reset_chapters()
    new_chapters = true
end


mp.register_event('file-loaded', reset_chapters)
mp.add_key_binding("C", "add_chapter", add_chapter)
