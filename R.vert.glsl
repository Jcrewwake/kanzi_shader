attribute vec3 kzPosition;
uniform mediump mat4 kzProjectionCameraWorldMatrix;
attribute vec2 kzTextureCoordinate0;

varying vec2 vTexCoord;
 
void main()
{
    precision mediump float;
    vTexCoord = kzTextureCoordinate0;

    gl_Position = kzProjectionCameraWorldMatrix * vec4(kzPosition.xyz, 1.0);
}


