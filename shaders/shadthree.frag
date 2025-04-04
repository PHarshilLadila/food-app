#version 300 es
precision highp float;

uniform vec2 u_resolution;
uniform float u_time;

out vec4 fragColor;

void main() {
    // Normalize pixel coordinates (-1 to 1)
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy) * 2.0 - 1.0;
    uv.x *= u_resolution.x / u_resolution.y; // Maintain aspect ratio

    // Create a swirling vortex effect
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    
    // Animate rotation over time
    float swirl = sin(angle * 5.0 + u_time) * 0.3;
    float wave = cos(radius * 10.0 - u_time * 3.0) * 0.2;
    
    // Light pastel color palette
    vec3 color1 = vec3(150.0/255.0, 223.0/255.0, 206.0/255.0); // #96DFCE (Mint Green)
    vec3 color2 = vec3(230.0/255.0, 236.0/255.0, 239.0/255.0); // #DDECEF (Soft Cyan)
    vec3 color3 = vec3(248.0/255.0, 213.0/255.0, 219.0/255.0); // #F8D5DB (Pastel Pink)
    vec3 color4 = vec3(239.0/255.0, 241.0/255.0, 217.0/255.0); // #EFF1D9 (Light Olive)
    vec3 color5 = vec3(241.0/255.0, 235.0/255.0, 134.0/255.0); // #F1EB86 (Soft Yellow)

    // Smooth transition between colors based on swirl and wave
    float blend1 = (swirl + wave) * 0.5 + 0.5;
    float blend2 = sin(u_time * 0.5 + radius * 5.0) * 0.5 + 0.5;

    // Gradient blending effect
    vec3 mix1 = mix(color1, color2, blend1);
    vec3 mix2 = mix(color3, color4, blend2);
    vec3 finalColor = mix(mix1, mix2, sin(u_time * 0.3));

    fragColor = vec4(finalColor, 1.0);
}
