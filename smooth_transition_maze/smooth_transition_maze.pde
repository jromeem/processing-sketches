int t = 0;

void setup() {
  size(500, 500);
  background(255);
  frameRate(120);
}

void draw() {

  background(255);
  
  int s = 30;

  // src
  float srcx = 150;
  float srcy = 150;

  // dest
  float destx = 150;
  float desty = 300;
  
  int dx = int((destx-srcx)/abs(destx-srcx));
  int dy = int((desty-srcy)/abs(desty-srcy));
  // println(dx + " " + dy);

  noStroke();

  // source
  fill(0, 0, 255);
  rect(srcx, srcy, s, s);
  // destination
  fill(240, 245, 0);
  rect(destx, desty, s, s);

  fill(100);
  float ltx = linearTween(t, srcx, destx-srcx, 50);
  println(ltx);
  float lty = linearTween(t, srcy, desty-srcy, 50);
  
  if (dx == 0 && dy == 1)
    rect(srcx, srcy, s, lty-srcy);
  if (dx == 0 && dy == -1) 
    rect(srcx, lty, s, srcy-lty);
  
  if (dy == 0 && dx == 1)
    rect(srcx, srcy, ltx-srcx, s);
  if (dy == 0 && dx == -1) 
    rect(ltx, srcy, srcx-ltx, s);

  fill(255, 0, 0);
  rect(ltx, lty, 30, 30);

  if (t < 50)
    t++;
  else
    exit();
}

float linearTween(float t, float b, float c, float d) {
  return c*t/d + b;
}

