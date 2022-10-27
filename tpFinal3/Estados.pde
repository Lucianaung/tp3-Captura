void dibujar() {
  if (mousePressed) {
    dibujos.beginDraw();
    dibujos.strokeWeight(grosorDibujo);
    dibujos.line(mouseX, mouseY, pmouseX, pmouseY);
    dibujos.endDraw();
  }
}
//-----------------------------------------------------------
void detectar(PGraphics _dibujos) {
  dibujos = _dibujos;
  capturar = true;
  if (capturar == true) {
    receptor.actualizar(mensajes);
    for (Blob b : receptor.blobs) {
      if (b.entro) {
        poly = new FPoly();
        for (int i=0; i<b.contorno.size()-1; i+=10) { //simplificar la forma salteando vertices
          poly.vertex(b.contorno.get(i) * width, b.contorno.get(i+1) * height);
        }
        poly.setPosition(b.centerX, b.centerY);
        poly.setStatic(true);
        poly.setGrabbable(false);
        poly.setName("lineas");
        endShape(CLOSE);
        mundo.add(poly);
      }
    }
    capturar = false;
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
//-----------------------------------------------------------
void ganar() {
  tiempito --;
  background(random(255), random(255), random(255));
}
//-----------------------------------------------------------
void perder() {
  tiempito --;
  background(0);
}
