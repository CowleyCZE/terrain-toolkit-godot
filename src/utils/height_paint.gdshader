shader_type spatial;
varying float v_height;
uniform float t1 = 50.0;
uniform float t2 = 100.0;
uniform float t3 = 200.0;
uniform vec3 c1 : source_color = vec3(0.8, 0.7, 0.5);
uniform vec3 c2 : source_color = vec3(0.3, 0.6, 0.3);
uniform vec3 c3 : source_color = vec3(0.5, 0.5, 0.5);
uniform vec3 c4 : source_color = vec3(0.9, 0.9, 0.9);
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform sampler2D tex3;
uniform sampler2D tex4;
uniform bool use_tex1 = false;
uniform bool use_tex2 = false;
uniform bool use_tex3 = false;
uniform bool use_tex4 = false;
uniform float tile1 = 1.0;
uniform float tile2 = 1.0;
uniform float tile3 = 1.0;
uniform float tile4 = 1.0;
void vertex(){
    v_height = VERTEX.y;
}
void fragment(){
    vec3 col;
    if(v_height < t1){
        if(use_tex1){
            col = texture(tex1, UV * tile1).rgb;
        } else {
            col = c1;
        }
    } else if(v_height < t2){
        if(use_tex2){
            col = texture(tex2, UV * tile2).rgb;
        } else {
            col = c2;
        }
    } else if(v_height < t3){
        if(use_tex3){
            col = texture(tex3, UV * tile3).rgb;
        } else {
            col = c3;
        }
    } else {
        if(use_tex4){
            col = texture(tex4, UV * tile4).rgb;
        } else {
            col = c4;
        }
    }
    ALBEDO = col;
}
