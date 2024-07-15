extends Node3D

var colors:Array = Rhythia.selected_colorset.colors

func hit(noteColor:Color):
	pass

func _ready():
	get_parent().get_node("Game").connect("hit", Callable(self, "hit"))
	# Shaders
	var env = get_node("WorldEnvironment").environment
	if Rhythia.glow > 0:
		env.glow_enabled = true
		env.glow_intensity = Rhythia.glow
		env.glow_strength = 1
		env.glow_bloom = Rhythia.bloom
		env.glow_blend_mode = 1
		env.glow_hdr_scale = 1.72
		env.glow_high_quality = true
		env.glow_bicubic_upscale = true
