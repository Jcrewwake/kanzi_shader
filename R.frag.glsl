precision mediump float;

uniform mediump float BlendIntensity;
varying mediump vec2 vTexCoord;
uniform mediump vec2 kzWindowSize;

//  A-------B
//  |       |
//  D-------C
//  上边缘LineAB    下边缘LineDC    左边缘LineAD    右边缘LineBC
bool pinterCircle(vec2 p, float r, vec2 st) {
    return pow((st.x - p.x), 2.0) + pow((st.y - p.y), 2.0) <= pow(r, 2.0);
}

bool pinterLine(vec2 p1, vec2 p2, float lineWidth, vec2 st){

    if (p1.x > p2.x){
        vec2 temp = p1;
        p1 = p2;
        p2 = temp;   
    }
    
    if (p1.x <= p2.x && p1.y <= p2.y){
        float d_chuyi_2sita = lineWidth / (2.0 * cos(atan((p2.y - p1.y)/(p2.x - p1.x))));
        float k = (p2.y - p1.y)/(p2.x - p1.x) * (st.x - p1.x);

        return st.y <= k + p1.y + d_chuyi_2sita &&//上边缘LineAB    d是线条宽度
               st.y >= k + p1.y - d_chuyi_2sita &&//下边缘LineDC
               st.y >= -1.0/k * (st.x - p1.x) + p1.y &&//左边缘LineAD
               st.y <= -1.0/k * (st.x - p2.x) + p2.y;  //右边缘LineBC

    }else if (p1.x <= p2.x && p1.y >= p2.y){
        float d_chuyi_2sita = lineWidth / (2.0 * cos(atan((p2.y - p1.y)/(p2.x - p1.x))));
        float k = (p2.y - p1.y)/(p2.x - p1.x) * (st.x - p1.x);

        return st.y <= k + p1.y + d_chuyi_2sita &&//上边缘LineAB
               st.y >= k + p1.y - d_chuyi_2sita &&//下边缘LineDC
               st.y <= -1.0/k * (st.x - p1.x) + p1.y &&//左边缘LineAD
               st.y >= -1.0/k * (st.x - p2.x) + p2.y;  //右边缘LineBC
               
    }else{
        return false;
    }
}

bool pinterPL(vec2 p1, vec2 p2, float lineWidth, vec2 st)
{
    return pinterLine(p1, p2, lineWidth, st) || pinterCircle(p1, lineWidth / 2.0, st) || pinterCircle(p2, lineWidth / 2.0, st);
}

void main() {
    vec2 st = vTexCoord;
    float px = 1.0 / kzWindowSize.y;
    
    vec3 color = vec3(1.0);
    if (pinterPL(vec2(0.05,0.05), vec2(0.509,0.509), 0.01, st)){
        color = vec3(0.17, 0.86, 0.48);
    }else if(pinterPL(vec2(0.509,0.509), vec2(0.8,0.05), 0.01, st)){
        color = vec3(0.17, 0.86, 0.48);
    }

    gl_FragColor = vec4(color, 1.0);
}
