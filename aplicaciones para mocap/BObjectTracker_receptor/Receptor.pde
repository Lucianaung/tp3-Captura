class Receptor { //<>// //<>// //<>//

  ArrayList <Objeto> objetos;
  int tiempo_para_borrar = -15;

  Receptor() {

    objetos = new ArrayList<Objeto>();
  }

  void actualizar(ArrayList <OscMessage> mensajes) {

    resetObjetos(); // Si hay objetos, pone la variable "estaActualizado" en false, en todos los objetos

    while (mensajes.size() > 0) { // Mientras hay mensajes en el buffer

      OscMessage m = mensajes.get(0); // carga el primer mensaje que llegó en la variable m

      if (m.addrPattern().equals("/bobjecttracker/datos")) { // si el mensaje tiene la etiqueta (address) "/bobjecttracker/datos"

        boolean encontrado = false;  // 

        int id = (int) m.get(0).floatValue(); // le pido el ID a cada objeto del mensaje

        for (int i=0; i<objetos.size(); i++) { // recorro la lista de objetos del repector

          Objeto o = objetos.get(i);

          if (o.id == id) { // si el objeto del mensaje ya estaba en mi lista de objetos
    
            o.actualizarDatos(m); // le envio el mensaje al objeto para que tome los datos del indice correspondiente para actualizarse
            o.actualizado = true; // aviso que este objeto ya fue actualizado
            o.ultimaActualizacion = 0;
            encontrado = true; // aviso que el objeto del mensaje ya fue encontrado para que deje de buscar entre los de mi lista de objetos
            break; // salgo del siclo for para que deje de buscar
          }
        }

        if (!encontrado) { 

          Objeto no = new Objeto();   // creo un NUEVO objeto
          no.setID(id);           // le pongo el ID
          no.actualizarDatos(m);   // le actualizo los datos
          no.actualizado = true; // lo marco como ya actualizado
          objetos.add(no);
        }
      }
      mensajes.remove(0);
    }

    for (int k=objetos.size()-1; k>=0; k--) { //recorro mi lista de objetos de atras para adelante
      Objeto vo = objetos.get(k);
      if (!vo.actualizado) {  // si encuentro alguno que no fue actualizado (porque en los mensajes de entrada no estaba
        vo.ultimaActualizacion--;
      }
      if (vo.ultimaActualizacion < tiempo_para_borrar) {
        objetos.remove(k);  // lo borro de la lista
      }
    }
    
    for (Objeto o : objetos) {
      o.actualizar();
    }
  }

  void resetObjetos() {
    for (Objeto o : objetos) {
      o.actualizado = false;
    }
  }

  void dibujarObjetos(float w, float h) {

    for (Objeto o : objetos) {
      o.dibujar(w, h);
    }
  }
}
