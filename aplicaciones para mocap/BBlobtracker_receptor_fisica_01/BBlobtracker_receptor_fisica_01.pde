import fisica.*; //<>//

FWorld mundo;

int PUERTO_OSC = 12345;

Receptor receptor;

Administrador admin;

void setup() {

  size(800, 600);
  
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0,0);

  setupOSC(PUERTO_OSC);

  receptor = new Receptor();
  
  admin = new Administrador(mundo);
  
  for(int i=0; i<100; i++){
  
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
    
    for (int i=0; i<b.contorno.size()-1; i+=2) {

      vertex(b.contorno.get(i) * w, b.contorno.get(i+1) * h);
    }
    endShape(CLOSE);
  }

  //println("cantidad de blobs: " + receptor.blobs.size());
  
  mundo.step();
  mundo.draw();
}
