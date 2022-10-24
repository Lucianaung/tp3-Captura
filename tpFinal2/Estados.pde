void dibujar() {
  if (mousePressed) {
    dibujos.beginDraw();
    dibujos.strokeWeight(grosorDibujo);
    dibujos.line(mouseX, mouseY, pmouseX, pmouseY);
    dibujos.endDraw();
  }
}
//-----------------------------------------------------------
void detectar() {
  for (int i=0; i<4; i++) {
    dibujos.filter(BLUR, 4);
  }

  theBlobDetection.setPosDiscrimination(false);
  theBlobDetection.setThreshold(0.60f); //0.38f--> revisar con el pizarrón, es qué tanto gris recibe
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
      for (int m = 0; m < b.getEdgeNb(); m += 20) { //--> simplifica la forma
        eA = b.getEdgeVertexA(m);
        if (eA !=null ) {
          poly.vertex(eA.x*width, eA.y*height);
        }
      }
      mundo.add(poly);
    }
  }

  dibujos.beginDraw();
  dibujos.background(255);
  dibujos.endDraw();
}
//-----------------------------------------------------------
void jugar() {
  mundo.add(pelota);
  pelotaDesactivada = true;
}
//-----------------------------------------------------------
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
  theBlobDetection = new BlobDetection(dibujos.width, dibujos.height);
}
//-----------------------------------------------------------
void ganar() {
  tiempito --;
  background(random(255), random(255), random(255));
}
//-----------------------------------------------------------
void perder() {
  tiempito --;
  background(255, 0, 0);
}
