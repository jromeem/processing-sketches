// chocolate

void setup() {
  size(500,500);
}

void draw() {
  background(255,255,255);
  Bite b = new Bite(20, 20, 50, 100);
  b.animate();
}

class Bar {
  int chocoWidth;
  int chocoHeight;
  int bitWidth;
  int bitHeight;
  Bite[] morsels = new Bite[(chocoWidth/bitWidth) * (chocoHeight/bitHeight)];
  
  Bar(int wd, int ht, int bw, int bh) {
    chocoWidth = wd;
    chocoHeight = ht;
    bitWidth = bw;
    bitHeight = bh;
    for (int i=0; i<morsels.length; i++) {
      rect 
    }
  }
  
  void animate() {
    // pass animation here 
  }
}

class Bite {
  int xpos;
  int ypos;
  int cWidth;
  int cHeight;
  
  Bite(int x, int y, int wd, int ht) {
    cWidth = wd;
    cHeight = ht;
    xpos = x;
    ypos = y;
  }
  
  void animate() {
    rect(xpos, ypos, cWidth, cHeight);
  }
}

class Wrap {
  
}
