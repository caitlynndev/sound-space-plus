shader_type spatial;
render_mode blend_mix,cull_back,depth_prepass_alpha,diffuse_burley,specular_disabled,unshaded;

uniform bool use_image = true;
uniform sampler2D image;

float cc(float x) {
	return pow(x, 2.2);
}

vec4 colconv(vec4 a) {
	return vec4(
		cc(a.r),
		cc(a.g),
		cc(a.b),
		a.a
	);
}

void fragment() {
	vec2 base_uv = UV;
	vec4 img = vec4(1.0);
	if (use_image) {
		img = texture(image,UV);
	}

	vec4 col = colconv(COLOR);
	ALBEDO = col.rgb * img.rgb;
	ALPHA = col.a*img.a;
}
