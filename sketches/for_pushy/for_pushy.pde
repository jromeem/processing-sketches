float t;
float rotateVal = 0.0;
int nf = 225;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  t = frameCount/float(nf);
  
  rotateVal += 3.2;
  translate(250, 250);
  
  background(150, 200, 155);  
  for (int i=0; i<5; i++) {
    pushMatrix();
    rotateZ( cos(radians(rotateVal+i*12)) );
    noStroke();
    fill(255+(i*20), 255-(i*20), 150-(i*10)); 
    rect(-100, -100, 200, 200);
    popMatrix();
  }
  
//  saveFrame("f###.gif");
//  if(frameCount==nf)
//    exit();
}
