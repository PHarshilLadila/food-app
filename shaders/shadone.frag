#version 300 es
precision highp float;

uniform vec2 u_resolution;
uniform float u_time;
out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    // Scale UV to center and normalize aspect ratio
    uv -= 0.5;
    uv.x *= u_resolution.x / u_resolution.y;

    // Define a harmonious pastel color palette
    vec3 color1 = vec3(168.0/255.0, 218.0/255.0, 220.0/255.0); // #A8DADC (Light Blue)
    vec3 color2 = vec3(255.0/255.0, 221.0/255.0, 210.0/255.0); // #FFDDD2 (Soft Peach)
    vec3 color3 = vec3(216.0/255.0, 191.0/255.0, 216.0/255.0); // #D8BFD8 (Lavender Mist)
    vec3 color4 = vec3(250.0/255.0, 237.0/255.0, 205.0/255.0); // #FAEDCD (Mellow Yellow)
    vec3 color5 = vec3(183.0/255.0, 228.0/255.0, 199.0/255.0); // #B7E4C7 (Mint Green)

    // Create a dynamic color blend effect using sine waves
    float t = u_time * 0.8;
    float glow = 0.5 + 0.5 * sin(t + length(uv) * 8.0);
    
    vec3 blend1 = mix(color1, color2, glow);
    vec3 blend2 = mix(color3, color4, glow);
    vec3 finalColor = mix(blend1, blend2, sin(t * 0.5)) * color5;

    fragColor = vec4(finalColor, 1.0);
}
