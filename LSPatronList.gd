extends ReferenceRect
#
#func _ready():
	#var file:FileAccess = FileAccess.open("res://patreon3.txt",FileAccess.READ)
	#var err:int = FileAccess.get_open_error()
	#if err == OK: # will be FILE_NOT_FOUND if it doesn't exist
		#var txt:String = file.get_as_text()
		#file.close()
		#var patrons:Array = txt.split("\n",false)
		#if patrons.size() != 0: visible = true # don't show this if there aren't any
		#
		#for n in patrons:
			#var label:Label = $C/L/Label.duplicate()
			#$C/L.call_deferred("add_child",label)
			#label.text = n
			#label.visible = true
