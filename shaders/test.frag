#version 300 es
precision highp float;

uniform vec2 u_resolution;
uniform float u_time;

out vec4 fragColor;

void main() {
     vec2 uv = gl_FragCoord.xy / u_resolution.xy;

      vec3 baseColor = vec3(0.9, 0.9, 1.0);   
    vec3 lightEffect = 0.6 + 0.4 * cos(u_time + uv.xyx + vec3(0.0, 2.0, 4.0));

     vec3 col = mix(baseColor, lightEffect, 0.5);

    // Output to screen with slightly increased brightness
    fragColor = vec4(col, 1.0);
}


  
// #version 300 es
// precision highp float;

// uniform vec2 u_resolution;
// uniform float u_time;

// out vec4 fragColor;

// void main() {
//     // Normalized pixel coordinates (from 0 to 1)
//     vec2 uv = gl_FragCoord.xy / u_resolution.xy;

//     // Time varying pixel color
//     vec3 col = 0.5 + 0.5 * cos(u_time + uv.xyx + vec3(0.0, 2.0, 4.0));

//     // Output to screen
//     fragColor = vec4(col, 1.0);
// }



// #version 300 es
// precision highp float;

// uniform vec2 u_resolution;
// uniform float u_time;

// out vec4 fragColor;

// void main() {
//     float strength = 0.4;
//     float t = u_time / 3.0;
    
//     vec3 col = vec3(0.0);
//     vec2 fragCoord = gl_FragCoord.xy;
//     vec2 fC = fragCoord;

//     #ifdef AA
//     for(int i = -1; i <= 1; i++) {
//         for(int j = -1; j <= 1; j++) {
//             fC = fragCoord + vec2(i, j) / 50.0;
//     #endif

//             // Normalized pixel coordinates (from 0 to 1)
//             vec2 pos = fC / u_resolution.xy;

//             pos.y /= u_resolution.x / u_resolution.y;
//             pos = 4.0 * (vec2(0.5) - pos);

//             for (float k = 1.0; k < 50.0; k += 25.0) { 
//                 pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.50;
//                 pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
//             }

//             // Time varying pixel color
//             col += 0.5 + 0.5 * cos(u_time + pos.xyx + vec3(0.0, 2.0, 40.0));
    
//     #ifdef AA
//         }
//     }

//     col /= 9.0;
//     #endif
    
//     // Gamma correction
//     col = pow(col, vec3(0.4545));
    
//     // Fragment color
//     fragColor = vec4(col, 1.0);
// }


//--------------------------------------
// #version 300 es
// precision highp float;

// uniform vec2 u_resolution;
// uniform float u_time;

// out vec4 fragColor;

// void main() {
//     float t = u_time + 5.0;
//     float z = 6.0;
//     const int n = 100; // Particle count
    
//     vec3 startColor = vec3(0.0, 0.64, 0.2);
//     vec3 endColor = vec3(0.06, 0.35, 0.85);
    
//     float startRadius = 0.84;
//     float endRadius = 1.6;
    
//     float power = 0.51;
//     float duration = 4.0;
    
//     vec2 s = u_resolution.xy;
//     vec2 v = z * (2.0 * gl_FragCoord.xy - s) / s.y;
    
//     vec3 col = vec3(0.0);
//     vec2 pm = v.yx * 2.8;
    
//     float dMax = duration;
//     float evo = (sin(u_time * 0.01 + 400.0) * 0.5 + 0.5) * 99.0 + 1.0;
    
//     float mb = 0.0;
//     float mbRadius = 0.0;
//     float sum = 0.0;

//     for (int i = 0; i < n; i++) {
//         float d = fract(t * power + 48934.4238 * sin(float(i) / evo * 692.7398));
//         float a = 6.2831 * float(i) / float(n);
        
//         float x = d * cos(a) * duration;
//         float y = d * sin(a) * duration;
        
//         float distRatio = d / dMax;
//         mbRadius = mix(startRadius, endRadius, distRatio);
        
//         vec2 p = v - vec2(x, y);
//         mb = mbRadius / dot(p, p);
        
//         sum += mb;
//         col = mix(col, mix(startColor, endColor, distRatio), mb / sum);
//     }
    
//     sum /= float(n);
//     col = normalize(col) * sum;
//     sum = clamp(sum, 0.0, 0.4);
    
//     vec3 tex = vec3(1.0);
//     col *= smoothstep(tex, vec3(0.0), vec3(sum));
    
//     fragColor = vec4(col, 1.0);
// }

