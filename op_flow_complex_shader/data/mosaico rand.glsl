// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

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


void main( void ) { 
    vec2 st = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution; // usar pixeles o id?
    st=1.-st;
    vec2 id= floor(st*div); 
    vec3 color = texture2D(cam,st).rgb;
    for(int  i= 0; i< vectores.length() ; i+=4){
                //puede pasar qeu el vector boleano este haciendo falso positivo o que el flow sea muy ruidoso

        color.r = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(id)*vec2(vectores[i+2],vectores[i+3])).r;
        color.g = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(id)*vec2(vectores[i+2],vectores[i+3])).g;
        color.b = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(id)*vec2(vectores[i+2],vectores[i+3])).b;
        /*//el ondulatorio no me salio muy piola deberia voler a intentar o mejor solo un par ondulando
        color.r = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).r;
        color.g = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).g;
        color.b = texture2D(cam,st+float(vec2(vectores[i],vectores[i+1])==id)*rand(st+id)*vec2(vectores[i+2],vectores[i+3])).b;*/
        if(bool(vec2(vectores[i],vectores[i+1])==id)){break;}
    }     

//probar luego desfases

  gl_FragColor = vec4(color, 1.);
    //gl_FragColor = texture2D(cam,st);
    //gl_FragColor = vec4(vec3(1.,0.,1.0), 1.);

}

