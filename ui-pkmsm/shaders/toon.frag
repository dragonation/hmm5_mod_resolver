#include <packing>

varying vec2 fragUV;

uniform float ux;
uniform float uy;

uniform sampler2D layer;
uniform sampler2D layer2;
uniform sampler2D layer3;
uniform sampler2D layer4;
uniform sampler2D layer5;

uniform float cameraNear;
uniform float cameraFar;

uniform bool noOutline;

uniform vec4 backgroundColor;

vec2 readDepth(sampler2D depth, vec2 uv) {

    vec4 values = texture2D(depth, vec2(uv.x, uv.y));

    float depthValue = 255.0;
    if (values.r >= 0.5) {
        depthValue = 127.0 * 2.0 * (values.r - 0.5) + values.g + values.b * 0.00392157;
    }

    return vec2(depthValue * 0.00392157, values.a);

}

float analyzeEdge(vec2 z00, vec2 z01, vec2 z02, vec2 z10, vec2 z11, vec2 z12, vec2 z20, vec2 z21, vec2 z22) {
   
    float x = z20.x + 1.4 * z21.x + z22.x - z00.x - 1.4 * z01.x - z02.x;
    float y = z02.x + 1.4 * z12.x + z22.x - z00.x - 1.4 * z10.x - z20.x;

    // TODO: make it input from js
    float fov = 50.0 / 180.0 * 3.14159;

    float d = z11.x * (cameraFar - cameraNear) + cameraNear;
    float n = ((z11.y - 0.5) * 2.0);
    float m = sqrt(1.0 - n * n);

    float diff = m / n * d * fov * (ux + uy) * 0.5 * 0.005; // 0 ~ 0.01 

    float result = sqrt(x * x + y * y) * 200.0;
    if ((result < 0.3) || (result < diff)) {
        result = 0.0;
    } else {
        float c = 0.0;
        c += (z11.x - z00.x);
        c += (z11.x - z01.x);
        c += (z11.x - z02.x);
        c += (z11.x - z10.x);
        c += (z11.x - z12.x);
        c += (z11.x - z20.x);
        c += (z11.x - z21.x);
        c += (z11.x - z22.x);
        if ((c <= 0.000001) && (ux >= 0.0009) && (uy >= 0.0009)) {
            // shrink edge if image is small
            result = 0.0;
        } else {
            if (result > 0.8) {
                result = 1.0;
            } else {
                result = (result - 0.3) * 2.0;
            } 
        }
    }

    return result;  
}

float getEdge(sampler2D depth, vec2 uv) {

    vec2 z00 = readDepth(depth, vec2(uv.x - ux, uv.y - uy));
    vec2 z01 = readDepth(depth, vec2(uv.x - ux, uv.y));
    vec2 z02 = readDepth(depth, vec2(uv.x - ux, uv.y + uy));
    vec2 z03 = readDepth(depth, vec2(uv.x - ux, uv.y + uy + uy));
    vec2 z10 = readDepth(depth, vec2(uv.x, uv.y - uy));
    vec2 z11 = readDepth(depth, vec2(uv.x, uv.y));
    vec2 z12 = readDepth(depth, vec2(uv.x, uv.y + uy));
    vec2 z13 = readDepth(depth, vec2(uv.x, uv.y + uy + uy));
    vec2 z20 = readDepth(depth, vec2(uv.x + ux, uv.y - uy));
    vec2 z21 = readDepth(depth, vec2(uv.x + ux, uv.y));
    vec2 z22 = readDepth(depth, vec2(uv.x + ux, uv.y + uy));
    vec2 z23 = readDepth(depth, vec2(uv.x + ux, uv.y + uy + uy));
    vec2 z30 = readDepth(depth, vec2(uv.x + ux + ux, uv.y - uy));
    vec2 z31 = readDepth(depth, vec2(uv.x + ux + ux, uv.y));
    vec2 z32 = readDepth(depth, vec2(uv.x + ux + ux, uv.y + uy));
    vec2 z33 = readDepth(depth, vec2(uv.x + ux + ux, uv.y + uy + uy));

    float e00 = analyzeEdge(z00, z01, z02, z10, z11, z12, z20, z21, z22);
    float e01 = analyzeEdge(z01, z02, z03, z11, z12, z13, z21, z22, z23);
    float e10 = analyzeEdge(z10, z11, z12, z20, z21, z22, z30, z31, z32);
    float e11 = analyzeEdge(z11, z12, z13, z21, z22, z23, z31, z32, z33);

    return (e00 + e01 + e10 + e11) * 0.25;

}

vec4 getPixel(vec2 uv) {

    float z = clamp(getEdge(layer, uv), 0.0, 1.0);
    float z2 = clamp(getEdge(layer2, uv), 0.0, 1.0);
    float z3 = clamp(getEdge(layer3, uv), 0.0, 1.0);
    float edge = clamp((z + z2 * 0.25 + z3 * 0.7), 0.0, 1.0) * 0.7;

    vec4 pixel00 = texture2D(layer4, uv);
    vec4 pixel01 = texture2D(layer4, vec2(uv.x, uv.y + uy));
    vec4 pixel10 = texture2D(layer4, vec2(uv.x + ux, uv.y));
    vec4 pixel11 = texture2D(layer4, vec2(uv.x + ux, uv.y + uy));
    vec4 pixel = (pixel00 + pixel01 + pixel10 + pixel11) * 0.25;
    pixel.rgb = pixel.rgb + 1.0 - pixel.a;
    pixel.a = 1.0;

    vec4 pixel200 = texture2D(layer5, uv);
    vec4 pixel201 = texture2D(layer5, vec2(uv.x, uv.y + uy));
    vec4 pixel210 = texture2D(layer5, vec2(uv.x + ux, uv.y));
    vec4 pixel211 = texture2D(layer5, vec2(uv.x + ux, uv.y + uy));
    vec4 pixel2 = (pixel200 + pixel201 + pixel210 + pixel211) * 0.25;
    pixel2.rgb = pixel2.rgb + 1.0 - pixel2.a;
    pixel2.a = 1.0;

    // restore color and alpha from pixels to make blending works in normal

    vec3 color = vec3(
        pixel2.r / (pixel2.r - pixel.r + 1.0),
        pixel2.g / (pixel2.g - pixel.g + 1.0),
        pixel2.b / (pixel2.b - pixel.b + 1.0));
    float alpha = (pixel2.r + pixel2.g + pixel2.b - pixel.r - pixel.g - pixel.b) / 3.0 + 1.0;

    if ((edge > 0.0) && (!noOutline)) {
        color = color * (1.0 - edge);
        alpha = alpha + (1.0 - alpha) * edge;
    }
   
    if (alpha > 0.0) {
        color.rgb = color.rgb * alpha + backgroundColor.rgb * backgroundColor.a * (1.0 - alpha);
    } else {
        color.rgb = backgroundColor.rgb * backgroundColor.a * (1.0 - alpha);
    }
    alpha = alpha + (1.0 - alpha) * backgroundColor.a;

    return vec4(color, alpha);
    
}

void main() {
    gl_FragColor = getPixel(fragUV);
}
