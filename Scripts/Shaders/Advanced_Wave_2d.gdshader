shader_type canvas_item;

// Ripple parameters
uniform float speed : hint_range(0.0, 10.0, 0.1) = 3.0;
uniform float height : hint_range(0.0, 100.0, 0.001) = 0.5;
uniform float wave_count : hint_range(1.0, 200.0, 0.1) = 10.0;
uniform float edge_intensity : hint_range(0.0, 2.0, 0.01) = 1.0;
uniform float alpha_intensity : hint_range(0.0, 1.0, 0.01) = 1.0; // Control alpha intensity

uniform float frequency = 20.0;

uniform float circle_size : hint_range(0.0, 1.0) = 0.4;
uniform float ratio_width = 1.0;
uniform float ratio_height = 1.0;
void vertex() {
    // Vertex displacement based on distance from center
    vec2 cPos = VERTEX.xy - vec2(0.0, 0.0); // Adjust if needed for center
    float cLength = length(cPos);

    // Edge-based ripple effect
    float edge_factor = smoothstep(0.0, 1.0, cLength) * edge_intensity;
    float ripple_effect = sin(cLength * wave_count - TIME * speed) * height * edge_factor;

    VERTEX.xy += ripple_effect*10.0; // Displace along z-axis for depth effect
	VERTEX.y += height * sin((frequency * UV.x) + (speed * TIME));
}

void fragment() {
    vec2 cPos = UV - vec2(0.5, 0.5);
    float cLength = length(cPos);

    // Ripple effect for UV
    vec2 ripple_offset = (cPos / cLength) * sin(cLength * wave_count - TIME * speed) * height;
    vec2 uv = UV + ripple_offset;

    // Sample texture and adjust color with alpha
    vec4 texture_color = texture(TEXTURE, uv);
    float alpha = texture_color.a * alpha_intensity; // Apply alpha based on texture and uniform
    COLOR = vec4(texture_color.rgb, alpha);

	float ratio = ratio_width / ratio_height;
	float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	vec4 orig_color = texture(TEXTURE, UV);
	COLOR.rgb *= orig_color.rgb;
	COLOR.a *= (1.0 - step(circle_size, dist)) * orig_color.a;
}
