extends Button

@export var target: String = "cursor"
@export var default_image: Texture2D

enum KIND {
	IMAGE,
	SOUND
}

@export var kind: KIND = KIND.IMAGE

var copy_old_from:String

func save_sel(file:String):
	DirAccess.copy_absolute(copy_old_from,file)

func load_img():
	var tex = Globals.imageLoader.load_if_exists("user://" + target)
	if tex:
		$ImgPreview.texture = tex
		$Clear.disabled = false
	else:
		$ImgPreview.texture = default_image
		$Clear.disabled = true

func rename_old(ext:String):
	var dt = Time.get_datetime_dict_from_system()
	copy_old_from = Globals.p("user://%s.%s" % [target,ext])
	Globals.file_sel.save_file(
		self,
		"save_sel",
		[ "*.%s ; %s file" % [ext,ext] ],
		#"~/Downloads/%s.%s" % [target,ext]
		OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/%s.%s" % [target,ext]
	)

func reset_to_default():
	if kind == KIND.IMAGE:
		Globals.confirm_prompt.open(
			"Are you sure? This can't be undone!",
			"Remove Custom Asset",
			[
				{ text = "Cancel" },
				{ text = "Save old image" },
				{ text = "OK", wait = 2 }
			]
		)
		var response:int = await Globals.confirm_prompt.option_selected
		while response == 1:
			if FileAccess.file_exists(Globals.p("user://%s.png" % target)): rename_old("png")
			elif FileAccess.file_exists(Globals.p("user://%s.jpg" % target)): rename_old("jpg")
			elif FileAccess.file_exists(Globals.p("user://%s.jpeg" % target)): rename_old("jpeg")
			elif FileAccess.file_exists(Globals.p("user://%s.webp" % target)): rename_old("webp")
			elif FileAccess.file_exists(Globals.p("user://%s.bmp" % target)): rename_old("bmp")
			response = await Globals.confirm_prompt.option_selected
		if response == 2:
			if FileAccess.file_exists(Globals.p("user://%s.png" % target)): DirAccess.remove_absolute(Globals.p("user://%s.png" % target))
			elif FileAccess.file_exists(Globals.p("user://%s.jpg" % target)): DirAccess.remove_absolute(Globals.p("user://%s.jpg" % target))
			elif FileAccess.file_exists(Globals.p("user://%s.jpeg" % target)): DirAccess.remove_absolute(Globals.p("user://%s.jpeg" % target))
			elif FileAccess.file_exists(Globals.p("user://%s.webp" % target)): DirAccess.remove_absolute(Globals.p("user://%s.webp" % target))
			elif FileAccess.file_exists(Globals.p("user://%s.bmp" % target)): DirAccess.remove_absolute(Globals.p("user://%s.bmp" % target))
			
			load_img()
		else: print("canceled")
		Globals.confirm_prompt.close()
	else:
		pass

func sel(files:Array):
	if files.size() != 0:
		if kind == KIND.IMAGE:
			Globals.confirm_prompt.open(
				"Are you sure? This will overwrite the previous image!",
				"Replace Custom Asset",
				[
					{ text = "Cancel" },
					{ text = "Save old image" },
					{ text = "OK", wait = 2 }
				]
			)
			var response:int = await Globals.confirm_prompt.option_selected
			while response == 1:
				if FileAccess.file_exists(Globals.p("user://%s.png" % target)): rename_old("png")
				elif FileAccess.file_exists(Globals.p("user://%s.jpg" % target)): rename_old("jpg")
				elif FileAccess.file_exists(Globals.p("user://%s.jpeg" % target)): rename_old("jpeg")
				elif FileAccess.file_exists(Globals.p("user://%s.webp" % target)): rename_old("webp")
				elif FileAccess.file_exists(Globals.p("user://%s.bmp" % target)): rename_old("bmp")
				response = await Globals.confirm_prompt.option_selected
			if response == 2:			
				if FileAccess.file_exists(Globals.p("user://%s.png" % target)): DirAccess.remove_absolute(Globals.p("user://%s.png" % target))
				elif FileAccess.file_exists(Globals.p("user://%s.jpg" % target)): DirAccess.remove_absolute(Globals.p("user://%s.jpg" % target))
				elif FileAccess.file_exists(Globals.p("user://%s.jpeg" % target)): DirAccess.remove_absolute(Globals.p("user://%s.jpeg" % target))
				elif FileAccess.file_exists(Globals.p("user://%s.webp" % target)): DirAccess.remove_absolute(Globals.p("user://%s.webp" % target))
				elif FileAccess.file_exists(Globals.p("user://%s.bmp" % target)): DirAccess.remove_absolute(Globals.p("user://%s.bmp" % target))
				
				DirAccess.copy_absolute(files[0],Globals.p("user://%s.%s" % [target,files[0].get_extension()]))
				
				load_img()
			else: print("canceled")
			Globals.confirm_prompt.close()
		else:
			pass

func _pressed():
	if kind == KIND.IMAGE:
		Globals.file_sel.open_file(self,"sel",PackedStringArray(["*.png, *.jpg, *.jpeg, *.webp, *.bmp ; Image files"]))

func _ready():
	$Clear.connect("pressed", Callable(self, "reset_to_default"))
	if kind == KIND.IMAGE:
		$ImgPreview.visible = true
		load_img()
	else:
		$ImgPreview.visible = false
