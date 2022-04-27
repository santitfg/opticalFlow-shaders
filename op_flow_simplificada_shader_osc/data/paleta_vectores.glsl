// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform float vectores[6]; // esto hay q actualizarlo segun las divisiones y a la vez subdividirlo en pares de vec2 id + vec2 vectorOpticalFlow
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
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


//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc

vec3 rgb2hsb( in vec3 c ){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz),
                 vec4(c.gb, K.xy),
                 step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r),
                 vec4(c.r, p.yzx),
                 step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),
                d / (q.x + e),
                q.x);
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

vec3 colot2bw(in vec3 color){
    return vec3((color.r+color.g+color.b)/3.);

}

void main( void ) { 
    vec2 st = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution; // usar pixeles o id?
    st=1.-st;
    vec3 color;// = texture2D(cam,st).rgb;
//aca la pregunta es por el espacio y el color como unir un vec 2 a un vec 3 y relacionarlos linealmente?? 
//como trabajar el desface en hsb? es posible o seria otra cuestion?
vec2 desfaceR=vec2(0,0);
vec2 desfaceG=vec2(0,0);
vec2 desfaceB=vec2(0,0);
    color.r = texture2D(cam,fract(st+vec2(vectores[0],vectores[1]))).r;
    color.g = texture2D(cam,fract(st+vec2(vectores[2],vectores[3]))).g;
   // st.x+=cos(time*0.001*PI);
    //st.y+=sin(time*0.001*PI);
    color.b = texture2D(cam,fract(st+vec2(vectores[4],vectores[5]))).b;
/*
    color.r = texture2D(cam,st+vec2(vectores[0],vectores[1])).r;
    color.g = texture2D(cam,st+vec2(vectores[2],vectores[3])).g;
    color.b = texture2D(cam,st+vec2(vectores[4],vectores[5])).b;
*/
    //color.rgb = hsb2rgb(color.rgb);
   //vec3 color_beta = hsb2rgb(color);
  
  //color=colot2bw(color);
  //a + b*cos( TAU*(c*t+d) );
//0.8, 0.5, 0.4		0.2, 0.4, 0.2	2.0, 1.0, 1.0	0.00, 0.25, 0.25
    vec3 a =vec3(0.8, 0.5, 0.4);
    vec3 b =vec3(.0, 01.0, 0.51);
    vec3 c =vec3(.0, 0.0, 0.0);//como funciona la distribucion
    vec3 d =vec3(0.00, 0.25, 0.25);
 // st.x+=sin(time*0.1)*0.5+0.5;
        color*=palette(st.y+st.x+time*0.001,a,b,c,d);
 // color=palette(st.x*st.y,a,b,color,color);
    //color=palette(st.x*st.y,color,color,color,color);
    //color=palette(st.t+time,color*0.5,color*0.5,color*0.5,color*0.5);
  //  color=palette(colot2bw(color).r,color*0.5,color*0.5,color*0.5,color*0.5);

   //color*=abs(palette(st.x,a,b,c,d));
//color*=fract(color);

   /*
    color.r = texture2D(cam,st+vec2(vectores[0],vectores[1])).r;
    color.g = texture2D(cam,st+vec2(vectores[2],vectores[3])).g;
    color.b = texture2D(cam,st+vec2(vectores[4],vectores[5])).b;
   */

 //   color.r =mix(color.r, color_beta.r , length(vec2(vectores[0],vectores[1])) );
  //  color.g = mix( color.g,color_beta.g, distance(vectores[2],vectores[3]) );
  //  color.b=mix(color.b,color_beta.b,distance(vectores[3],vectores[4]));

//probar luego desfases

  gl_FragColor = vec4(color, 1.);
    //gl_FragColor = texture2D(cam,st);
    //gl_FragColor = vec4(vec3(1.,0.,1.0), 1.);

}

