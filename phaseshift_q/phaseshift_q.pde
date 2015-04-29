Cycle a;
Cycle b;
Cycle c;
Cycle d;

float cycle = 0;

void setup() {
  size(300, 500);
  a = new Cycle(125/2.0+5, 0.5*125.0, 110);
  b = new Cycle(125/2.0+5, 1.5*125.0, 110);
  c = new Cycle(125/2.0+5, 2.5*125.0, 110);
//  d = new Cycle(125/2.0+10, 1.5*125.0+15, 100);
}

void draw() {
  background(255);
  a.display();
  b.display();
  c.display();
  cycle += 0.01;
}

class Cycle {
  PVector v;
  float size;
  float radius;
  
  float velocity;
  Movi mm;
  
  Cycle(float x, float y, float s) {
     this.v = new PVector(x, y);
     this.size = s;
     this.radius = this.size/2.0;
     
     int[] d = {-1,1};
     int direction = d[int(random(d.length))];
     this.velocity = random(3, 8) * direction;
     float rangle = random(0, TWO_PI);
     
     float mmx = this.v.x + this.radius * cos(rangle);
     float mmy = this.v.y + this.radius * sin(rangle);
     this.mm = new Movi(mmx, mmy, rangle);
  }
  
  void display() {
     noFill();
     stroke(60,60,60);
     ellipse(this.v.x, this.v.y, this.size, this.size);
     this.mm.v.set(this.v.x + this.radius * cos(this.velocity*(this.mm.offset + cycle)),
                   this.v.y + this.radius * sin(this.velocity*(this.mm.offset + cycle)));
     this.mm.display();
  }
}

class Movi {
  PVector v;
  float offset;
  float velocity;
  
  Movi (float x, float y, float o) {
    this.v = new PVector(x, y);
    this.offset = o;
  }
  
  void display() {
    noStroke();
    fill(0,0,255);
    ellipse(this.v.x, this.v.y, 5, 5);
  }
}
