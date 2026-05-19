local M = {}

local theme = "Bibata-Gruvbox"
local size = 24

M.config = {
	hyprcursor = { theme = theme, size = size },
	xcursor = { theme = theme, size = size },
}

function M.apply()
	local hc = M.config.hyprcursor
	local xc = M.config.xcursor
	hl.env("HYPRCURSOR_THEME", hc.theme)
	hl.env("HYPRCURSOR_SIZE", tostring(hc.size))
	hl.env("XCURSOR_THEME", xc.theme)
	hl.env("XCURSOR_SIZE", tostring(xc.size))
end

return M
