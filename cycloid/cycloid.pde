// cycloid framework
// circle + path classes???

void setup() {
  // cycloid framework 
  size(500, 500, P2D);
  background(255);
  smooth();
  noLoop();
}

void draw() {
  // draw here
//  ellipse(100, 100, 50, 50);
  line(0, 125, 500, 125);
  Spiro s = new Spiro(100, 100, 25);
  s.display();
  
  
  println(s.posx());
  s.setx(150);
  println(s.posx());
}

class Spiro {
  float posx;
  float posy;
  float radius;
  float diameter;
  
  Spiro(float x, float y, float r) {
    this.posx = x;
    this.posy = y;
    this.radius = r;
    this.diameter = this.radius * 2;
  }
  
  void display() {
    ellipse(this.posx, this.posy, this.diameter, this.diameter);
  }
  
  float posx() { return this.posx; }
  float posy() { return this.posy; }
  
  float setx(float x) { this.posx = x; return this.posx; }
  float sety(float y) { this.posy = y; return this.posy; }
}

class Path {
  float start;
  float function;
  
  Path(float start) {
    
  }
  
  void circlePath() {
     
  }
}
