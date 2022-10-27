/*
class Captura {
  Receptor receptor;
  FWorld mundo; // puntero al mundo de fisica que está en el main

  Captura(FWorld _mundo) {
    mundo = _mundo;
    receptor = new Receptor();
  }
  void capture() {
    if (capturar == true) {
      receptor.actualizar(mensajes);
      for (Blob b : receptor.blobs) {
        if (b.entro) {
          FPoly poly ;
          poly = new FPoly();
          for (int i=0; i<b.contorno.size()-1; i+=20) {
            poly.vertex(b.contorno.get(i) * width, b.contorno.get(i+1) * height);
          }
          poly.setPosition(b.centerX, b.centerY);
          poly.setStatic(true);
          poly.setGrabbable(false);
          poly.setName("lineas");
          mundo.add(poly);
        }
      }
    }
    capturar = false;
  }

  void sacarCuerpos() {
    ArrayList<FBody> cuerpos = mundo.getBodies();
    String nombrePoly;
    sacar = true;
    if (sacar == true) {
      for (FBody p : cuerpos) {
        nombrePoly = p.getName();
        if (nombrePoly.equals("lineas")) {
          mundo.remove(p);
        }
      }
    }
    sacar = false;
  }
}
*/
