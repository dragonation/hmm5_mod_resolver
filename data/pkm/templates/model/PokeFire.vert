// Type: Vertex Shader
// Shader Name: PokeFire
// Generated Date: 2018-01-11 11:20:57.451
// Comment: This file is just auto-generated from the raw decoded Nintendo3DS shader instructions to simulate shading via WebGL

varying vec4 fragPosition;                                                      // gpu_o0
varying vec4 fragQuaternionNormal;                                              // gpu_o1
varying vec4 fragView;                                                          // gpu_o2
varying vec4 fragColor;                                                         // gpu_o3
varying vec4 fragUV;                                                            // gpu_o4
varying vec4 fragUV2;                                                           // gpu_o5
varying vec4 fragUV3;                                                           // gpu_o6

varying float fragDepth;
varying vec4 fragNormal;

attribute vec4 position;                                                        // gpu_v0
attribute vec4 normal;                                                          // gpu_v1
attribute vec4 tangent;                                                         // gpu_v2
attribute vec4 color;                                                           // gpu_v3
attribute vec4 uv;                                                              // gpu_v4
attribute vec4 uv2;                                                             // gpu_v5
attribute vec4 skinIndex;                                                       // gpu_v7
attribute vec4 skinWeight;                                                      // gpu_v8
attribute vec4 geometryIndex;

uniform bool hasBoneW;                                                          // gpu_b11

uniform vec4 vectors[96];                                                       // gpu_c[96]
/* vectors[1] used, texture 0 transposed matrix[0] */
/* vectors[2] used, texture 0 transposed matrix[1] */
/* vectors[10] used, indexed transposed bone matrices[0][0] */
/* vectors[11] used, indexed transposed bone matrices[0][1] */
/* vectors[12] used, indexed transposed bone matrices[0][2] */
/* vectors[23] used, indexed transposed bone matrices[0][13] */
/* vectors[85] used, lack of detail usage information */
/* vectors[86] used, transposed projection matrix[0] */
/* vectors[87] used, transposed projection matrix[1] */
/* vectors[88] used, transposed projection matrix[2] */
/* vectors[89] used, transposed projection matrix[3] */
/* vectors[90] used, transposed view matrix[0] */
/* vectors[91] used, transposed view matrix[1] */
/* vectors[92] used, transposed view matrix[2] */

uniform vec4 worldScales;

vec4 gpu_r[16];
bvec2 gpu_cmp;

void func_0x000(const int gpu_r1_x);
void func_0x00a();

void func_0x000(const int gpu_r1_x) {
    /* used vectors[10], indexed transposed bone matrices[0][0] */
    /* used vectors[11], indexed transposed bone matrices[0][1] */
    /* used vectors[12], indexed transposed bone matrices[0][2] */
    /* used gpu_r1_x, array offset constant */                                  // 0x000: mova a0.x, r1.x;
                                                                                // 0x001: nop;
    gpu_r[3].x = dot(vectors[10 + gpu_r1_x], gpu_r[15]);                        // 0x002: dp4 r3.x, c10[a0.x], r15;
    gpu_r[3].y = dot(vectors[11 + gpu_r1_x], gpu_r[15]);                        // 0x003: dp4 r3.y, c11[a0.x], r15;
    gpu_r[3].z = dot(vectors[12 + gpu_r1_x], gpu_r[15]);                        // 0x004: dp4 r3.z, c12[a0.x], r15;
    gpu_r[4].x = dot(vectors[10 + gpu_r1_x].xyz, gpu_r[14].xyz);                // 0x005: dp3 r4.x, c10[a0.x].xyz, r14.xyz;
    gpu_r[4].y = dot(vectors[11 + gpu_r1_x].xyz, gpu_r[14].xyz);                // 0x006: dp3 r4.y, c11[a0.x].xyz, r14.xyz;
    gpu_r[4].z = dot(vectors[12 + gpu_r1_x].xyz, gpu_r[14].xyz);                // 0x007: dp3 r4.z, c12[a0.x].xyz, r14.xyz;
    gpu_r[7] = gpu_r[1].wwww * gpu_r[3] + gpu_r[7];                             // 0x008: mad r7, r1.wwww, r3, r7;
    gpu_r[12] = gpu_r[1].wwww * gpu_r[4] + gpu_r[12];                           // 0x009: mad r12, r1.wwww, r4, r12;
}

void func_0x00a() {
    /* used vectors[85] */
    /* used vectors[86], transposed projection matrix[0] */
    /* used vectors[87], transposed projection matrix[1] */
    /* used vectors[88], transposed projection matrix[2] */
    /* used vectors[89], transposed projection matrix[3] */
    /* used vectors[90], transposed view matrix[0] */
    /* used vectors[91], transposed view matrix[1] */
    /* used vectors[92], transposed view matrix[2] */
    // 7 position
    // 12 normal
    gpu_r[15].xyz = position.xyz;                                               // 0x00a: mov r15.xyz, v0.xyz;
    gpu_r[14].xyz = normal.xyz;                                                 // 0x00b: mov r14.xyz, v1.xyz;
    gpu_r[15].w = 1.0;                                                          // 0x00c: mov r15.w, c93.y;
    gpu_r[7] = vec4(0.0, 0.0, 0.0, 0.0);                                        // 0x00d: mov r7, c93.xxxx;
    gpu_r[12] = vec4(0.0, 0.0, 0.0, 0.0);                                       // 0x00e: mov r12, c93.xxxx;
    gpu_r[2] = vec4(3.0, 3.0, 3.0, 3.0) * skinIndex;                            // 0x00f: mul r2, c93.wwww, v7;
    gpu_cmp.x = 0.0 != skinWeight.z;                                            // 0x010: cmp c93.x != v8.z, c93.x != v8.w;
    gpu_cmp.y = 0.0 != skinWeight.w;
    gpu_r[1].xy = gpu_r[2].xx;                                                  // 0x011: mov r1.xy, r2.xx;
    gpu_r[1].w = 0.0039216 * skinWeight.x;                                      // 0x012: mul r1.w, c94.z, v8.x;
    func_0x000(int(gpu_r[1].x));                                                // 0x013: call 0x0, 0xa;
    gpu_r[1].xy = gpu_r[2].yy;                                                  // 0x014: mov r1.xy, r2.yy;
    gpu_r[1].w = 0.0039216 * skinWeight.y;                                      // 0x015: mul r1.w, c94.z, v8.y;
    func_0x000(int(gpu_r[1].x));                                                // 0x016: call 0x0, 0xa;
    gpu_r[1].xy = gpu_r[2].zz;                                                  // 0x017: mov r1.xy, r2.zz;
    gpu_r[1].w = 0.0039216 * skinWeight.z;                                      // 0x018: mul r1.w, c94.z, v8.z;
    if (gpu_cmp.x) {                                                            // 0x019: callc cmp.x, 0x0, 0xa;
        func_0x000(int(gpu_r[1].x));
    }
    if ((hasBoneW)) {                                                           // 0x01a: ifu b11, 0x1f, 0x0;
        gpu_r[1].xy = gpu_r[2].ww;                                              // 0x01b: mov r1.xy, r2.ww;
        gpu_r[1].w = 0.0039216 * skinWeight.w;                                  // 0x01c: mul r1.w, c94.z, v8.w;
        if (gpu_cmp.y) {                                                        // 0x01d: callc cmp.y, 0x0, 0xa;
            func_0x000(int(gpu_r[1].x));
        }
                                                                                // 0x01e: nop;
    } 
    gpu_r[7].w = 1.0;                                                           // 0x01f: mov r7.w, c93.y;
    gpu_r[10] = gpu_r[7];                                                       // 0x020: mov r10, r7;
    gpu_r[15].x = dot(vectors[90], gpu_r[10]);                                  // 0x021: dp4 r15.x, c90, r10;
    gpu_r[15].y = dot(vectors[91], gpu_r[10]);                                  // 0x022: dp4 r15.y, c91, r10;
    gpu_r[15].z = dot(vectors[92], gpu_r[10]);                                  // 0x023: dp4 r15.z, c92, r10;
    gpu_r[15].w = 1.0;                                                          // 0x024: mov r15.w, c93.y;
    gpu_r[3].xyz = vec3(0.0, 1.0, 0.0);                                         // 0x025: mov r3.xyz, c93.xyx;
    gpu_r[0].x = dot((-gpu_r[15].xyzz), (-gpu_r[15].xyzz));                     // 0x026: dp4 r0.x, (-r15.xyzz), (-r15.xyzz);
    gpu_r[0].x = inversesqrt(gpu_r[0].x);                                       // 0x027: rsq r0.x, r0.x;
    gpu_r[0].xyz = (-gpu_r[15].xyz) * gpu_r[0].xxx;                             // 0x028: mul r0.xyz, (-r15.xyz), r0.xxx;
    gpu_r[5].xyz = gpu_r[0].yzx * gpu_r[3].zxy;                                 // 0x029: mul r5.xyz, r0.yzx, r3.zxy;
    gpu_r[5].xyz = (-gpu_r[3].yzx) * gpu_r[0].zxy + gpu_r[5].xyz;               // 0x02a: mad r5.xyz, (-r3.yzx), r0.zxy, r5.xyz;
    gpu_r[1].x = dot(gpu_r[5].xyzz, gpu_r[5].xyzz);                             // 0x02b: dp4 r1.x, r5.xyzz, r5.xyzz;
    gpu_r[1].x = inversesqrt(gpu_r[1].x);                                       // 0x02c: rsq r1.x, r1.x;
    gpu_r[1].xyz = gpu_r[5].xyz * gpu_r[1].xxx;                                 // 0x02d: mul r1.xyz, r5.xyz, r1.xxx;
    gpu_r[5].xyz = gpu_r[0].yzx * gpu_r[1].zxy;                                 // 0x02e: mul r5.xyz, r0.yzx, r1.zxy;
    gpu_r[5].xyz = (-gpu_r[1].yzx) * gpu_r[0].zxy + gpu_r[5].xyz;               // 0x02f: mad r5.xyz, (-r1.yzx), r0.zxy, r5.xyz;
    gpu_r[2].x = dot(gpu_r[5].xyzz, gpu_r[5].xyzz);                             // 0x030: dp4 r2.x, r5.xyzz, r5.xyzz;
    gpu_r[2].x = inversesqrt(gpu_r[2].x);                                       // 0x031: rsq r2.x, r2.x;
    gpu_r[2].xyz = gpu_r[5].xyz * gpu_r[2].xxx;                                 // 0x032: mul r2.xyz, r5.xyz, r2.xxx;
    gpu_r[4].x = dot((-gpu_r[15].xyzz), (-gpu_r[15].xyzz));                     // 0x033: dp4 r4.x, (-r15.xyzz), (-r15.xyzz);
    gpu_r[4].x = inversesqrt(gpu_r[4].x);                                       // 0x034: rsq r4.x, r4.x;
    gpu_r[4].xyz = (-gpu_r[15].xyz) * gpu_r[4].xxx;                             // 0x035: mul r4.xyz, (-r15.xyz), r4.xxx;
    
    gpu_r[0].x = dot(vectors[90].xyz, gpu_r[12].xyz);                           // 0x036: dp3 r0.x, c90.xyz, r12.xyz;
    gpu_r[0].y = dot(vectors[91].xyz, gpu_r[12].xyz);                           // 0x037: dp3 r0.y, c91.xyz, r12.xyz;
    gpu_r[0].z = dot(vectors[92].xyz, gpu_r[12].xyz);                           // 0x038: dp3 r0.z, c92.xyz, r12.xyz;
    gpu_r[5].x = dot(gpu_r[0].xyz, gpu_r[4].xyz);                               // 0x039: dp3 r5.x, r0.xyz, r4.xyz;
    gpu_r[5].yz = vec2(0.0, 0.0);                                               // 0x03a: mov r5.yz, c93.xx;
    gpu_r[0].x = dot(gpu_r[5].xyzz, gpu_r[5].xyzz);                             // 0x03b: dp4 r0.x, r5.xyzz, r5.xyzz;
    gpu_r[0].x = inversesqrt(gpu_r[0].x);                                       // 0x03c: rsq r0.x, r0.x;
    gpu_r[0].xyz = gpu_r[5].xyz * gpu_r[0].xxx;                                 // 0x03d: mul r0.xyz, r5.xyz, r0.xxx;
    gpu_r[1].xyz = gpu_r[1].xyz * gpu_r[0].xxx;                                 // 0x03e: mul r1.xyz, r1.xyz, r0.xxx;
    gpu_r[5].y = 0.0039216 * color.x;                                           // 0x03f: mul r5.y, c94.z, v3.x;
    gpu_r[5].y = 3.0 * gpu_r[5].y;                                              // 0x040: mul r5.y, c93.w, r5.y;
    gpu_r[5].y = vectors[85].x * gpu_r[5].y;                                    // 0x041: mul r5.y, c85.x, r5.y;
    gpu_r[5].y = 2.0 * gpu_r[5].y;                                              // 0x042: mul r5.y, c93.z, r5.y;
    gpu_r[5].y = worldScales.x * gpu_r[5].y;                                    // add scale support
    gpu_r[1] = gpu_r[1] * gpu_r[5].yyyy;                                        // 0x043: mul r1, r1, r5.yyyy;
    gpu_r[2] = gpu_r[2] * gpu_r[5].yyyy;                                        // 0x044: mul r2, r2, r5.yyyy;
    gpu_r[7] = gpu_r[15];                                                       // 0x045: mov r7, r15;
    gpu_r[7].xyz = (-gpu_r[1].xyz) * vec3(0.5, 0.5, 0.5) + gpu_r[7].xyz;        // 0x046: mad r7.xyz, (-r1.xyz), c94.xxx, r7.xyz;
    gpu_r[7].xyz = (-gpu_r[2].xyz) * vec3(0.5, 0.5, 0.5) + gpu_r[7].xyz;        // 0x047: mad r7.xyz, (-r2.xyz), c94.xxx, r7.xyz;
    gpu_r[6] = gpu_r[7];                                                        // 0x048: mov r6, r7;
    gpu_r[6].w = 1.0;                                                           // 0x049: mov r6.w, c93.y;
    
    gpu_r[5].x = dot(vectors[86], gpu_r[6]);                                    // 0x04a: dp4 r5.x, c86, r6;
    gpu_r[5].y = dot(vectors[87], gpu_r[6]);                                    // 0x04b: dp4 r5.y, c87, r6;
    gpu_r[5].z = dot(vectors[88], gpu_r[6]);                                    // 0x04c: dp4 r5.z, c88, r6;
    gpu_r[5].w = dot(vectors[89], gpu_r[6]);                                    // 0x04d: dp4 r5.w, c89, r6;
    fragPosition = gpu_r[5];                                                    // 0x04e: mov o0, r5;
    fragQuaternionNormal = gpu_r[5];                                            // 0x04f: mov o1, r5;
   
    gpu_r[6].xyz = gpu_r[7].xyz + gpu_r[1].xyz;                                 // 0x050: add r6.xyz, r7.xyz, r1.xyz;
    gpu_r[5].x = dot(vectors[86], gpu_r[6]);                                    // 0x051: dp4 r5.x, c86, r6;
    gpu_r[5].y = dot(vectors[87], gpu_r[6]);                                    // 0x052: dp4 r5.y, c87, r6;
    gpu_r[5].z = dot(vectors[88], gpu_r[6]);                                    // 0x053: dp4 r5.z, c88, r6;
    gpu_r[5].w = dot(vectors[89], gpu_r[6]);                                    // 0x054: dp4 r5.w, c89, r6;
    fragView = gpu_r[5];                                                        // 0x055: mov o2, r5;
   
    gpu_r[6].xyz = gpu_r[7].xyz + gpu_r[2].xyz;                                 // 0x056: add r6.xyz, r7.xyz, r2.xyz;
    gpu_r[5].x = dot(vectors[86], gpu_r[6]);                                    // 0x057: dp4 r5.x, c86, r6;
    gpu_r[5].y = dot(vectors[87], gpu_r[6]);                                    // 0x058: dp4 r5.y, c87, r6;
    gpu_r[5].z = dot(vectors[88], gpu_r[6]);                                    // 0x059: dp4 r5.z, c88, r6;
    gpu_r[5].w = dot(vectors[89], gpu_r[6]);                                    // 0x05a: dp4 r5.w, c89, r6;
    fragColor = gpu_r[5];                                                       // 0x05b: mov o3, r5;
   
    gpu_r[5] = gpu_r[7] + gpu_r[2];                                             // 0x05c: add r5, r7, r2;
    gpu_r[6].xyz = gpu_r[5].xyz + gpu_r[1].xyz;                                 // 0x05d: add r6.xyz, r5.xyz, r1.xyz;
    gpu_r[5].x = dot(vectors[86], gpu_r[6]);                                    // 0x05e: dp4 r5.x, c86, r6;
    gpu_r[5].y = dot(vectors[87], gpu_r[6]);                                    // 0x05f: dp4 r5.y, c87, r6;
    gpu_r[5].z = dot(vectors[88], gpu_r[6]);                                    // 0x060: dp4 r5.z, c88, r6;
    gpu_r[5].w = dot(vectors[89], gpu_r[6]);                                    // 0x061: dp4 r5.w, c89, r6;
    fragUV = gpu_r[5];                                                          // 0x062: mov o4, r5;
}

void main() {
    /* used vectors[1], texture 0 transposed matrix[0] */
    /* used vectors[2], texture 0 transposed matrix[1] */
    /* used vectors[23], indexed transposed bone matrices[0][13] */
    func_0x00a();                                                               // 0x063: call 0xa, 0x59;
    gpu_r[0].x = 0.0039216 * color.w;                                           // 0x064: mul r0.x, c94.z, v3.w;
    gpu_r[0].y = vectors[1].w;                                                  // 0x065: mov r0.y, c1.w;
    gpu_r[0].z = vectors[2].w;                                                  // 0x066: mov r0.z, c2.w;
    fragUV2 = gpu_r[0];                                                         // 0x067: mov o5, r0;
    fragUV3 = gpu_r[0];                                                         // 0x068: mov o6, r0;
                                                                                // 0x069: end;
                                                                                // 0x06a: nop;
    gpu_r[13] = vec4(0.0, 0.0, 0.125, 1.0);                                     // 0x06b: mov r13, c23;
    gpu_r[13].xz = gpu_r[13].xz + uv2.xx;                                       // 0x06c: add r13.xz, r13.xz, v5.xx;
    gpu_r[13] = gpu_r[13] + uv2.yzyz;                                           // 0x06d: add r13, r13, v5.yzyz;
    
    if (geometryIndex.x == 0.0) {
        fragPosition = fragQuaternionNormal;                                    // 0x06e: mov o0, v1;
        fragUV = gpu_r[13].zwww;                                                // 0x06f: mov o4, r13.zwww;
                                                                                // 0x070: setemit 0x0;
                                                                                // 0x071: emit;
    } else if (geometryIndex.x == 1.0) {
        fragPosition = fragView;                                                // 0x072: mov o0, v2;
        fragUV = gpu_r[13].xwww;                                                // 0x073: mov o4, r13.xwww;
                                                                                // 0x074: setemit 0x1;
                                                                                // 0x075: emit;
    } else if (geometryIndex.x == 2.0) {
        fragPosition = fragColor;                                               // 0x076: mov o0, v3;
        fragUV = gpu_r[13].zyyy;                                                // 0x077: mov o4, r13.zyyy;
                                                                                // 0x078: setemit 0x2, primitive;
                                                                                // 0x079: emit;
    } else if (geometryIndex.x == 3.0) {
        fragPosition = fragUV;                                                  // 0x07a: mov o0, v4;
        fragUV = gpu_r[13].xyyy;                                                // 0x07b: mov o4, r13.xyyy;
                                                                                // 0x07c: setemit 0x0, primitive, winding;
                                                                                // 0x07d: emit;
    }
    fragDepth = length(fragPosition.xyz);                                       // 0x07e: end;
    fragNormal = normal;
    gl_Position = fragPosition;
    return;
}

                                                                                // 0x07f: nop;
