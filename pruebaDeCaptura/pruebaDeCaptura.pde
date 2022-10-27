import fisica.*;

FWorld mundo;

int PUERTO_OSC = 12345;
boolean capturar = false;
//boolean sacar = false;

Receptor receptor;
Blob blob;
FPoly poly;
void setup() {
  size(800, 600);

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 0);

  setupOSC(PUERTO_OSC);

  receptor = new Receptor();

  FCircle c = new FCircle(random(20, 50));
  c.setPosition(random (50, width-50), random(50, height-50));
  c.setFill(random(255), random(255), random(255));
  mundo.add(c);
}

void draw() {
  background(255);
  receptor.actualizar(mensajes);
  capturar = true;
  if (capturar == true) {
    for (Blob b : receptor.blobs) {
      if (b.entro) {
        poly = new FPoly();
        for (int i=0; i<b.contorno.size()-1; i+=20) {
          poly.vertex(b.contorno.get(i) * width, b.contorno.get(i+1) * height);
        }
        poly.setPosition(b.centerX, b.centerY);
        poly.setStatic(true);
        poly.setGrabbable(false);
        poly.setName("lineas");
      }
    }
    mundo.add(poly);
    capturar = false;
  }
  mundo.step();
  mundo.draw();
}
