attribute vec3 kzPosition;
uniform mediump mat4 kzProjectionCameraWorldMatrix;
attribute vec2 kzTextureCoordinate0;

varying mediump vec2 vTexCoord;
 
void main()
{
    precision mediump float;
    vTexCoord = kzTextureCoordinate0;

    // kzPosition等是kanzi自动映射好的。
    gl_Position = kzProjectionCameraWorldMatrix * vec4(kzPosition.xyz, 1.0);
}