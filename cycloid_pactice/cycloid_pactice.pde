// pure rotational motion

float t = 0;

void setup() {
  size(500, 500, P3D);
  noStroke();
}

void draw() {
  background(255);
  
  stroke(150);
  line(0,300, 500,300);
  noStroke();
  
  pushMatrix();
  //
    translate(50+t,250); // center of the circle
    rotate(radians(t)) ;  // t rotate
  
    fill(230);
    ellipse(0,0,100,100);
    
    stroke(255,0,0);
    line(0, 0, 0, 50);
    
    
      stroke(0, 255, 0);
      line(10, 10, 20, 20);
      noStroke();
      
    noStroke();
  //
  popMatrix();
  
  t += 0.5;
}
