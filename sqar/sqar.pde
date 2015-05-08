// yellow and orange squares against a white background
// drawn only on from their corners as points

int numsquar = 10;
ArrayList<Squar> squars = new ArrayList<Squar>();

void setup() {
  size(500,500);
  noStroke();
}

void draw() {
  background(255);
  println(squars.size());
  for (int i=0; i<squars.size(); i++) {
    squars.get(i).display(); 
  }
}

void mousePressed() {
  Squar make;
  do {
    
  } while
  
  squars.add(new Squar(rx,ry,rs));
  
  
  println(squars.size());
}

booleana collide() {
  
  
}

class Squar {
  PVector v;
  float size;
  color c;
  Squar(float x, float y, float s) {
    this.v = new PVector(x, y);
    this.size = s;
    int r = int(random(2)); // --> 0 || 1
    this.c = r == 1 ? color(255,255,26) : color(253,141,0);
  } 
  void display() {
    fill(this.c);
    rect(this.v.x, this.v.y, this.size, this.size); 
  } 
}
