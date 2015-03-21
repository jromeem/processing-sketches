int SIZE = 500;

void setup() {
  size(SIZE+1,SIZE+1,P2D);
  background(255);
  // draw once
  noLoop();
}

void draw() {
  Qrid q = new Qrid(20);
  stroke(230);
  q.displayQrid();
  fill(230);
  noStroke();
  q.displayQuares();
  q.makeNeighbors();
  fill(255,0,0);
  Quare t = q.highlightRandom();
  fill(0,0,255);
  t.highlightNeighbors();
}

void mouseClicked() {
  redraw();
}

class Quare {
  float posx;
  float posy;
  float size;
  
  int id;
  boolean seen = false;
  
  Quare top;
  Quare bottom;
  Quare left;
  Quare right;
  
  Quare(float x, float y, float s, int i) {
    posx = x;
    posy = y;
    size = s;
    id = i;
  }
  
  void display() {
    rect(posx, posy, size, size);
  }
  
  void setNeighbors(Quare tp, Quare rt, Quare bt, Quare lt) {
    top = tp;
    right = rt; 
    bottom = bt;
    left = lt;
  }
  
  void highlightNeighbors() {
    if (top != null) { top.display(); }
    if (right != null) { right.display(); }
    if (bottom != null) { bottom.display(); }
    if (left != null) { left.display(); }
  }
  
  void connectNeighbor(Quare neigh) {
    int x = neigh.posx() < posx ? -2 : 2;
    int y = neigh.posy() < posy ? -2 : 2;
    rect(posx, posy,
         (neigh.posx()==posx) ? size : x*size,
         (neigh.posy()==posy) ? size : y*size);
  }
  
  int id() { return id; }
  float posx() { return posx; }
  float posy() { return posy; }
  Quare top() { return top; }
  Quare right() { return right; }
  Quare bottom() { return bottom; }
  Quare left() { return left; }
}

class Qrid {
  int qsize;
  Quare[] qgrid;
  
  Qrid(int s) {
    qsize = s;
    qgrid = new Quare[int(qsize*qsize)];
    initializeQuares();
  }
  
  void initializeQuares() {
    int k = 0;
    for (int i=0; i<2*qsize; i+=2) {
      for (int j=0; j<2*qsize; j+=2) {
        float dim = SIZE/(qsize*2.0);
        float offset = 0.5*dim;
        qgrid[k] = new Quare((j*dim)+offset, (i*dim)+offset, dim, k);
        k++;
      }
    } 
  }
  
  void displayQrid() {
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
  
  void makeNeighbors() {
    for (int k=0; k<qgrid.length; k++) {
      Quare top = (k-qsize<0) ? null : qgrid[k-qsize];
      Quare rgt = (k%qsize==qsize-1) ? null : qgrid[k+1];
      Quare bot = (k+qsize>qgrid.length-1) ? null : qgrid[k+qsize];
      Quare lft = (k%qsize==0) ? null : qgrid[k-1];
      qgrid[k].setNeighbors(top, rgt, bot, lft);
    }
  }
  
  Quare highlightRandom() {
    int randpos = int(random(0, qgrid.length));
    qgrid[randpos].display();
    return qgrid[randpos];
  }
}
