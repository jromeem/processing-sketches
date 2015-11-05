
color cc;
float red;
float green;
float blue;

int theta = 0;
PShape circle;
float freq = 0.1;

void setup() {
  size(500, 500, P2D);
  noStroke();
  background(255);
}

void draw() {
  red = sin(freq*theta + 0) * 127 + 128;
  green = sin(freq*theta + 2) * 127 + 128;
  blue = sin(freq*theta + 4) * 127 + 128;
  
  cc = color(red, green, blue);
  
  fill(cc);
  ellipse(250, 250, 200, 200);
  
  theta++;
  
  if ((freq*theta + 0) <= TWO_PI) {
    saveFrame("f####.gif");
  }
  
}
