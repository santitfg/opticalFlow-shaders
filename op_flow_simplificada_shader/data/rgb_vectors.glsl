// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform float vectores[6]; // esto hay q actualizarlo segun las divisiones y a la vez subdividirlo en pares de vec2 id + vec2 vectorOpticalFlow
uniform float time;
uniform vec2 resolution;
uniform sampler2D cam;

/*
float rand (vec2 uv){
     //uv=floor(uv);
    return fract(sin(dot(uv.xy,vec2(12.9898,78.233)))*43758.5453123);
}//     vec2(0.0111,0153.1010101010111)))*   029999975.010001);}
                //   vec2(0.0111,01.1010101010111)))*0.010001);

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float noise (in vec2 st) {
// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
    vec2 i = floor(st);
    vec2 f = fract(st);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f*f*(3.0-2.0*f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}
*/


void main( void ) { 
    vec2 st = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution; // usar pixeles o id?
    st=1.-st;
    vec3 color;// = texture2D(cam,st).rgb;

    color.r = texture2D(cam,st+vec2(vectores[0],vectores[1])).r;
    color.g = texture2D(cam,st+vec2(vectores[2],vectores[3])).g;
    color.b = texture2D(cam,st+vec2(vectores[4],vectores[5])).b;
  
//probar luego desfases

  gl_FragColor = vec4(color, 1.);
    //gl_FragColor = texture2D(cam,st);
    //gl_FragColor = vec4(vec3(1.,0.,1.0), 1.);

}

