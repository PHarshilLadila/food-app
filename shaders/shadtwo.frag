#version 300 es
precision highp float;

uniform vec2 u_resolution;
uniform float u_time;
out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    // Center and normalize aspect ratio
    uv -= 0.8;
    uv.x *= u_resolution.x / u_resolution.y;

    // Create radial wave pattern
    float wave = sin(10.0 * length(uv) - u_time * 2.0);
    float ripple = cos(5.0 * (uv.x * uv.y) + u_time * 3.0);

    // Combine effects
    float pattern = mix(wave, ripple, 0.8);
    
    // Define soft golden glow with purple highlights
    vec3 color1 = vec3(1.0, 0.8, 0.5); // Warm golden tone
    vec3 color2 = vec3(0.6, 0.3, 1.0); // Soft purple
    vec3 finalColor = mix(color1, color2, pattern * 0.5 + 0.5);

    fragColor = vec4(finalColor, 1.0);
}
