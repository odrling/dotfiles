local tr = aegisub.gettext

script_name = tr"Karaoke split line"
script_description = tr"split line at marker according to ktags"
script_author = "amoethyst"
script_version = "1.0"

function split_line(subs, sel)

    function getduration(line)
	d = 0

	kduration = "{[^}]-\\[kK][fo]?(%d+)[^}]-}"
	_, iend, match = line:find(kduration)
	while match do
	    d = d + tonumber(match)
	    line = line:sub(iend + 1) -- keep looking for more
	    _, iend, match = line:find(kduration)
	end

	return d * 10
    end

    for _, i in ipairs(sel) do
        line1 = subs[i]
	line2 = subs[i]

	line1.text, line2.text = line1.text:match("(.-){split}(.*)")

	if line1.text ~= nil then
	    line1.end_time = line1.start_time + getduration(line1.text)
	    line2.start_time = line1.end_time
	end

	subs[i] = line1
	subs.insert(i+1, line2)
    end
    aegisub.set_undo_point(tr"Karaoke split")
end

aegisub.register_macro(script_name, script_description, split_line)
