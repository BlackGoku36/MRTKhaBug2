#version 450

in vec3 pos;
in vec3 nor;
in vec2 texcoord;

out vec3 normal;
// out vec2 uv;
out vec3 fragPos;

uniform mat4 P;
uniform mat4 V;
uniform mat4 M;
// uniform mat4 N;

void main() {
    fragPos = vec3(M * vec4(pos, 1.0));
    normal = nor;
    // normal = mat3(N) * nor;
    // uv = texcoord;
    gl_Position = P * V * vec4(fragPos, 1.0);
}