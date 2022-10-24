import oscP5.*;

OscP5 osc; // declaración del objeto OSC

float movimiento = 0;

void setup(){
  size(600, 400);
  
  osc = new OscP5(this, 12345); // inicializacion del objeto: puntero al processin y el PUERTO de comunicacion 
}

void draw(){
  
  background(255);
  textSize(32);
  fill(0);
  text("movimiento: " + movimiento, 50, height/2);
  
  float ancho = map (movimiento, 0, 1, 0, 400);
  rect(50, 50, ancho, 20);

}

void oscEvent( OscMessage m){

  if(m.addrPattern().equals("/movimiento")){
  
    movimiento = m.get(0).floatValue();
    println(movimiento);
  }
}
