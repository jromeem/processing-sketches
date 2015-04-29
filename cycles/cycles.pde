int NUMCYS = 150;
int DIST = 50;
float cycle = 0;

Cycle[] cys = new Cycle[NUMCYS];

int themec = 0;
color[] themes = {color(230, 100, 100),
                  color(100, 230, 100),
                  color(100, 100, 230),
                  color(230, 230, 230)};
color theme = themes[themec];

void reset() {
  for (int i=0; i<NUMCYS; i++) {
    cys[i] = new Cycle(random(80,420), random(80,420), random(40,150));
  }
}

void setup() {
  size(500, 500, P2D);
  color theme = themes[themec];
  blendMode(LIGHTEST);
  reset();
}

void draw() {
  scale(1.5);
  translate(-80,-80);
  background(30);
  
  for (int j=0; j<NUMCYS; j++) {
    cys[j].display();
    for (int k=0; k<NUMCYS; k++) {
      float dist = cys[j].mm.v.dist(cys[k].mm.v);
      if (dist < 100) {
        stroke(map(dist,0,DIST,red(theme),30),
               map(dist,0,DIST,green(theme),30),
               map(dist,0,DIST,blue(theme),30));
        line(cys[j].mm.v.x, cys[j].mm.v.y, cys[k].mm.v.x, cys[k].mm.v.y);
      }
    } 
  }
  cycle += 0.01;
  saveFrame("f#####.gif");
}

void mousePressed() {
//  themec++;
//  if (themec > 3) themec = 0;
//  theme = themes[themec];
  exit();
  reset();
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
     this.velocity = random(1, 2) * direction;
     float rangle = random(0, TWO_PI);
     
     float mmx = this.v.x + this.radius * cos(rangle);
     float mmy = this.v.y + this.radius * sin(rangle);
     this.mm = new Movi(mmx, mmy, rangle);
  }
  
  void display() {
//     noFill();
//     stroke(30,60,30);
//     ellipse(this.v.x, this.v.y, this.size, this.size);
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
    fill(100,200,100);
    fill(theme);
    ellipse(this.v.x, this.v.y, 2, 2);
  }
}
