
void setup() {
  size(500,500);
  pixelDensity(2);
  blendMode(LIGHTEST);
  noStroke();
}

void draw() {
  background(0);
  fill(255,0,0);
  ellipse(195, 220, 250, 250);
  fill(0,255,0);
  ellipse(312, 220, 250, 250);
  fill(0,0,255);
  ellipse(250,312, 250,250);  
}