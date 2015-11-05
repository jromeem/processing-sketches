float rotateVal = 0.0;

void setup() {
  size(300, 300, P2D);
  shapeMode(CENTER);
}

void draw() {
  background(50);
  
  pushMatrix();
  
  
  rotateVal += 1.2;
  rotate(radians(rotateVal));
  
  rect(75, 75, 150, 150);
  noStroke();
  fill(255,50,50);
  
  popMatrix();
  
}
