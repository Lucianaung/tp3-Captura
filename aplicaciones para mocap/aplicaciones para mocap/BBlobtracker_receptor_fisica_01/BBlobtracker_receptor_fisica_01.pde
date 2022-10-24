import fisica.*; //<>//
import blobDetection.*;

FWorld mundo;
BlobDetection theBlobDetection;
PGraphics dibujos;

int PUERTO_OSC = 12345;

Receptor receptor;

Administrador admin;
FPoly poly;
void setup() {

  size(800, 600);

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 0);

  setupOSC(PUERTO_OSC);
  dibujos = createGraphics(width, height);
  dibujos.beginDraw();
  dibujos.background(255);
  dibujos.endDraw();
  receptor = new Receptor();

  admin = new Administrador(mundo);
  theBlobDetection = new BlobDetection(dibujos.width, dibujos.height);

  for (int i=0; i<100; i++) {

    FCircle c = new FCircle(random(20, 50));
    c.setPosition(random (50, width-50), random(50, height-50));
    c.setFill(random(255), random(255), random(255));
    mundo.add(c);
  }
}

void draw() {
  background(255);

  receptor.actualizar(mensajes); //
  receptor.dibujarBlobs(width, height);


  // Eventos de entrada y salida
  for (Blob b : receptor.blobs) {

    if (b.entro) {
      admin.crearPuntero(b);
      println("--> entro blob: " + b.id);
    }
    if (b.salio) {
      admin.removerPuntero(b);
      println("<-- salio blob: " + b.id);
    }

    admin.actualizarPuntero(b);
  }

  //println("cantidad de blobs: " + receptor.blobs.size());

  mundo.step();
  mundo.draw();
}
