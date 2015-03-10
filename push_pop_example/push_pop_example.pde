float rotateVal = 0.0;

void setup() {
  size(300, 300, P3D);
}

void draw() {
  background(74, 83, 75);
  translate(150, 150);
  
  rotateVal += 3.2;
  
  pushMatrix();
  rotateZ(cos(radians(rotateVal)));
  noStroke();
  fill(255,90,90);
  rect(-75, -75, 150, 150);
  popMatrix();
  
  pushMatrix();
  rotateZ(cos(radians(rotateVal + 10)));
  noStroke();
  fill(255,70,70);
  rect(-75, -75, 150, 150);
  popMatrix();
  
  pushMatrix();
  rotateZ(cos(radians(rotateVal + 20)));
  noStroke();
  fill(255,50,50);
  rect(-75, -75, 150, 150);
  popMatrix();
  
}
