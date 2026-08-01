// iris.gdshader
shader_type canvas_item;
uniform float radius : hint_range(0.0, 1.5) = 1.5;
uniform vec2  center = vec2(0.5, 0.5);

void fragment() {
    float dist = length(UV - center);
    COLOR = vec4(0.0, 0.0, 0.0, step(radius, dist));
}