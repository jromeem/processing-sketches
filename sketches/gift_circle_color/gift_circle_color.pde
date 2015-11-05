
float h;
float k;
float radius = 200;
int theta = 0;

color cc;

void setup() {
  size(500, 500, P2D);
  
  // the circle's center
  h = width/2;
  k = height/2; 
  
  noStroke();
}

void draw() {
  background(255);
  
  // draw the circle on different points of the circle
  float x = radius * cos(radians(theta)) + h;
  float y = radius * sin(radians(theta)) + k;
  
  cc = getColor(theta);
  fill(cc);
  ellipse(x, y, 50, 50);
  
  theta++;
  
  if (radians(theta) <= TWO_PI) {
//    saveFrame("f####.gif");
  }
}

color getColor(int theta) {
  float freq = 0.1;
  float red = sin(radians(theta + 0)) * 127 + 128;
  float green = sin(radians(theta + 90)) * 127 + 128;
  float blue = sin(radians(theta + 180)) * 127 + 128;
  
  cc = color(red, green, blue);
  
  return cc;
}
