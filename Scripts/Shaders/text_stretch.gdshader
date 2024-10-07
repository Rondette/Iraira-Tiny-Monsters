shader_type canvas_item;

uniform float distance = 6.0;
uniform float frequency = 20.0;
uniform float speed = 3.0;
uniform bool more = false;
void vertex() {
 VERTEX.x += distance * abs(sin((frequency * UV.y) + (speed * TIME)));
if (more==true){
	VERTEX.y += distance * abs(sin((frequency * UV.x) + (speed * TIME)));
}
	
}