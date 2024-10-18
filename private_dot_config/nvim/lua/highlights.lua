local M = {}

---@type Base46HLGroupsList
M.hl_override = {

  Comment = {
    italic = true,
  },
  ["@comment"] = {
    italic = true,
  },
}

M.hl_add = {}

M.changed_themes = {
  -- ashes = {
  --   base_16 = {
  --     base01 = "#393f45",
  --     base02 = "#565e65",
  --     base03 = "#747c84",
  --   }
  -- }
}

return M
