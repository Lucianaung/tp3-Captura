class Puntero {

  float id;
  float x;
  float y;
  FWorld mundo; // puntero al mundo de fisica que está en el main

  FPoly body;

  Puntero(FWorld _mundo, float _id, float _x, float _y) {
    mundo = _mundo;
    id = _id;
    x = _x;
    y = _y;

    body = new FPoly();
    body.setPosition(x, y);
  }

  void setID(float id) {
    this.id = id;
  }

  void borrar() {
    mundo.remove(body);
  }

  void dibujar() {
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
  }
}
