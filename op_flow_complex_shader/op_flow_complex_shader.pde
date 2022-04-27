import gab.opencv.*;
import processing.video.*;


Capture camara;

OpenCV opencv;


PShader filtro;
FloatList opFlow;

int ancho = 640;
int alto = 480;


//100*100 java se rompe
int row = 10;
int col = 10;

void setup() {
    size(1000, 600, P2D);
    filtro = loadShader("desfase.glsl");    
    String[] listaDeCamaras = Capture.list();
    printArray(listaDeCamaras);
    camara = new Capture(this, 640, 480);
    
    //opencv = new OpenCV(this, ancho, alto );
    opencv = new OpenCV(this, camara.width, camara.height);
    
    camara.start();
    background(0);
    filtro.set("resolution", float(camara.width), float(camara.height));  
    
    ancho = camara.width / row;
    alto = camara.height / col;
}
void draw() {
    
    
    if (camara.available()) {
        camara.read();
        opencv.loadImage(camara);
        opFlow = new FloatList();
        
        opencv.calculateOpticalFlow();
        
        PVector flowVec;
        
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                flowVec = opencv.getAverageFlowInRegion(ancho * i, alto * j, ancho, alto);
                flowVec = new PVector(flowVec.x, flowVec.y);
                opFlow.append(i);
                opFlow.append(j);
                opFlow.append(flowVec.x / float(ancho));
                opFlow.append(flowVec.y / float(alto));
            }
        }
        float[] vectores = opFlow.array();
        
        noStroke();
        //----
        filtro.set("vectores", vectores);
        filtro.set("time", millis());
        filtro.set("div", 10.);
        filtro.set("cam", camara);
        
        //--
        shader(filtro);
        
        rect(0, 0, width, height);
        
        //-----------------------------------------------
        
    }
}

void exit() { 
    camara.stop();
}
