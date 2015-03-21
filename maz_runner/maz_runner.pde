int SIZE = 500;

void setup() {
  size(SIZE+1,SIZE+1,P2D);
  background(255);
  // draw once
  noLoop();
}

void draw() {
  Qrid q = new Qrid(40);
  q.displayQrid();
}

class Quare {
  float posx;
  float posy;
  float size;
  boolean seen = false;
  Quare[] neighbors;
  
  Quare(float x, float y, float s) {
    posx = x;
    posy = y;
    size = s;
  }
  
  void display() {
    fill(0);
    rect(posx, posy, size, size);
  }
}

class Qrid {
  int qsize;
  Quare[] qgrid;
  
  Qrid(int s) {
    qsize = s;
    qgrid = new Quare[qsize*qsize];
    initializeQuares();
  }
  
  void initializeQuares() {
    int k = 0;
    for (int i=0; i<qsize; i++) {
      for (int j=0; j<qsize; j++) {
        float offset = 0.5*(qsize);
        float dim = SIZE/qsize;
        qgrid[k] = new Quare(j*(dim+offset), i*(dim+offset), dim);
        k++;
      }
    } 
  }
  
  void displayQrid() {
    stroke(230);
    for (int i=0; i<qsize+1; i++) {
      line(i*SIZE/qsize, 0, i*SIZE/qsize, 500);
    }
    for (int j=0; j<qsize+1; j++) {
      line(0, j*SIZE/qsize, 500, j*SIZE/qsize); 
    }
  }
  
  void displayQuares() {
    for (int i=0; i<qgrid.length; i++) {
      qgrid[i].display();
    }
  }
}
