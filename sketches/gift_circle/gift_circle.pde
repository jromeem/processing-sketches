
float h;
float k;
float radius = 200;
int theta = 0;

void setup() {
  size(500, 500, P2D);
  
  // the circle's center
  h = width/2;
  k = height/2; 
}

void draw() {
  background(255);
  
  // draw the circle on different points of the circle
  float x = radius * cos(radians(theta)) + h;
  float y = radius * sin(radians(theta)) + k;
  
  translate(-25, -25);
  fill(0);
  rect(x, y, 50, 50);
  
  theta++;
  
  if (radians(theta) <= TWO_PI) {
    saveFrame("f####.gif");
  }
}
