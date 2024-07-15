extends SpinBox

# TODO: this setting needs to be removed due to its broken nature

#func _on_Scale_value_changed(value):
	#var resolution = get_window().size
	#if ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)): resolution = DisplayServer.screen_get_size()
	#Rhythia.render_scale = value
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_IGNORE, resolution * value)
#
#func viewport_size_changed():
	#var resolution = get_window().size
	#if ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)): resolution = DisplayServer.screen_get_size()
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_IGNORE, resolution * Rhythia.render_scale)
	#
## func _ready():
##	get_tree().get_root().connect("size_changed", self, "viewport_size_changed")
##	connect("changed", self, "_on_Scale_value_changed")
##	value = Rhythia.render_scale
##	viewport_size_changed()
