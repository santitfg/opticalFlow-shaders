/**
pequeño sketch para visualizar el optical flow en una grilla de 10 * 10 
*/

import gab.opencv.*;
import processing.video.*;

Capture camara;
OpenCV opencv;
ArrayList<PVector> opFlow;

int ancho = 640;
int alto = 480;
int row = 10;
int col = 10;

boolean uno = true;  
PVector[][] vectores;

void setup() {
    size(1000, 600);
    vectores = new PVector[ancho][alto];
    
    String[] listaDeCamaras = Capture.list();
    printArray(listaDeCamaras);
    camara = new Capture(this, 640, 480);
    
    opencv = new OpenCV(this, camara.width, camara.height);
    
    camara.start();
    background(0);
    
    ancho = camara.width / row;
    alto = camara.height / col;
}
void draw() {
    
    opFlow  = new ArrayList<PVector>();
    
    if (camara.available()) {
        camara.read();
        opencv.loadImage(camara);
        image(camara, 0, 0);
        opencv.calculateOpticalFlow();
        
        PVector flowVec;
        PVector id;
        
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                fill(255 * i / col * j / row, 220);
                noStroke();
                rect((int) ancho * i,(int) alto * j,(int) ancho,(int) alto);
                
                flowVec = opencv.getAverageFlowInRegion(ancho * i, alto * j, ancho, alto);
                flowVec = new PVector(flowVec.x, flowVec.y);
                stroke(255, 0, 0);
                line(ancho * i + ancho / 2, alto * j + alto / 2, ancho * i + ancho / 2 + flowVec.x, alto * j + alto / 2 + flowVec.y);
                id = new PVector(j, i);
                opFlow.add(id);
                opFlow.add(flowVec);
            }
        }
        if (uno) {
            for (int w = 0; w < opFlow.size(); w += 2) {
                println(opFlow.get(w).x, opFlow.get(w).y); 
                println(opFlow.get(w + 1).x, opFlow.get(w + 1).y);
            }
        }
        
        //-----------------------------------------------
    }
}

void exit() { 
    camara.stop();
    }
