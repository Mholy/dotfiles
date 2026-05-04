local leader = "\\"

function setup(config)

  ---------------------------revset---------------------------

	config.action("revset: show after", function()
		revset.set("::" .. context.change_id())
	end, {
		seq = { leader, "r", "a" },
		scope = "revisions",
	})

	config.action("revset: local changes", function()
		revset.set("remote_bookmarks()..@")
	end, {
		seq = { leader, "r", "l" },
		scope = "revisions",
	})

	config.action("revset: expand ancestors", function()
		local change_id = revisions.current()
		if not change_id then
			return
		end

		local current = revset.current()
		local bumped = false
		local updated = current:gsub("ancestors%(" .. change_id .. "%s*,%s*(%d+)%)", function(n)
			bumped = true
			return "ancestors(" .. change_id .. ", " .. (tonumber(n) + 1) .. ")"
		end, 1)

		if not bumped then
			updated = current .. " | ancestors(" .. change_id .. ", 2)"
		end

		revset.set(updated)
	end, {
		seq = { leader, "r", "=" },
		scope = "revisions",
	})

  -------------------------bookmarks--------------------------

	config.action("bookmarks: local only", function()
		revset.set("bookmarks() & ~(main | develop | remote_bookmarks())")
	end, {
		seq = { leader, "b", "l" },
		scope = "revisions",
	})

  ---------------------------files----------------------------

	config.action("files: restore to @", function()
		jj_interactive("restore", "--from", context.change_id(), context.checked_files())
	end, {
		seq = { leader, "b", "l" },
		scope = "revisions.details",
	})

	config.action("files: edit in @", function()
		exec_shell(string.format("nvim %q", context.file()))
		-- exec_shell(
		-- 	string.format(
		-- 		"[ -z \"$NVIM\" ] && (nvim -- %q) || (nvim --server \"$NVIM\" --remote-send \"q\" && nvim --server \"$NVIM\" --remote-tab %q)",
		-- 		context.file()
		-- 	)
		-- )
	end, {
		scope = "revisions.details",
		key = "e",
	})

	config.action("files: edit in revision", function()
		revset.set(context.change_id())
		exec_shell(string.format("nvim %q", context.file()))
	end, {
		scope = "revisions.details",
		key = "E",
	})
end
