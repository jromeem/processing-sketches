void setup() {
  size(500,500,P2D);
  //fullScreen(P2D);
  pixelDensity(2);
  noStroke();
  colorMode(HSB, height);
  background(0);
}

void draw() {
  fill(mouseY, 200, height);
  rect(mouseX - mouseX%50, 0, 50, height);
}
