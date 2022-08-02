shader_type canvas_item;

uniform float scan_line_count : hint_range(0, 1000) = 50;
const float PI = 3.14159;

vec2 uv_curve(vec2 uv) {
	uv = (uv-0.5) * 2.0;
	uv.x *= 1.0 + pow(abs(uv.y) / 4.0, 2.0);
	uv.y *= 1.0 + pow(abs(uv.x) / 3.5, 2.0);
	uv = (uv / 2.0) + 0.5;
	return uv;
}

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float s = sin(uv_curve(SCREEN_UV).y * scan_line_count * PI * 2.0);
	s = (s * 0.5 + 0.5) * 0.9 + 0.1;
	
	vec4 scan_line = vec4(vec3(pow(s, 0.25)), 1.0);
	
	COLOR = color * COLOR * scan_line;
}