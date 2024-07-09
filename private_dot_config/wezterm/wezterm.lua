-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Ashes (dark) (terminal.sexy)"
	-- return "Zenburn (Gogh)"
	-- return "Liquid Carbon (Gogh)"
	else
		return "Ashes (light) (terminal.sexy)"
	end
end

config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font_size = 15
config.harfbuzz_features = { "ss05" }

config.color_scheme = scheme_for_appearance(get_appearance())

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_frame = {
	font_size = 14,
}

config.window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" }

config.keys = {}

-- Set the correct window size at the startup
-- wezterm.on("gui-startup", function(cmd)
--   local active_screen = wezterm.gui.screens()["active"]
--   local _, _, window = wezterm.mux.spawn_window(cmd or {})
--
--   -- if active_screen.width < 2560 then
--   -- Laptop: open full screen
--   window:gui_window():maximize()
--   -- else
--   -- Desktop: place on the right half of the screen
--   -- window:gui_window():set_position(active_screen.width / 2, 0)
--   -- window:gui_window():set_inner_size(active_screen.width / 2, active_screen.height)
--   -- end
-- end)

return config
