// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER
#define PI 3.141592653589793
#define TAU 1.5707963267948966

uniform float vectores[400]; // esto hay q actualizarlo segun las divisiones y a la vez subdividirlo en pares de vec2 id + vec2 vectorOpticalFlow
uniform float time;
uniform float div;
uniform vec2 resolution;
uniform sampler2D cam;


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

mat2 rot(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}


mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}



void main( void ) { 
    vec2 st = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution; // usar pixeles o id?
    st=1.-st;
    vec2 id= floor(st*div); 
    vec3 color = texture2D(cam,st).rgb;
    for(int  i= 0; i< vectores.length() ; i+=4){
                //puede pasar qeu el vector boleano este haciendo falso positivo o que el flow sea muy ruidoso
//0.5-random2(id/div));
//TESTEART HSV Y MIX!! a que puedo apliar esta logica?
//me aburre un id ya quiero otro tipo de pensamiento matematico, logre trapasar un vec con eso ya esa,
// ahora el optical flow quizas llevarlo a circulos como el de las mascaras de AC + el noise o buscar feedback?
//como expandir el shader creativamente?

//demasiado efecto 
float comparacion=float(vec2(vectores[i],vectores[i+1])==id);
            //st+=id/div;
          //  st=st*rot(1.0*random(id)*PI);
            //st=st*rot(0.);
        color.r = texture2D(cam,st+comparacion*sin(0.5-random2(id+time*0.1))*vec2(vectores[i+2],vectores[i+3])).r;
        color.g = texture2D(cam,st+comparacion*cos(0.5-random2(id+time*0.5))*vec2(vectores[i+2],vectores[i+3])).g;
        color.b = texture2D(cam,st+comparacion*tan(0.5-random2(id+time*0.2))*vec2(vectores[i+2],vectores[i+3])).b;
        /*
        color.r = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*sin(rand(id/div+time)+time*100.)*vec2(vectores[i+2],vectores[i+3])).r;
        color.g = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*sin(rand(id-time)+time)*vec2(vectores[i+2],vectores[i+3])).g;
        color.b = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*sin(rand(id*time*0.1))*vec2(vectores[i+2],vectores[i+3])).b;
        */
        /*
        //el ondulatorio no me salio muy piola deberia voler a intentar o mejor solo un par ondulando
        color.r = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).r;
        color.g = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).g;
        color.b = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).b;
        */
        if(bool(vec2(vectores[i],vectores[i+1])==id)){break;}
    }     

//probar luego desfases

  gl_FragColor = vec4(color, 1.);
    //gl_FragColor = texture2D(cam,st);
    //gl_FragColor = vec4(vec3(1.,0.,1.0), 1.);

}

