extends Resource
class_name NoteEffect

@export var id: String
@export var name: String
@export var creator: String
@export var path: String # (String, FILE, "*.tscn")

func _init(idI:String, nameI:String, pathI:String, creatorI:String="Unknown"):
	id = idI
	name = nameI
	path = pathI
	creator = creatorI
