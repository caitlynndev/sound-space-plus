extends ColorRect
class_name FileSelector2D

var use_native:bool = false

var target_object:Object
var target_method:String
var cancel_method:String

func save_sel(file:String):
	if target_object and target_object != self:
		target_object.call(target_method,file)
		target_object = self
		visible = false

func files_single(file:String):
	if target_object and target_object != self:
		target_object.call(target_method,PackedStringArray([file]))
		target_object = self
		visible = false

func files_sel(files:PackedStringArray):
	if target_object and target_object != self:
		target_object.call(target_method,files)
		target_object = self
		visible = false

func folder_sel(folder:String):
	if target_object and target_object != self:
		target_object.call(target_method,folder)
		target_object = self
		visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	if (
		!ProjectSettings.get_setting("application/config/disable_native_file_dialogs") and
		$OpenFile.has_signal("files_selected") and
		$SaveFile.has_signal("file_selected") and
		$Folder.has_signal("folder_selected")
	):
		use_native = true
		$OpenFile.connect("files_selected", Callable(self, "files_sel"))
		$SaveFile.connect("file_selected", Callable(self, "save_sel"))
		$Folder.connect("folder_selected", Callable(self, "folder_sel"))
		
		$Spinner.visible = true
		$Label.visible = true
	else:
		$C/SaveFile.connect("file_selected", Callable(self, "save_sel"))
		$C/OpenFile.connect("file_selected", Callable(self, "files_single"))
		$C/OpenFile.connect("files_selected", Callable(self, "files_sel"))
		$C/Folder.connect("dir_selected", Callable(self, "folder_sel"))
		
		$C/OpenFile.connect("hide", Callable(self, "files_sel").bind(PackedStringArray()))
		$C/SaveFile.connect("hide", Callable(self, "save_sel").bind(""))
		$C/Folder.connect("hide", Callable(self, "folder_sel").bind(""))
		
		$Spinner.visible = false
		$Label.visible = false


func open_file(
	obj:Object,
	method:String,
	filters:PackedStringArray = PackedStringArray(["* ; All Files"]),
	multiselect:bool = false,
	initial_path:String = "user://"
):
	target_object = obj
	target_method = method
	
	$C/OpenFile.pivot_offset = get_viewport_rect().size / 2
	$C/OpenFile.scale = Vector2(clamp(Rhythia.render_scale,0.5,1), clamp(Rhythia.render_scale,0.5,1))
	
	if use_native:
		$OpenFile.filters = filters
		$OpenFile.multiselect = multiselect
		$OpenFile.initial_path = Globals.p(initial_path)
		if multiselect:
			$OpenFile.title = "Select files..."
		else:
			$OpenFile.title = "Select file..."
		$OpenFile.show()
	
	else:
		$C/OpenFile.filters = filters
		if multiselect:
			$C/OpenFile.mode = $C/OpenFile.FILE_MODE_OPEN_FILES
			$C/OpenFile.window_title = "Select files..."
		else:
			$C/OpenFile.mode = $C/OpenFile.FILE_MODE_OPEN_FILE
			$C/OpenFile.window_title = "Select file..."
		$C/OpenFile.show()
		$C/OpenFile.call_deferred("set_current_dir",Globals.p(initial_path))
	visible = true
	move_to_front()

func save_file(
	obj:Object,
	method:String,
	filters:PackedStringArray = PackedStringArray(["* ; All Files"]),
	initial_path:String = "user://"
):
	target_object = obj
	target_method = method
	
	$C/OpenFile.pivot_offset = get_viewport_rect().size / 2
	$C/OpenFile.scale = Vector2(clamp(Rhythia.render_scale,0.5,1), clamp(Rhythia.render_scale,0.5,1))
	
	if use_native:
		$SaveFile.filters = filters
		$SaveFile.initial_path = Globals.p(initial_path)
		$SaveFile.show()
	
	else:
		$C/SaveFile.filters = filters
		$C/SaveFile.show()
		$C/SaveFile.call_deferred("set_current_dir",Globals.p(initial_path))
	visible = true
	move_to_front()

func open_folder(
	obj:Object,
	method:String,
	initial_path:String = "user://"
):
	target_object = obj
	target_method = method
	
	if use_native:
		$Folder.initial_path = Globals.p(initial_path)
		$Folder.show()
	
	else:
		$C/Folder.show()
		$C/Folder.call_deferred("set_current_dir",Globals.p(initial_path))
	visible = true
	move_to_front()
