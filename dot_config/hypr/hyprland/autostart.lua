hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")

	hl.exec_cmd("hyprpm reload")

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("wl-clip-persist --clipboard regular")

	hl.exec_cmd("easyeffects --service-mode")

	hl.exec_cmd("v4l2-ctl -d /dev/video0 --set-ctrl=focus_automatic_continuous=0")

	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("hyprctl reload")
end)
