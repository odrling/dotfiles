-- jack_delay - set jack audio delay automatically
require 'io'

local function set_jack_delay()
    local samplerate = io.popen("jack_samplerate"):read()
    local bufsize = io.popen("jack_bufsize"):read()
    local delay = bufsize / samplerate
    mp.set_property("audio-delay", "-"..delay)
end

set_jack_delay()
