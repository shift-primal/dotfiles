local MOD = "SUPER"
local IPC = "qs -c noctalia-shell ipc call"

local apps = {
	terminal = "kitty",
	editor = "nvim",
	sysmonitor = "btop",
	explorer = "yazi",
	browser = "firefox",
	discord = "vesktop",
	email = "betterbird",
	spotify = "spotify_player",
}

local function noctalia(cmd)
	return hl.dsp.exec_cmd(IPC .. " " .. cmd)
end

local function term(app)
	return hl.dsp.exec_cmd(apps.terminal .. " -e " .. app)
end

-- Noctalia Shell — Core
hl.bind(MOD .. " + SPACE", noctalia("launcher toggle"), { description = "Noctalia launcher" })
hl.bind(MOD .. " + ESCAPE", noctalia("controlCenter toggle"), { description = "Noctalia control center" })
hl.bind(MOD .. " + COMMA", noctalia("settings toggle"), { description = "Noctalia settings panel" })

-- Media & Brightness
hl.bind(
	"XF86AudioRaiseVolume",
	noctalia("volume increase"),
	{ repeating = true, locked = true, description = "Raise volume" }
)
hl.bind(
	"XF86AudioLowerVolume",
	noctalia("volume decrease"),
	{ repeating = true, locked = true, description = "Lower volume" }
)
hl.bind("XF86AudioMute", noctalia("volume muteOutput"), { locked = true, description = "Mute volume" })
hl.bind(MOD .. " + ALT + LEFT", noctalia("media previous"), { locked = true, description = "Previous song" })
hl.bind(MOD .. " + ALT + RIGHT", noctalia("media next"), { locked = true, description = "Next song" })
hl.bind(MOD .. " + ALT + SPACE", noctalia("media playPause"), { locked = true, description = "Play/pause song" })
hl.bind(
	"XF86MonBrightnessUp",
	noctalia("brightness increase"),
	{ repeating = true, locked = true, description = "Raise brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	noctalia("brightness decrease"),
	{ repeating = true, locked = true, description = "Lower brightness" }
)

-- Noctalia Shell — System Utils
hl.bind(MOD .. " + P", noctalia("plugin:screen-shot-and-record screenshot"), { description = "Screenshot region" })
hl.bind(MOD .. " + R", noctalia("plugin:screen-shot-and-record recordsound"), { description = "Record region" })
hl.bind(MOD .. " + CTRL + L", noctalia("lockScreen lock"), { description = "Lock computer" })

hl.bind(MOD .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }), { description = "Universal copy" })
hl.bind(MOD .. " + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), { description = "Universal paste" })
hl.bind(MOD .. " + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }), { description = "Universal cut" })

-- Noctalia Shell — Menus & Tools
hl.bind(MOD .. " + B", noctalia("plugin:keybind-cheatsheet toggle"), { description = "Keybind cheatsheet" })
hl.bind(MOD .. " + S", noctalia("plugin:screen-toolkit toggle"), { description = "Screen toolkit" })
hl.bind(MOD .. " + SHIFT + C", noctalia("plugin:screen-toolkit colorPicker"), { description = "Color picker" })
hl.bind(MOD .. " + M", noctalia("plugin:screen-toolkit measure"), { description = "Measure screen" })
hl.bind(MOD .. " + Y", noctalia("launcher clipboard"), { description = "Clipboard history" })
hl.bind(MOD .. " + E", noctalia("launcher emoji"), { description = "Emojis" })
hl.bind(MOD .. " + DELETE", noctalia("systemMonitor toggle"), { description = "System monitor" })
hl.bind("CTRL + ALT + DELETE", noctalia("sessionMenu toggle"), { description = "Power menu" })

-- App Launchers
hl.bind(MOD .. " + RETURN", hl.dsp.exec_cmd(apps.terminal), { description = "Terminal" })
hl.bind(MOD .. " + SHIFT + F", term(apps.explorer), { description = "File explorer" })
hl.bind(MOD .. " + SHIFT + N", term(apps.editor), { description = "Text editor" })
hl.bind(MOD .. " + SHIFT + B", hl.dsp.exec_cmd(apps.browser), { description = "Web browser" })
hl.bind(MOD .. " + SHIFT + D", hl.dsp.exec_cmd(apps.discord), { description = "Discord" })
hl.bind(MOD .. " + SHIFT + E", hl.dsp.exec_cmd(apps.email), { description = "Email" })
hl.bind(MOD .. " + SHIFT + M", term(apps.spotify), { description = "Spotify" })

hl.bind(
	MOD .. " + XF86AudioMute",
	hl.dsp.exec_cmd(apps.discord .. " --toggle-mic"),
	{ description = "Toggle mic (Discord)" }
)
hl.bind(
	MOD .. " + SHIFT + XF86AudioMute",
	hl.dsp.exec_cmd(apps.discord .. " --toggle-deafen"),
	{ description = "Toggle deafen (Discord)" }
)

-- Window Management
hl.bind(MOD .. " + W", hl.dsp.window.kill(), { description = "Close focused window" })
hl.bind(MOD .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(MOD .. " + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })

local dirs = {
	{ key = "LEFT", vim = "H", dir = "l", label = "left" },
	{ key = "RIGHT", vim = "L", dir = "r", label = "right" },
	{ key = "UP", vim = "K", dir = "u", label = "up" },
	{ key = "DOWN", vim = "J", dir = "d", label = "down" },
}

for _, d in ipairs(dirs) do
	hl.bind(MOD .. " + " .. d.key, hl.dsp.focus({ direction = d.dir }), { description = "Focus " .. d.label })
	hl.bind(
		MOD .. " + " .. d.vim,
		hl.dsp.focus({ direction = d.dir }),
		{ description = "Focus " .. d.label .. " (vim)" }
	)
	hl.bind(
		MOD .. " + SHIFT + " .. d.key,
		hl.dsp.window.move({ direction = d.dir }),
		{ description = "Move window " .. d.label }
	)
	hl.bind(
		MOD .. " + SHIFT + " .. d.vim,
		hl.dsp.window.move({ direction = d.dir }),
		{ description = "Move window " .. d.label .. " (vim)" }
	)
end

hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = "Cycle focus forward" })
hl.bind("SHIFT + ALT + Tab", hl.dsp.window.cycle_next({ prev = true }), { description = "Cycle focus back" })

hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Hold to move window" })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Hold to resize window" })

-- Layout
hl.bind(MOD .. " + G", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(MOD .. " + CTRL + G", hl.dsp.layout("swapsplit"), { description = "Swap split" })

-- Workspaces
for i = 1, 5 do
	hl.bind(MOD .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "Go to workspace " .. i })
	hl.bind(
		MOD .. " + SHIFT + " .. i,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end
