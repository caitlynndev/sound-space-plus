shader_type spatial;
render_mode blend_mix,cull_back,depth_prepass_alpha,diffuse_burley,specular_disabled,unshaded;
uniform vec4 notecolor : source_color = vec4(1,1,1,1);

uniform float alpha_multi = 1;
uniform float fade = 1;

uniform bool use_image = false;
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
//	if (col.a >= 0.5) {
//		ALBEDO = vec3(0.0, 1.0 - (2.0 * (col.a - 0.5)), (2.0 * (col.a - 0.5)))
//	} else {
//		ALBEDO = vec3(1.0 - (2.0 * col.a), (2.0 * col.a), 0.0)
//	}
	ALBEDO = col.rgb * img.rgb;
//	ALBEDO = vec3(col.r, col.a, float(col.a >= 1.0 || col.a == 0.0));
	//ALBEDO = vec3(1.0 - col.a, col.a, 0.0);
	ALPHA = col.a*img.a*alpha_multi;/*COLOR.a * */
}
