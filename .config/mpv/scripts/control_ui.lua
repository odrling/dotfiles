local ui_state = false

local function toggle_ui()
    print("toggle")
    mp.commandv('script-message-to', 'uosc', 'toggle-elements', "top_bar,timeline")
    ui_state = not ui_state
end

local function enable_ui()
    if not ui_state then
        toggle_ui()
    end
end

local function disable_ui()
    if ui_state then
        toggle_ui()
    end
end

local function on_pause(name, state)
    if state then
        enable_ui()
    else
        disable_ui()
    end
end

mp.observe_property("pause", "bool", on_pause)
mp.add_key_binding(nil, "toggle-ui", toggle_ui)
