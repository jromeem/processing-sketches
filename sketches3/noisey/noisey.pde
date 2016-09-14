  
float noiseVal;
float noiseScale=0.01;

PImage img;


void setup() {
  size(500,500);
  img = loadImage("img/nps-detail-0001.png");
  noLoop();
}

void draw() {
  background(img);
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      //noiseDetail(3,0.5);
      //noiseVal = noise((mouseX+x) * noiseScale, (mouseY+y) * noiseScale);
      //stroke(noiseVal*255);
      //point(x,y);
      noiseScale=0.2;
      noiseDetail(1,0.8);
      noiseVal = noise(noiseScale * random(0,10), noiseScale* random(0,10));
      float noiseCol = noiseVal * 255;
      stroke(noiseCol+50, noiseCol+50, noiseCol+50, 30);
      point(x, y);
    }
  }
  saveFrame("nps-detail-####.png");
  //exit();
}