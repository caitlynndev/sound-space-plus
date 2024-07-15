extends CheckBox

func _pressed():
	if pressed != (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (pressed) else DisplayServer.VSYNC_DISABLED)

func _ready():
	pressed = (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)
