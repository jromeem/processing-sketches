PImage img;
int[][] values;
int currentFrame;
int frameSample = 140;
boolean saveFrames = false;

void setup() {
  size(500, 500);
  values = new int[width][height];
  img = loadImage("beauty.jpg");
  img.loadPixels();
  noStroke();
  image(img, 0, 0);
  frameRate(1000);
}

void draw() {
  int randx = int(random(0,500));
  int randy = int(random(0,500));
  color randc = img.get(randx, randy);
  
  int randx_offset = int(random(0,8));
  int randy_offset = int(random(0,8));
  
  float randh = random(5,7) + random(3,7);
  float randw = randh * random(4,8);
  float rands = random(2,5);
  
  fill(randc);
  rect(randx+randx_offset, randy+randy_offset, randw, rands);
  
  if (saveFrames && frameCount-currentFrame < frameSample) {
    //saveFrame("f###.gif");
  }
}

void mousePressed() {
  saveFrames = true;
  currentFrame = frameCount;
}
