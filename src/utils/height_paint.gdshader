shader_type spatial;
varying float v_height;
uniform float t1 = 50.0;
uniform float t2 = 100.0;
uniform float t3 = 200.0;
uniform vec3 c1 : source_color = vec3(0.8, 0.7, 0.5);
uniform vec3 c2 : source_color = vec3(0.3, 0.6, 0.3);
uniform vec3 c3 : source_color = vec3(0.5, 0.5, 0.5);
uniform vec3 c4 : source_color = vec3(0.9, 0.9, 0.9);
void vertex(){
    v_height = VERTEX.y;
}
void fragment(){
    vec3 col = c4;
    if(v_height < t1){
        col = c1;
    } else if(v_height < t2){
        col = c2;
    } else if(v_height < t3){
        col = c3;
    }
    ALBEDO = col;
}

