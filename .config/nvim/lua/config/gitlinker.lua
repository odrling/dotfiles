local hosts = require('gitlinker.hosts')

local function get_cgit_stripped_type_url(url_data)
    return 'https://' ..
        url_data.host .. '/' .. url_data.repo .. '/tree/' .. url_data.file .. '?id=' .. url_data.rev .. "#n" ..
        url_data.lstart
end

require('gitlinker').setup({
    mappings = "<leader>Y",
    callbacks = {
        ["git.odrling.xyz"] = get_cgit_stripped_type_url,
        ["git.kernel.org"] = get_cgit_stripped_type_url,
        ["git.japan7.bde.enseeiht.fr"] = hosts.get_gitea_type_url,
        ["git.inpt.fr"] = hosts.get_gitlab_type_url,
        ["git.rhiobet.sh"] = hosts.get_gitea_type_url,
    }
})
