class Administrador {

  ArrayList <Puntero> punteros;

  FWorld mundo; // puntero al mundo en el main


  Administrador(FWorld _mundo) {
    punteros = new ArrayList<Puntero>();

    mundo = _mundo;
  }


  void removerPuntero(Blob b) {
    for (int i= punteros.size()-1; i>=0; i--) {

      Puntero p = punteros.get(i);

      if (p.id == b.id) {
        p.borrar();  
        punteros.remove(i);
        break;
      }
    }
  }

  void dibujar() {
    for (Puntero p : punteros) {
      p.dibujar();
    }
  }
}
