#version 450

uniform sampler2D albedo;
uniform sampler2D normals;

in vec2 position;

out vec4 frag;

vec2 clipToTex(vec2 value) {
	return (value + 1.0) / 2.0;
}

void main(){
    vec3 color = texture(albedo, clipToTex(position)).rgb;
    vec3 nor = texture(normals, clipToTex(position)).rgb;
    vec3 lightDir = normalize(vec3(1.0, 1.0, 0.0));
    vec3 diffuse = max(dot(nor, lightDir), 0.0) * color;
    frag = vec4(diffuse, 1.0);
}