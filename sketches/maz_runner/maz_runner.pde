int SIZE = 500;
int QSIZE = 20;

boolean IMAGE_MODE = false;

Theme th = new Theme();
Qrid q = new Qrid(QSIZE);

Quare[] stack;
Quare current;
Quare next;
Quare previous;

PImage parn;

void setup() {
  //parn = loadImage("floral.png");
  //parn.loadPixels();

  noStroke();
  size(960, 540, P2D);

  th.loadMinuet();

  q.displayQrid();
  q.displayQuares();
  background(th.bkgd());

  q.makeNeighbors();
  Quare start = q.highlightRandom();
  Quare[] temp = { start };
  stack = temp;

  frameRate(200);
}

void draw() {
  scale(1.92, 1.08);
  //translate(5,5);
  current = stack[stack.length-1];
  //  current.display();

  if (current.allVisited()) {

    // for uploading an image   
    if (IMAGE_MODE)
      fill(parn.get(int(current.posx()), int(current.posy())));
    else
      fill(th.snk());

    if (stack.length > 1)
      current.connectNeighbor(stack[stack.length-2]);

    stack = (Quare[]) shorten(stack);
    if (stack.length == 0) {
      fill(th.snk());

      float dim = SIZE/(q.qsize*2.0);
      float offset = 0.5*dim;

      //saveFrame("f####.png");

      // 'exits'
      //rect(0-10, offset, SIZE/q.qsize()/2.0, SIZE/q.qsize()/2.0);
      //rect(SIZE-offset, SIZE-3.0*offset, SIZE/q.qsize()/2.0 + 10 , SIZE/q.qsize()/2.0);

      noLoop();
    }
  } else {
    next = current.chooseRandomUnvisted();

    // for uploading an image
    if (IMAGE_MODE)
      fill(parn.get(int(current.posx()), int(current.posy())));
    else
      fill(th.psnk());

    current.visit(next);
    stack = (Quare[]) append(stack, next);
  }

  // saveFrame("f####.gif");
  if (frameCount < 800) {
    saveFrame("f####.png");
  } else {
    exit();
  }
}

void resetdraw() {
  q = new Qrid(QSIZE);
  q.makeNeighbors();
  Quare start = q.highlightRandom();
  Quare[] temp = { start };
  stack = temp;

  background(th.bkgd());
}

void mouseClicked() {
  th.loadBolero();
  q = new Qrid(QSIZE);
  q.makeNeighbors();
  Quare start = q.highlightRandom();
  Quare[] temp = { start };
  stack = temp;

  background(th.bkgd());
  redraw();
  loop();
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
    if (top != null) { 
      top.display();
    }
    if (right != null) { 
      right.display();
    }
    if (bottom != null) { 
      bottom.display();
    }
    if (left != null) { 
      left.display();
    }
  }

  void connectNeighbor(Quare neigh) {
    int dx = int((neigh.posx()-posx)/abs(neigh.posx()-posx));
    int dy = int((neigh.posy()-posy)/abs(neigh.posy()-posy));

    rect(dx<0 ? dx*2*size+posx : posx, 
      dy<0 ? dy*2*size+posy : posy, 
      dy==0 ? size*3 : size, 
      dx==0 ? size*3 : size);

    fill(th.head());
    neigh.display();
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

    int[] distro = {0, 1, 2, 3};
    //int[] distro = {0,1,2,3,2,3,2,3,2,3,2,3,2};
    //int[] distro = {0,1,2,1,3,1,3,1,3,1,3,1,3};

    while (!chosen) {
      randmove = distro[int(random(distro.length))];
      switch(randmove) {
      case 0:
        if (top != null) {
          if (!top.seen())
            chosen = true; 
          chosenQuare = top;
        } 
        break;

      case 1:
        if (right != null) {
          if (!right.seen())
            chosen = true;
          chosenQuare = right;
        } 
        break;

      case 2:
        if (bottom != null) {
          if (!bottom.seen())
            chosen = true;
          chosenQuare = bottom;
        } 
        break;

      case 3:
        if (left != null) {
          if (!left.seen())
            chosen = true;
          chosenQuare = left;
        } 
        break;

      default:
        println("error");
        exit();
        break;
      }
    }

    return chosenQuare;
  }

  int id() { 
    return id;
  }
  float posx() { 
    return posx;
  }
  float posy() { 
    return posy;
  }
  boolean seen() { 
    return seen;
  }
  void visited() { 
    seen = true;
  }
  Quare top() { 
    return top;
  }
  Quare right() { 
    return right;
  }
  Quare bottom() { 
    return bottom;
  }
  Quare left() { 
    return left;
  }
}

class Qrid {
  int qsize;
  Quare[] qgrid;

  Qrid(int s) {
    qsize = s;
    qgrid = new Quare[int(qsize*qsize)];
    initializeQuares();
  }

  int qsize() { 
    return qsize;
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
    fill(th.bkgd);
    qgrid[randpos].display();
    return qgrid[randpos];
  }
}

class Theme {
  color bkgd;
  color snk;
  color psnk;
  color head;

  Theme() {
    loadMinuet();
  }

  Theme(color b, color k, color p, color d) {
    bkgd = b;
    snk = k;
    psnk = p;
    head = d;
  }

  void loadMinuet() {
    bkgd = color(0, 54, 67);
    snk = color(148, 203, 74);
    psnk = color(71, 108, 94);
    head = color(249, 89, 0);
  }

  void loadBolero() {
    bkgd = color(51, 37, 50);
    snk = color(255, 151, 79);
    psnk = color(100, 77, 82);
    head = color(247, 122, 82);
  }

  void loadSerenade() {
    bkgd = color(49, 53, 61);
    snk = color(146, 205, 207);
    psnk = color(68, 88, 120);
    head = color(238, 239, 247);
  }

  void loadRequiem() {
    bkgd = color(245, 207, 102);
    snk = color(150, 82, 107);
    psnk = color(235, 173, 96);
    head = color(139, 171, 141);
  }

  void loadNocturne() {
    bkgd = color(0, 36, 46);
    snk = color(120, 74, 86);
    psnk = color(74, 46, 68);
    head = color(255, 255, 214);
  }

  void loadPrelude() {
    bkgd = color(255, 245, 224);
    snk = color(149, 209, 149);
    psnk = color(232, 230, 224);
    head = color(147, 237, 212);
  }

  void loadCheeseAndChives() {
    bkgd = color(255, 245, 224);
    snk = color(184, 217, 184);
    psnk = color(255, 230, 203);
    head = color(147, 237, 212);
  }

  color bkgd() { 
    return bkgd;
  }
  color snk() { 
    return snk;
  }
  color psnk() { 
    return psnk;
  }
  color head() { 
    return head;
  }
}