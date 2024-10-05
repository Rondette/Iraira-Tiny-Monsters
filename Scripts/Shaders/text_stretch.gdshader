shader_type canvas_item;

uniform float distance = 6.0;
uniform float frequency = 20.0;
uniform float speed = 3.0;

void vertex() {
 VERTEX.x += distance * abs(sin((frequency * UV.y) + (speed * TIME)));
}