-- Input configuration

hl.config({
    input = {
        accel_profile = "flat",
	natural_scroll = true,
	scroll_factor = 0.6
    },
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

hl.gesture({
	fingers = 3,
	direction = "down",
	action = "float"
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = "fullscreen"
})

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace"
})

hl.gesture({
	fingers = 4,
	direction = "up",
	action = function() hl.exec_cmd("qs -c noctalia-shell ipc call launcher toggle") end
})

hl.gesture({
	fingers = 4,
	direction = "down",
	action = function() hl.exec_cmd("alacritty") end
})

