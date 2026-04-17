PaperWM = hs.loadSpoon("PaperWM")

PaperWM:bindHotkeys({
	-- switch windows by cycling forward/backward
	-- (forward = down or right, backward = up or left)
	focus_left = { { "alt", "shift" }, "tab" },
	focus_right = { { "alt" }, "tab" },
})

PaperWM.window_gap = 0
-- PaperWM.window_gap = { top = 0, bottom = 0, left = 6, right = 6 }

-- ignore a specific app
PaperWM.window_filter:rejectApp("SomaFM")
PaperWM.window_filter:rejectApp("Antinote")
PaperWM.window_filter:rejectApp("Itsypad")

-- ignore a specific window of an app
-- PaperWM.window_filter:setAppFilter("iTunes", { rejectTitles = "MiniPlayer" })

-- list of screens to tile (use % to escape string match characters, like -)
-- PaperWM.window_filter:setScreens({ "Built%-in Retina Display" })

PaperWM.center_mouse = true
PaperWM.infinite_loop_window = false
PaperWM.window_ratios = { 1 / 3, 1 / 2, 2 / 3, 3 / 4 }
PaperWM.default_width = 0.5
PaperWM.app_widths = {
	["Zen"] = 0.75,
	["Slack"] = 0.75,
}
-- PaperWM.swipe_fingers = 3
-- PaperWM.swipe_gain = 1.0

-- set to a table of modifier keys to enable window dragging, default is nil
-- PaperWM.drag_window = { "alt", "cmd" }`

-- set to a table of modifier keys to enable window lifting, default is nil
-- PaperWM.lift_window = { "alt", "cmd", "shift" }

PaperWM:start()

local paperwmWindowFilter = hs.window.filter.copy(PaperWM.window_filter)

local function paperwmCenterMode(enabled)
	if enabled then
		paperwmWindowFilter:subscribe(hs.window.filter.windowFocused, PaperWM.actions.actions().center_window)
	else
		paperwmWindowFilter:unsubscribe(hs.window.filter.windowFocused, PaperWM.actions.actions().center_window)
	end
end

-- paperwmCenterMode(true)

-- hs.hotkey.bind({ "alt", "shift" }, "tab", function()
-- 	hs.window.focusedWindow():focusWindowWest()
-- end)

-- hs.hotkey.bind({ "alt" }, "tab", function()
-- 	hs.window.focusedWindow():focusWindowEast()
-- end)

hs.urlevent.bind("paperwm", function(_, params)
	local eventAction = params.action

	local actionNames = {
		"start_events",
		"stop_events",
		"refresh_windows",
		"dump_state",
		"toggle_floating",
		"focus_floating",
		"focus_left",
		"focus_right",
		"focus_up",
		"focus_down",
		"focus_prev",
		"focus_next",
		"swap_left",
		"swap_right",
		"swap_up",
		"swap_down",
		"swap_column_left",
		"swap_column_right",
		"center_window",
		"full_width",
		"increase_width",
		"decrease_width",
		"increase_height",
		"decrease_height",
		"cycle_width",
		"cycle_height",
		"reverse_cycle_width",
		"reverse_cycle_height",
		"slurp_in",
		"barf_out",
		"split_screen",
		"switch_space_l",
		"switch_space_r",
		"switch_space_1",
		"switch_space_2",
		"switch_space_3",
		"switch_space_4",
		"switch_space_5",
		"switch_space_6",
		"switch_space_7",
		"switch_space_8",
		"switch_space_9",
		"move_window_l",
		"move_window_r",
		"move_window_u",
		"move_window_d",
		"move_window_1",
		"move_window_2",
		"move_window_3",
		"move_window_4",
		"move_window_5",
		"move_window_6",
		"move_window_7",
		"move_window_8",
		"move_window_9",
		"focus_window_1",
		"focus_window_2",
		"focus_window_3",
		"focus_window_4",
		"focus_window_5",
		"focus_window_6",
		"focus_window_7",
		"focus_window_8",
		"focus_window_9",
		"focus_window_first",
		"focus_window_last",
	}

	local actions = PaperWM.actions.actions()

	for _, v in ipairs(actionNames) do
		if v == eventAction then
			return actions[v]()
		end
	end

	if eventAction == "stop" then
		PaperWM:stop()
	end

	if eventAction == "start" then
		PaperWM:start()
	end

	-- center window on focus
	if eventAction == "mode_center_on" then
		paperwmCenterMode(true)
	end

	if eventAction == "mode_center_off" then
		paperwmCenterMode(false)
	end
end)

---

WarpMouse = hs.loadSpoon("WarpMouse")
-- WarpMouse.margin = 10 -- optionally set how far past a screen edge the mouse should warp, default is 2 pixels
WarpMouse.reverseScreens = true -- optionally set to warp from bottom to top instead of top to bottom, default is false

WarpMouse:start()

---

-- use three finger swipe to focus nearby window
-- local current_id, threshold
-- Swipe = hs.loadSpoon("Swipe")
-- Swipe:start(3, function(direction, distance, id)
-- 	if id == current_id then
-- 		if distance > threshold then
-- 			threshold = math.huge -- only trigger once per swipe
--
-- 			-- use "natural" scrolling
-- 			if direction == "left" then
-- 				hs.window.focusedWindow():focusWindowEast()
-- 			elseif direction == "right" then
-- 				hs.window.focusedWindow():focusWindowWest()
-- 			elseif direction == "up" then
-- 				hs.window.focusedWindow():focusWindowSouth()
-- 			elseif direction == "down" then
-- 				hs.window.focusedWindow():focusWindowNorth()
-- 			end
-- 		end
-- 	else
-- 		current_id = id
-- 		threshold = 0.2 -- swipe distance > 20% of trackpad
-- 	end
-- end)
