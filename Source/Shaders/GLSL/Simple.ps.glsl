#version 430

in vec4 fragmentColor;
out vec4 finalFragmentColor;

void main()
{
	finalFragmentColor = fragmentColor;
}