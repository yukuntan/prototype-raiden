shader_type canvas_item;

uniform float time_factor : hint_range(0.1, 5);
uniform vec2 amplitude = vec2(10.0, 5.0);

void vertex()
{
	VERTEX.x += cos(TIME * time_factor + VERTEX.x + VERTEX.y) * amplitude.x;
	VERTEX.y += sin(TIME * time_factor + VERTEX.y + VERTEX.x) * amplitude.y;
}