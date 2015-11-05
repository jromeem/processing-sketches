int divs = 2;
float outerangle = 0;
float angle = 0;

void setup() {
 size(500, 500, P3D);
}

void drawCircle() {
  noFill();
  stroke(0);
  ellipse(125, 125, 150.0*sqrt(2), 150.0*sqrt(2));
  fill(100);
  noStroke();
}

void draw() {
  stroke(0);
  background(255);
  line(0, 250, 500, 250);
  line(250, 0, 250, 500);

  noStroke();
  
  pushMatrix();
  // bigger rotation
  translate(width/2, height/2);
  outerangle += 0.75;
  rotate(radians(outerangle));
  
  for (int i=0; i<2; i++) {
    for (int j=0; j<2; j++) {
      pushMatrix();
      // translate for each quadrant
      // - 250 to offset the first translate
      translate(i*width/divs-250, j*height/divs-250);
      
      pushMatrix();
      // offset for square
      translate(125, 125);
      
      angle++;
      rotate(radians(angle));
      fill((angle), (outerangle-angle)%255, (outerangle)%255); 
      rect(-50, -50, 100, 100);
      
      popMatrix();
      
      //drawCircle();
      popMatrix(); 
    }
  }
  
  popMatrix();
}

class Squares {
  
  
}
