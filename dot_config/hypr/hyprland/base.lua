hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,

		border_size = 2,

		col = {
			active_border = "rgb(B8BB26)",
			inactive_border = "rgb(282828)",
		},

		layout = "dwindle",
		resize_on_border = false,
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aee,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
			noise = 0.1,
			ignore_opacity = false,
			xray = false,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},
})
