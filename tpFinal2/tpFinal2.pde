import blobDetection.*;
import fisica.*;
import processing.sound.*;
FWorld mundo;
BlobDetection theBlobDetection;
SoundFile backDibujar, backJugar, backGanar, backPerder;
String estado;
PGraphics dibujos;
Boolean pelotaDesactivada;
Boolean estadoa, estadoc, estadod, estadoe;
int cuentaReg;
int tiempoOriginal = 10;
int tiempo;
int pasob;
int tiempito;
int grosorDibujo;
int grosorLinea;
int ms;
FPoly poly;
FCircle pelota;
FBox meta;

void setup() {
  size (1000, 650);
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges(color(0));

  background (255, 250, 186);

  dibujos = createGraphics(width, height);
  dibujos.beginDraw();
  dibujos.background(255);
  dibujos.endDraw();

  pelotaDesactivada = false;
  estadoa = false;
  estadoc = false;
  estadod = false;
  estadoe = false;
  tiempo = tiempoOriginal;
  tiempito = 3;
  grosorDibujo = 12;
  grosorLinea = 4;
  estado = "a";
  objetos();
  theBlobDetection = new BlobDetection(dibujos.width, dibujos.height);

  backDibujar = new SoundFile (this, "dibujar.mp3");
  backJugar = new SoundFile (this, "jugar.mp3");
  backGanar = new SoundFile (this, "ganar.mp3");
  backPerder = new SoundFile (this, "perder.mp3");
}
void draw() {
  image (dibujos, 0, 0);
  println("estado  "+estado+"   -   "+"cronometro "+tiempo);
  if (estado.equals("a")) {
    dibujar();
  } else if (estado.equals("b"))
  {
    detectar();
    tiempito --;
    fill(255, 0, 0);
    text(tiempito, width/2, (height/2)-50);
  } else if (estado.equals("c") && !pelotaDesactivada)
  {
    fill (0);
    textAlign(CENTER);
    textSize(50);
    text("JUGADA", width/2, 50);
    jugar();
  } else if (estado.equals("d"))
  {
    ganar();
    tiempito --;
  } else if (estado.equals("e"))
  {
    perder();
    tiempito --;
  }
  contador();
  controlDeCaptura();
  dormido();
  sonidos();
  resetar();

  mundo.step();
  mundo.draw();
}

void contador() {
  fill(0);
  textSize(50);
  if (estado.equals("a") && frameCount%60==0) {
    tiempo --;
    text(tiempo, width/2, height/2);
  } else if (estado.equals("a") && tiempo == 0) {
    estado = ("b");
    tiempo = 0;
  }
}

void controlDeCaptura() {
  if (estado.equals("b") && tiempito == 0) {
    estado = ("c");
    tiempito = 3;
  }
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

void dormido() {
  if (estado.equals("c") && pelota.isSleeping()) {
    estado = ("e");
  }
}

void resetar() {
  if (estado.equals("e") && tiempito == 0) {
    backPerder.stop();
    reset();
    tiempito = 3;
  } else if (estado.equals("d") && tiempito == 0) {
    backGanar.stop();
    reset();
    tiempito = 3;
  }
}

void sonidos() {
  if (estado.equals("a") && !estadoa) {
    backDibujar.play(1, 0.3);
    estadoa = true;
  } else if (estado.equals("b")) {
    backDibujar.stop();
  } else if (estado.equals("c") && !estadoc) {
    backJugar.play(1, 1);
    estadoc = true;
  } else if (estado.equals("d") && !estadod) {
    backJugar.stop();
    backGanar.play(1, 0.3);
    estadod = true;
  } else if (estado.equals("e") && !estadoe) {
    backJugar.stop();
    backPerder.play(1, 0.3);
    estadoe = true;
  }
}
