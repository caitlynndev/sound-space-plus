extends Button

func _pressed():
	get_tree().change_scene_to_file("res://scenes/menu/AvatarEditor.tscn")
