
float h;
float k;
float radius = 200;
int theta = 0;

float freq = 0.1;
color cc;

void setup() {
  size(500, 500, P2D);
  
  // the circle's center
  h = width/2;
  k = height/2;
 
  noStroke();
}

void draw() {
  scale(2);
  cc = getColor(theta/5);
  background(cc);

  translate(125, 125);
  rotate(radians(theta));

  for (int i=0; i<25; i++) {
    pushMatrix();
    rotate(360/5.0*i);
    cc = getColor(theta+i);
    fill(cc);
    ellipse(0, 50, 20, 60);
    popMatrix();
  }
  theta++;
  
  if (radians(theta) <= TWO_PI) {
//    saveFrame("ff####.gif"); 
  }
  
}

color getColor(int theta) {
  float freq = 0.1;
  float red = sin(freq*theta + 0) * 55 + 200;
  float green = sin(freq*theta + 2) * 55 + 200;
  float blue = sin(freq*theta + 4) * 55 + 200;
  
  cc = color(red, green, blue);
  
  return cc;
}

class Petal {
  float x;
  float y;
}
