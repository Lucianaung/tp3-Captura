/*
 else if (estado.equals("b")) 
  {
    if (pasob == 1) {
      detectar();
    }
    if (pasob == 2) {
      fill (0);
      textAlign(CENTER);
      textSize(50);
      text("CAPTURA", width/2, (height/2)-50);
      tiempito --;
    }
  }
--------------------------------------------------------  
  void controlDeCaptura() {
  if (estado.equals("b") && pasob == 1 && tiempito==0) {
    pasob = 2;
  } else if (estado.equals("b") && pasob == 2) {
    estado = ("c");
  }
}
--------------------------------------------------------
void coliciones() {
  if (estado.equals("c")&&) {
    estado = ("d");
  } else if (estado.equals("c")&&) {
    estado = ("e");
  }
}
--------------------------------------------------------
  ms = millis()/1000;
  fill(0);
  textSize(50);
  cuentaReg = tiempo - ms;
--------------------------------------------------------
void detectar() {
  for (int i=0; i<4; i++) {
    dibujos.filter(BLUR, 4);
  }

  theBlobDetection.setPosDiscrimination(false);
  theBlobDetection.setThreshold(0.60f); 0.38f--> revisar con el pizarrón, es qué tanto gris recibe
  theBlobDetection.computeBlobs(dibujos.pixels);

  Blob b;
  EdgeVertex eA;
  for (int n = 0; n < theBlobDetection.getBlobNb(); n++) {
    poly = new FPoly(); //FPoly
    poly.setStatic(true);
    poly.setGrabbable(false);
    poly.setName("lineas");
    b = theBlobDetection.getBlob(n);
    if (b!=null) {
      for (int m = 0; m < b.getEdgeNb(); m += 20) { --> simplifica la forma
        eA = b.getEdgeVertexA(m);
        if (eA !=null ) {
          poly.vertex(eA.x*width, eA.y*height);
        }
      }
      mundo.add(poly);
    }
  }
--------------------------------------------------------
  void reset() {
  mundo.clear();
  mundo.setEdges(color(0));
  background (255, 250, 186);

  dibujos = createGraphics(width, height);
  dibujos.beginDraw();
  dibujos.background(255);
  dibujos.endDraw();

  pelotaDesactivada = false;
  estadoa = false;
  estadob = false;
  estadod = false;
  estadoe = false;
  tiempo = tiempoOriginal;
  tiempito = 3;
  grosorDibujo = 12;
  grosorLinea = 4;
  estado = "a";
  objetos();
  
  //reset nuevo
   mundo.remove(poly);
  mundo.remove(pelota);
  mundo.remove(meta);
  pelotaDesactivada = false;
  estadoa = false;
  estadob = false;
  estadod = false;
  estadoe = false;
  tiempo = tiempoOriginal;
  tiempito = 3;
  estado = "a";

  meta = new FBox(50, 100);
  meta.isSensor();
  meta.setStatic(true);
  meta.setPosition(width-50/2, random(50, 650));
  meta.setStrokeWeight(grosorLinea);
  meta.setFill(255);
  meta.setStroke(0, 255, 0);
  meta.setName("meta");
  mundo.add(meta);
  
}
*/
