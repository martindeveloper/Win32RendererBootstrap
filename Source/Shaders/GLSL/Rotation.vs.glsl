#version 430
#pragma optimize(off)
#pragma debug(on)

struct ConstantBuffer
{
	mat4 ModelViewProjectionMatrix;
	uint FrameNumber;
};

struct TransformBuffer
{
	vec3 Position;
	vec3 Scale;
};

layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec4 vertexColor;
layout(location = 2) in vec2 vertexUV;

uniform ConstantBuffer UniformBuffer;
uniform TransformBuffer Transform;

out vec4 fragmentColor;
out vec2 fragmentUV;

const float PI = 3.1415926535897932384626433832795;

void main()
{
	float radians = (UniformBuffer.FrameNumber * PI) / 180.0f;

	vec3 basePosition = (vertexPosition * Transform.Scale) + Transform.Position;

	float x = (basePosition.x * cos(radians)) + (basePosition.y * sin(radians));
	float y = (basePosition.x * sin(radians)) - (basePosition.y * cos(radians));

	gl_Position = UniformBuffer.ModelViewProjectionMatrix * vec4(x, y, basePosition.z, 1.0);

	fragmentColor = vertexColor;
	fragmentUV = vertexUV;
}