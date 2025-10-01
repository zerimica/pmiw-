// --- Variables globales ---
int pantalla = 0; // índice de la pantalla actual
PImage[] imagenes; // arreglo de imágenes
String[] textos;  // arreglo de textos
int[][] opciones; // destinos de cada opción

void setup() {
  size(640, 480);
  
  // Inicializar imágenes
  imagenes = new PImage[16]; // 12 pantallas + 3 finales + créditos
  for (int i = 0; i < imagenes.length; i++) {
    imagenes[i] = loadImage("img" + i + ".jpg"); 
    // Deben estar en la carpeta data/
  }
  
  // Inicializar textos
  textos = new String[16];
  
  // Pantallas de historia
  textos[0] = "Te despiertas en un bosque oscuro. Un sendero se abre frente a ti...";
  textos[1] = "Sigues el sendero iluminado. Escuchas un río cerca...";
  textos[2] = "Te adentras en la oscuridad. Algo cruje detrás tuyo...";
  textos[3] = "Encuentras un puente sobre el río. ¿Lo cruzas o sigues la orilla?";
  textos[4] = "Sigues el sonido extraño. Ves una luz tenue en la distancia...";
  textos[5] = "Cruzas el puente y llegas a un castillo antiguo...";
  textos[6] = "Sigues la orilla y descubres una cabaña abandonada...";
  textos[7] = "La luz te lleva a una cueva misteriosa...";
  textos[8] = "Dentro del castillo, una puerta te invita a entrar...";
  textos[9] = "En la cabaña encuentras un cofre cerrado...";
  textos[10] = "En la cueva escuchas un rugido aterrador...";
  textos[11] = "Frente a la puerta del castillo, dudas si tocar o volver...";
  
  // Finales
  textos[12] = "Final 1: Encuentras un tesoro oculto y logras escapar rico y feliz.";
  textos[13] = "Final 2: El monstruo de la cueva te atrapa. Tu aventura termina aquí.";
  textos[14] = "Final 3: Decides regresar al bosque y vivir tranquilo, lejos de peligros.";
  
  // Créditos
  textos[15] = "Trabajo Final - Aventura Gráfica\nAlumno: Ludmila Micaela Aguilar \nDocente: David Bedoian";
  
  // Opciones de navegación
  opciones = new int[16][2];
  
  // Flujo de la historia
  opciones[0][0] = 1; opciones[0][1] = 2;
  opciones[1][0] = 3; opciones[1][1] = 4;
  opciones[2][0] = 4; opciones[2][1] = 7;
  opciones[3][0] = 5; opciones[3][1] = 6;
  opciones[4][0] = 7; opciones[4][1] = 6;
  opciones[5][0] = 8; opciones[5][1] = 11;
  opciones[6][0] = 9; opciones[6][1] = 14; // final 3
  opciones[7][0] = 10; opciones[7][1] = 13; // final 2
  opciones[8][0] = 12; opciones[8][1] = 11; // final 1
  opciones[9][0] = 12; opciones[9][1] = 14; // final 1 o 3
  opciones[10][0] = 13; opciones[10][1] = 14; // final 2 o 3
  opciones[11][0] = 12; opciones[11][1] = 14; // final 1 o 3
}

void draw() {
  background(0);
  
  // Dibujar imagen
  image(imagenes[pantalla], 0, 0, width, height);
  
  // Caja de texto
  fill(0, 150);
  rect(0, height - 100, width, 100);
  
  // Texto narrativo
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text(textos[pantalla], width/2, height - 50);
  
  // Botones
  if (pantalla < 12) { // pantallas de historia
    dibujarBoton("Opción A", width/2 - 150, height - 40);
    dibujarBoton("Opción B", width/2 + 50, height - 40);
  } else if (pantalla >= 12 && pantalla <= 14) { // finales
    dibujarBoton("Reiniciar", width/2 - 50, height - 40);
    dibujarBoton("Créditos", width/2 - 50, height - 80);
  } else if (pantalla == 15) { // créditos
    dibujarBoton("Reiniciar", width/2 - 50, height - 40);
  }
}

void dibujarBoton(String txt, int x, int y) {
  fill(50, 150, 200);
  rect(x, y, 100, 30, 8);
  fill(255);
  textSize(12);
  textAlign(CENTER, CENTER);
  text(txt, x+50, y+15);
}

void mousePressed() {
  if (pantalla < 12) {
    if (mouseEnRango(width/2 - 150, height - 40, 100, 30)) {
      pantalla = opciones[pantalla][0];
    } else if (mouseEnRango(width/2 + 50, height - 40, 100, 30)) {
      pantalla = opciones[pantalla][1];
    }
  } else if (pantalla >= 12 && pantalla <= 14) {
    if (mouseEnRango(width/2 - 50, height - 40, 100, 30)) {
      pantalla = 0; // reinicio
    } else if (mouseEnRango(width/2 - 50, height - 80, 100, 30)) {
      pantalla = 15; // créditos
    }
  } else if (pantalla == 15) {
    if (mouseEnRango(width/2 - 50, height - 40, 100, 30)) {
      pantalla = 0; // reinicio
    }
  }
}

boolean mouseEnRango(int x, int y, int w, int h) {
  return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
}
