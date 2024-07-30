extends Control

func _on_Pause_pressed():
	Input.action_press("pause")
	
func _on_Pause_released():
	Input.action_release("pause")
	
func _on_GiveUp_pressed():
	Input.action_press("give_up")
	
func _on_GiveUp_released():
	Input.action_release("give_up")

func _ready():
	var tween:Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	$Pause/Button.visible = OS.has_feature("Android")
	$GiveUp/Button.visible = OS.has_feature("Android")
	
	if Rhythia.mirror_buttons:
		$Pause/Button.position.x = DisplayServer.get_display_safe_area().size.x - 150
		$GiveUp/Button.position.x = DisplayServer.get_display_safe_area().size.x - 150
	
	tween.tween_interval(1)
	tween.parallel().tween_property($Pause, "modulate", Color(1,1,1,0), 1)
	tween.parallel().tween_property($GiveUp, "modulate", Color(1,1,1,0), 1)
	tween.play()
