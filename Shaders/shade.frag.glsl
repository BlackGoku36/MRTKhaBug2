#version 450

layout(location = 0) out vec4 fragColor;
layout(location = 1) out vec4 fragNormal;

in vec3 normal;
// in vec2 uv;
in vec3 fragPos;
uniform int pass;

void main(){
    int p = pass;
	// if(pass == 0){
        fragColor = vec4(vec3(1, 1, 1), 1);
        fragNormal = vec4(normal, 1);
}  
