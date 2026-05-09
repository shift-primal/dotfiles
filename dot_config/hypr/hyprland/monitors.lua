hl.monitor({
	output = "DP-2",
	mode = "2560x1440@60.0",
	position = "-2560x0",
	scale = "1.0",
	sdr_eotf = "srgb",
})

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144.0",
	position = "0x0",
	scale = "1.0",
	sdr_eotf = "srgb",
})

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@144.0",
	position = "2560x0",
	scale = "1.0",
	sdr_eotf = "srgb",
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3" })
