local ext = require("telescope._extensions")
local frecency_db = require("telescope._extensions.frecency.db_client")

local zf = ext.manager["zf-native"]

local function frecency_score(self, prompt, line, entry)
  if prompt == nil or prompt == "" then
    for _, file_entry in ipairs(self.state.frecency) do
      local filepath = entry.cwd .. "/" .. entry.value
      if file_entry.filename == filepath then
        return 9999 - file_entry.score
      end
    end

    return 9999
  end

  return self.default_scoring_function(self, prompt, line, entry)
end

local function frecency_start(self, prompt)
  self.default_start(self, prompt)

  if not self.state.frecency then
    self.state.frecency = frecency_db.get_file_scores()
  end
end

local frecency_sorter = function(opts)
  local zf_sorter = zf.native_zf_scorer()

  zf_sorter.default_scoring_function = zf_sorter.scoring_function
  zf_sorter.default_start = zf_sorter.start

  zf_sorter.scoring_function = frecency_score
  zf_sorter.start = frecency_start

  return zf_sorter
end

return frecency_sorter
