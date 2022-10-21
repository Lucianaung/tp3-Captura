
import fisica.*;

FWorld mundo;
FCircle c;

//--------

int PUERTO_IN_OSC = 12345;
int PUERTO_OUT_OSC = 12346;
String IP = "127.0.0.1";

Receptor receptor;

Emisor emisor;

float averageFlow_x;
float averageFlow_y;

float totalFlow_x;
float totalFlow_y;

PuntoLocal p;

void setup() {

  size(800, 600);

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 0);

  c = new FCircle(30);
  c.setPosition(random(width -30), random(height-30));
  mundo.add(c);


  setupOSC(PUERTO_IN_OSC, PUERTO_OUT_OSC, IP);

  emisor = new Emisor();
  p = new PuntoLocal(1001, c.getX(), c.getY() );
  emisor.addPunto(p);

  receptor = new Receptor();
  receptor.setPuntosLocales(emisor.puntosLocales);
}

void draw() {
  background(255);  

  receptor.actualizar(mensajes);  
  receptor.dibujarZonasRemotas(width, height);

  mundo.step();
  mundo.draw();

  p.actualizarPosicion(c.getX(), c.getY());

  c.addImpulse(p.getMovX(), p.getMovY() );
  
  p.actualizarPosicion(c.getX(), c.getY()); // mi punto local actualiza su posición en funciób del FCircle c

  c.addImpulse(p.getMovX(), p.getMovY() ); // le doy un impulso al FCircle c en la dirección de movimiento del punto p

  emisor.actualizar();
  emisor.dibujar();
}
