
PImage unitMask;
int padding = 10;
int unitMaskSize = 50;

int maskStart = unitMaskSize*padding;
int maskEnd = unitMaskSize*unitMaskSize - maskStart;

void setup() {
  unitMask = createImage(unitMaskSize, unitMaskSize, ARGB);
  unitMask.loadPixels();
  
  // fill top padding
  for (int i=0; i<maskStart; i++) {
    unitMask.pixels[i] = color(255,255,255,1);
  }
  
  // fill middle potion
  for (int i=maskStart; i<unitMask.pixels.length-maskStart; i++) {
    if ((i % unitMaskSize > padding) && (i % unitMaskSize < unitMaskSize-padding)) {
      unitMask.pixels[i] = color(255, 100, 100, 50); 
    } else {
      unitMask.pixels[i] = color(255,255,255,1); 
    }
  }
  
  // fill bottom padding
  for (int i=unitMask.pixels.length-maskStart; i<unitMask.pixels.length; i++) {
    unitMask.pixels[i] = color(255,255,255,1);  
  }

  unitMask.updatePixels();
  size(200,200);
  background(0);
}

void draw() {
  background(0);
  image(unitMask, 20, 20);
  strokeWeight(2);
  stroke(100);
  noFill();
  rect(20,20,unitMaskSize,unitMaskSize);
}