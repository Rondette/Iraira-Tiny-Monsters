shader_type canvas_item;

uniform float height = 6.0;
uniform float frequency = 20.0;
uniform float speed = 3.0;
uniform float slide_div = 150.0;
uniform float slide_speed = 3.0;
uniform float slide_height = 6.0;
uniform bool y_slide = false;
uniform bool x_slide = false;
void vertex() {
VERTEX.x += height * cos((frequency/2.0 * UV.y) + (speed * TIME));
if (y_slide == true){
	VERTEX.y += slide_height * tan((frequency/slide_div * UV.x) + (slide_speed * TIME));
}
if (x_slide == true){
	VERTEX.x += slide_height * tan((frequency/slide_div * UV.y) + (slide_speed * TIME));
}
}
//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
