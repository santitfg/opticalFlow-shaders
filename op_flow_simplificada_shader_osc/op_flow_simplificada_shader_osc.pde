import gab.opencv.*;
import processing.video.*;
import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress net;
Capture camara;
OpenCV opencv;

float[]media_color; 

PShader filtro;
FloatList opFlow;

int ancho = 640;
int alto = 480;


//100*100 java se rompe
int row = 10;
int col = 10;




void setup() {
    size(1000, 600, P2D);
    
    
    osc = new OscP5(this, 3333);
    net = new NetAddress("127.0.0.1", 4443);
    
    filtro = loadShader("rgb_vectors_alpha.glsl");
    //filtro = loadShader("paleta_vectores.glsl");
    
    
    String[] listaDeCamaras = Capture.list();
    printArray(listaDeCamaras);
    camara = new Capture(this,640,460);
    
    //opencv = new OpenCV(this, ancho, alto );
    opencv = new OpenCV(this, camara.width, camara.height);
    
    camara.start();
    background(0);
    filtro.set("resolution", float(camara.width), float(camara.height));  
    
    ancho = camara.width / row;
    alto = camara.height / col;
    
    //envio osc 
    /////////////////////////////////////////////////////////
}
boolean flag = true;
void draw() {
    
    filtro.set("time", float(millis()));
    
    if(camara.available()) {
        
        
        media_color = promedio(0, 0, width, height);
        
        camara.read();
        opencv.loadImage(camara);
        opFlow = new FloatList();
        
        
        opencv.calculateOpticalFlow();
        
        PVector flowVec;
        for (int i = 0; i < 3; i++) {
            flowVec = opencv.getAverageFlowInRegion(camara.width / 3 * i, 0, camara.width / 3, camara.height);
            flowVec = new PVector(flowVec.x, flowVec.y);
            
            opFlow.append(flowVec.x / float(ancho));
            opFlow.append(flowVec.y / float(alto));
            
        }
        
        //-------
        float[] vectores = opFlow.array();
        
        noStroke();
        //----
        filtro.set("mouse", float(mouseX) / width, float(mouseY));  
        filtro.set("vectores", vectores);
        filtro.set("div", 10.);
        filtro.set("cam", camara);
        
        //--
        shader(filtro);
        
        rect(0, 0, width, height);
        
        
        float[] col = promedio(0, 0, width, height);
        OscMessage m;
        
        float difR = (abs(media_color[0] - col[0]));
        float difG = (abs(media_color[1] - col[1]));
        float difB = (abs(media_color[2] - col[2]));
        println(difR);
        println(difG);
        println(difB);
        println((difR + difG + difB) / 3.);
        
        if(frameCount % 5 ==  0) {
            
            m = new OscMessage("/portadora");
            m.add(difR * 200);
            osc.send(m, net);
            
            m = new OscMessage("/moduladora");
            m.add(difG * 1000); // primero sumo al mensaje el dato de fMod
            m.add(difB * 500); // luego sumo el de aMod
            osc.send(m, net); // el mensaje tiene 2 datos ej: 
        }
            //-----------------------------------------------
            //fin del available
        }
    }
        
       void exit() { 
            camara.stop();
        }
            