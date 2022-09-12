/*
    This is a magnifier shader written in Godot Shading Language which is similar to GLSL ES 3.0. 
    
    In order to get this shader working, you must attach this to a node with a texture.
    It might work with nodes without textures too, but isn't tested yet.
    
    Author is Yavuz Burak Yalçın @orbbloff
    
    MIT License
*/
shader_type canvas_item;

uniform float roundness:hint_range(0.0, 2.0) = 1.0;
uniform float circle_radius:hint_range(0.0, 0.71) = 0.45;
uniform float outline_thickness:hint_range(0.0, 0.1) = 0.005;
uniform vec4 outline_color:hint_color = vec4(0.09, 0.22, 0.6, 0.7);
uniform float blur_amount : hint_range(0, 5) = 2;

void fragment(){
	// Creates outline
	if(length(UV - vec2(0.5)) > circle_radius - outline_thickness){
		//COLOR = vec4(0.0); // Makes fragments transparent 
		COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
		if(length(UV - vec2(0.5)) < circle_radius){
			COLOR = outline_color;
		}
	}
}