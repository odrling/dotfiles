-- caffeine script - don't lock the screen will mpv is open
local utils = require 'mp.utils'

local function start_caffeine()
    local caffeine_command = {}
    caffeine_command.args = {"caffeine", "enable"}

    if mp.get_property('video-codec') ~= nil then
        local redshift_command = {}
        redshift_command.args = {"control_redshift", "disable"}
        utils.subprocess_detached(redshift_command)
    end

    utils.subprocess_detached(caffeine_command)
end

local function stop_caffeine()
    local caffeine_command = {}
    caffeine_command.args = {"caffeine", "disable"}
    local redshift_command = {}
    redshift_command.args = {"control_redshift", "enable"}

    utils.subprocess_detached(caffeine_command)
    utils.subprocess_detached(redshift_command)
end

mp.register_event('shutdown', stop_caffeine)
mp.register_event('file-loaded', start_caffeine)
