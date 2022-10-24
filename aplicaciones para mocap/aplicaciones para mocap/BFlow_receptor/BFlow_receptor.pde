//--------
// Receptor de BFlow

// creado por Matias Romero Costas

// Septiembre 2022
//--------

int PUERTO_IN_OSC = 12345; // puerto de entrada
int PUERTO_OUT_OSC = 12346; // puerto de salida
String IP = "127.0.0.1"; // ip del BFlow 


Receptor receptor;

Emisor emisor;

float averageFlow_x;
float averageFlow_y;

float totalFlow_x;
float totalFlow_y;

PuntoLocal pl;

ZonaLocal zl;

void setup() {

  size(800, 600);

  setupOSC(PUERTO_IN_OSC, PUERTO_OUT_OSC, IP);

  receptor = new Receptor();
  
  emisor = new Emisor();
  
  pl = new PuntoLocal(1001, random(width), random(height));
  emisor.addPunto(pl);
  
  zl = new ZonaLocal(2001, 100, 100, 80, 60);
  emisor.addZona(zl);
  
  receptor.setPuntosLocales(emisor.puntosLocales);
  receptor.setZonasLocales(emisor.zonasLocales);
}

void draw() {
  background(255);  

  receptor.actualizar(mensajes);  
  receptor.dibujarZonasRemotas(width, height);
  
  float cx = width / 2;
  float cy = height / 2;
  stroke(0, 255, 0);
  strokeWeight(2);
  line(cx, cy, cx + averageFlow_x * 10, cy + averageFlow_y * 10);
  
  emisor.actualizar();
  emisor.dibujar();
}

void mousePressed() {
  pl.actualizarPosicion(mouseX, mouseY);
}
