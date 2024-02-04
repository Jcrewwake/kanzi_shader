precision lowp float;

uniform lowp float BlendIntensity;
varying mediump vec2 vTexCoord;
uniform mediump float kzTime;
uniform mediump vec2 kzWindowSize;

//  A-------B
//  |       |
//  D-------C
//  上边缘LineAB    下边缘LineDC    左边缘LineAD    右边缘LineBC
bool isPinterCircle(vec2 p, float r, vec2 st) {
    return pow((st.x - p.x), 2) + pow((st.y - p.y), 2) <= pow(r, 2);
}

bool isPinterLine(vec2 p1, vec2 p2, float lineWidth, vec2 st){

    if (p1.x > p2.x){
        vec2 temp = p1;
        p1 = p2;
        p2 = temp;   
    }
    
    if (p1.x <= p2.x && p1.y <= p2.y){
        float d_chuyi_2sita = lineWidth / (2 * cos(atan((p2.y - p1.y)/(p2.x - p1.x))));
        float k = (p2.y - p1.y)/(p2.x - p1.x) * (st.x - p1.x);

        return st.y <= k + p1.y + d_chuyi_2sita &&//上边缘LineAB
               st.y >= k + p1.y - d_chuyi_2sita &&//下边缘LineDC
               st.y >= -1/k * (st.x - p1.x) + p1.y &&//左边缘LineAD
               st.y <= -1/k * (st.x - p2.x) + p2.y;  //右边缘LineBC

    }else if (p1.x <= p2.x && p1.y >= p2.y){
        float d_chuyi_2sita = lineWidth / (2 * cos(atan((p2.y - p1.y)/(p2.x - p1.x))));
        float k = (p2.y - p1.y)/(p2.x - p1.x) * (st.x - p1.x);

        return st.y <= k + p1.y + d_chuyi_2sita &&//上边缘LineAB
               st.y >= k + p1.y - d_chuyi_2sita &&//下边缘LineDC
               st.y <= -1/k * (st.x - p1.x) + p1.y &&//左边缘LineAD
               st.y >= -1/k * (st.x - p2.x) + p2.y;  //右边缘LineBC
               
    }else{
        return 0;
    }
}

bool isPinterPL(vec2 p1, vec2 p2, float lineWidth, vec2 st)
{
    return isPinterLine(p1, p2, lineWidth, st) || isPinterCircle(p1, lineWidth / 2, st) || isPinterCircle(p2, lineWidth / 2, st);
}

void main() {
    vec2 st = vTexCoord;
    float px = 1.0 / kzWindowSize.y;
    
    vec3 color = vec3(1.0);
    if (isPinterPL(vec2(0.05,0.05), vec2(0.509,0.509), 0.01, st)){
        color = vec3(0.0,1.0,0.0);
    }else if(isPinterPL(vec2(0.509,0.509), vec2(0.8,0.05), 0.01, st)){
        color = vec3(0.0,1.0,0.0);
    }

    gl_FragColor = vec4(color, 1.0);
}
