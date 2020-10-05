local tr = aegisub.gettext

script_name = tr"frz endro"
script_description = tr"probably won't be useful anytime soon"
script_author = "amoethyst"
script_version = "1.0"

function frz_combo(subs, sel)

    local expr = "frz([0-9.-]+)"

    for _, i in ipairs(sel) do
        line = subs[i]
        aegisub.log(line.text)
        frz_text = line.text:match(expr)
        aegisub.log(frz_text)
        frz = tonumber(frz_text) * -1
        line.text = line.text .. "{\\frz"..frz.."}"
        subs[i] = line
    end

end

aegisub.register_macro(script_name, script_description, frz_combo)
