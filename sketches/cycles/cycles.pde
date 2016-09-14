int NUMCYS = 50;
int DIST = 30;
boolean debug = false;
boolean grad_thresh = false;

float cycle = 0;
Cycle[] cys = new Cycle[NUMCYS];

int themec = 1;
color[] themes = {color(230,80,80),
                  color(40,200,52),
                  color(68,128,210),
                  color(150, 150, 145)};
color theme = themes[themec];

void reset() {
  cys = new Cycle[NUMCYS];
  for (int i=0; i<NUMCYS; i++) {
    cys[i] = new Cycle(random(100,width-100), random(100,height-100), random(40,150));
  }
}

void setup() {
  size(2160,1080, P2D);
  color theme = themes[themec];
  blendMode(LIGHTEST);
  reset();
}

void draw() {
  scale(1.5);
  translate(-80,-80);
  background(color(44,46,42));
  
  for (int j=0; j<NUMCYS; j++) {
    cys[j].display();
    for (int k=0; k<NUMCYS; k++) {
      float dist = cys[j].mm.v.dist(cys[k].mm.v);
      if (dist < DIST) {

        if (grad_thresh) {
          stroke(map(dist,0,DIST,red(theme),30),
                 map(dist,0,DIST,green(theme),30),
                 map(dist,0,DIST,blue(theme),30));
        } else {
          stroke(theme);
        }
        line(cys[j].mm.v.x, cys[j].mm.v.y, cys[k].mm.v.x, cys[k].mm.v.y);
      }
    } 
  }
  cycle += 0.01;
  
//  saveFrame("f#####.gif");
//  if (cycle*3 >= TWO_PI) {
//    exit(); 
//  }

}

void mousePressed() {
//  themec++;
//  if (themec > 3) themec = 0;
//  theme = themes[themec];
//  exit();
  reset();
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    NUMCYS += 5;
    reset(); 
  } else if (key == 's' || key == 'S') {
    NUMCYS -= 5;
    reset(); 
  } else if (key == 'a' || key == 'A') {
    debug = !debug;
  } else if (key == 'd' || key == 'D') {
    grad_thresh = !grad_thresh;
  } else if (key == 't' || key == 'T') {
    saveFrame("f#####.png");
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      DIST += 5;
    } else if (keyCode == DOWN) {
      DIST -= 5;
    } else {
      // do nothing 
    }
  }
  
  if (NUMCYS < 0) {
    NUMCYS = 0; 
  }
  if (DIST < 0) {
    DIST = 0; 
  }
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
     this.velocity = 3 * direction;
     float rangle = random(0, TWO_PI);
     
     float mmx = this.v.x + this.radius * cos(rangle);
     float mmy = this.v.y + this.radius * sin(rangle);
     this.mm = new Movi(mmx, mmy, rangle);
  }
  
  void display() {
     if (debug) {
       noFill();
       stroke(30,60,30);
       ellipse(this.v.x, this.v.y, this.size, this.size);
     }
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