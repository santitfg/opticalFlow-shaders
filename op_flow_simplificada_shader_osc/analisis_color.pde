
//ampliar desde openCV?
//https://github.com/atduskgreg/opencv-processing
//simplificar desde esta lib?
//https://github.com/Milchreis/processing-imageprocessing#sobels-algorithm

//analizar cuadrantes o grilla (3x3 ? 8x8?)  o pixeles aleatorios


//funcion de array con modelo hsb y rgb de un punto de color
float[] hsbRGB(int x, int y) {
  float[] analisis= new float[6];
  loadPixels(); 
  color col= pixels[x+y*width];
  analisis[0]=hue(col);
  analisis[1]=saturation(col);
  analisis[2]= brightness(col);
  analisis[3] += (col >> 16) & 0xFF;  // (right shift) la forma mas rápida de obtener los colores red(argb) //>>  El número a la izquierda del operador se desplaza el número de lugares especificado por el número a la derecha.
  analisis[4] += (col >> 8) & 0xFF;   //  & 0xFF se usa en java para 0x indicar un número hexadecimal
  analisis[5] += col & 0xFF;  

  return analisis;
}
float brillo(int x, int y) {
  loadPixels(); 
  color col= pixels[x+y*width];
  return brightness(col);
}
float tono(int x, int y) {
  loadPixels(); 
  color col= pixels[x+y*width];
  return hue(col);
}
float saturacion(int x, int y) {
  loadPixels(); 
  color col= pixels[x+y*width];
  return hue(col);
}
//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//


//una funcion con un array de long podria quizas ser uno de int pero me parecio 
float[] promedio(int x, int y, int w, int h) {
  double[]rgb={0, 0, 0};

  PImage copyImg = get(x, y, w, h);


  // color promedio de la mitad de arriba de pantalla usando el largo del array/2 de la imagen
  copyImg.loadPixels(); //cargamos todos los pixeles del video, ya que es un array con pixels.length
  for (int i = 0; i < copyImg.pixels.length; i++) { //recorremos el array desde el px 0 a la mitad de pantalla, 102400px
    color argb = copyImg.pixels[i];
    //a += (argb >> 24) & 0xFF; //a es para alfa, que no uso.
    rgb[0] += (argb >> 16) & 0xFF;  // (right shift) la forma mas rápida de obtener los colores red(argb) //>>  El número a la izquierda del operador se desplaza el número de lugares especificado por el número a la derecha.
    rgb[1] += (argb >> 8) & 0xFF;   //  & 0xFF se usa en java para 0x indicar un número hexadecimal
    rgb[2] += argb & 0xFF;          // El  hexadecimal literal para 0xFF es un int(255), por eso es la forma mas r'apida de obtener colores
  }
  rgb[0]=rgb[0]/copyImg.pixels.length;
  rgb[1]=rgb[1]/copyImg.pixels.length;
  rgb[2]=rgb[2]/copyImg.pixels.length;

  float[]rgbfloat= {(float)rgb[0], (float)rgb[2], (float)rgb[2]};
  return rgbfloat ;
}
//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//
