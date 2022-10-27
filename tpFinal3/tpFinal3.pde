import fisica.*;
import processing.sound.*;

FWorld mundo;
SoundFile backDibujar, backJugar, backGanar, backPerder;
PFont font;
String estado;
PGraphics dibujos;
Boolean pelotaDesactivada;
Boolean estadoa, estadob, estadod, estadoe;
boolean capturar;
int PUERTO_OSC = 12345;
int cuentaReg;
int tiempoOriginal = 5;
int tiempo;
int pasob;
int tiempito;
int grosorDibujo;
int grosorLinea;
int ms;

Receptor receptor;
Blob blob;
FPoly poly;
FCircle pelota;
FBox meta;

void setup() {
  size (1000, 650);
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(color(0));

  setupOSC(PUERTO_OSC);

  background (255, 255);

  receptor = new Receptor();

  dibujos = createGraphics(width, height);
  dibujos.beginDraw();
  dibujos.background(255);
  dibujos.endDraw();

  font = loadFont ("Blokletters-Viltstift-48.vlw");
  textFont(font);
  textAlign(CENTER);
  textSize(26);
  pelotaDesactivada = false;
  capturar = false;
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

  backDibujar = new SoundFile (this, "dibujar.mp3");
  backJugar = new SoundFile (this, "jugar.mp3");
  backGanar = new SoundFile (this, "ganar.mp3");
  backPerder = new SoundFile (this, "perdio.mp3");

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
void draw() {
  image (dibujos, 0, 0);
  println("estado  "+estado+"   -   "+"cronometro "+tiempo+"   -   "+"capturar: "+capturar);
  if (estado.equals("a")) {
    dibujar();
  } else if (estado.equals("b")) {

    detectar(dibujos);
  } else if (estado.equals("c") && !pelotaDesactivada) {
    jugar();
  } else if (estado.equals("d")) {
    ganar();
  } else if (estado.equals("e")) {
    perder();
  }

  //contador();
  //controlDeCaptura();
  //dormido();
  //resetar();
  transiciones();
  sonidos();


  mundo.step();
  mundo.draw();
}

void contactStarted(FContact contacto) {
  FBody cuerpo1 = contacto.getBody1();
  FBody cuerpo2 = contacto.getBody2();

  String nombre1 = conseguirNombre(cuerpo1);
  String nombre2 = conseguirNombre(cuerpo2);

  if (estado.equals("c") && ((nombre1 == "pelota" && nombre2 == "meta")||(nombre2 == "pelota" && nombre1 == "meta"))) {
    estado = ("d");
  }
}

void sonidos() {
  if (estado.equals("a") && !estadoa) {
    backDibujar.play(1, 0.3);
    estadoa = true;
  } else if (estado.equals("b") && !estadob) {
    backDibujar.stop();
    backJugar.play(1, 1);
    backJugar.loop();
    estadob = true;
  } else if (estado.equals("d") && !estadod) {
    backJugar.stop();
    backGanar.play(1, 0.3);
    estadod = true;
  } else if (estado.equals("e") && !estadoe) {
    backJugar.stop();
    estadoe = true;
    backPerder.play(1, 0.8);
  }
}
