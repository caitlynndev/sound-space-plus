extends Sprite2D

func _input(event):
	if event is InputEventMouse:
		position = event.position

func _ready():
	visible = Rhythia.vr
