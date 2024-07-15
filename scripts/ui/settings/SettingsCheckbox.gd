extends CheckBox

@export var target: String

func upd():
#	print('scb "%s"' % name)
	button_pressed = Rhythia.get(target)
	
func _pressed():
	var a = Time.get_ticks_usec()
#	print('scb "%s" press' % name)
	if button_pressed != Rhythia.get(target):
		Rhythia.set(target,button_pressed)
#	print('scb "%s" press done, took %s usec' % [name,Globals.comma_sep(OS.get_ticks_usec() - a)])

func _ready():
	upd()
