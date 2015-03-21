int SIZE = 500;
int jj = 0;

Qrid q = new Qrid(20);
Quare[] stack;
Quare current;
Quare next;
Quare previous;

void setup() {
  size(SIZE+1,SIZE+1,P2D);
  background(255);
  
  stroke(230);
  q.displayQrid();
  fill(230);
  noStroke();
  q.displayQuares();
  q.makeNeighbors();
  
  Quare start = q.highlightRandom();
  Quare[] temp = { start };
  stack = temp;
  
  frameRate(30);
//  noLoop();
}

void draw() {
  current = stack[stack.length-1];
  
  current.display();
  
  if (current.allVisited()) {      
    fill(255,0,0);
    if (stack.length > 2)
      current.connectNeighbor(stack[stack.length-2]);

    stack = (Quare[]) shorten(stack);
    if (stack.length == 0)
      noLoop();
  } else {
    next = current.chooseRandomUnvisted();
    fill(0);
    current.visit(next);
    
    // trailing front
    fill(255,0,0);
    next.display();

    stack = (Quare[]) append(stack, next);
  }
  
//  background(255);
//  stroke(230);
//  q.displayQrid();
//  fill(230);
//  noStroke();
//  q.displayQuares();
//  q.makeNeighbors();
//  
//  fill(255,0,0);
//  Quare t = q.highlightRandom();
//  Quare d = t.chooseRandomUnvisted();
//  t.visit(d);

}

void mouseClicked() {
  redraw();
  noLoop();
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
    int dx = int((neigh.posx()-posx)/abs(neigh.posx()-posx));
    int dy = int((neigh.posy()-posy)/abs(neigh.posy()-posy));
    
    rect(dx<0 ? dx*2*size+posx : posx,
         dy<0 ? dy*2*size+posy : posy,
         dy==0 ? size*3 : size,
         dx==0 ? size*3 : size);
  }
  
  Quare visit(Quare neighbor) {
    seen = true;
    connectNeighbor(neighbor);
    neighbor.visited();
    return neighbor;
  }
  
  boolean allVisited() {
    boolean all = true;
    if (top != null)
      all = all && top.seen();
    if (right != null)
      all = all && right.seen();
    if (left != null)
      all = all && left.seen();
    if (bottom != null)
      all = all && bottom.seen();
    return all;
  }
  
  // 0 - top; 1 - right; 2 - bottom; 3 - left
  Quare chooseRandomUnvisted() {
    int randmove;
    Quare chosenQuare = null;
    boolean chosen = false;
    
    while (!chosen) {
      randmove = int(random(4));
      switch(randmove) {
        case 0:
          if (top != null) {
            if (!top.seen())
              chosen = true; 
              chosenQuare = top;
          } break;
          
        case 1:
          if (right != null) {
            if (!right.seen())
              chosen = true;
              chosenQuare = right; 
          } break;
          
        case 2:
          if (bottom != null) {
            if (!bottom.seen())
              chosen = true;
              chosenQuare = bottom;
          } break;
          
        case 3:
          if (left != null) {
            if (!left.seen())
              chosen = true;
              chosenQuare = left; 
          } break;
          
        default:
          println("error");
          exit();
          break; 
      }
    }
    
    return chosenQuare;
  }
  
  int id() { return id; }
  float posx() { return posx; }
  float posy() { return posy; }
  boolean seen() { return seen; }
  void visited() { seen = true; }
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
  
  int qsize() { return qsize; }
  
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
