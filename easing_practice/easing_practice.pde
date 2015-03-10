float time, angle;
int numFrames = 140;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  
  // full rotation according to the frame count with easing
  time = map(frameCount, 0, numFrames, 0, 1);
  
  // color function
  //fill(easeInOutQuart(time, -50, 5000+255, 1), 0, 0);
  fill(colorEase(color(255,255,255), color(255,0,0)));
  
  if (time < 0.15) {
    angle = easeOutQuart(time, 0, -10, 0.15);
  } else {
    float ani2 = map(time, 0.15, 1, 0, 0.85);
    angle = easeOutQuart(ani2, -10, 10+270, 0.85);
  }
  
  if (frameCount == numFrames) {
    exit();
  }
  
  rotate(radians(angle));
  rect(-50, -50, 100, 100, 4);
}

color colorEase(color current, color target) {
  float r = easeInOutExpo(time, red(current), red(target)-red(current), 1);
  float g = easeInOutExpo(time, green(current), green(target)-green(current), 1);
  float b = easeInOutExpo(time, blue(current), blue(target)-blue(current), 1);
  return color(r, g, b);
}

float easeOutQuart(float t, float b, float c, float d) {
  t /= d;
  t--;
  return -c * (t*t*t*t - 1) + b; 
}

float easeInOutSine(float t, float b, float c, float d) {
  return -c/2 * (cos(PI*t/d) - 1) + b; 
}

float easeInOutExpo(float t, float b, float c, float d) {
  t /= d/2;
  if (t < 1) return c/2 * pow(2, 10*(t-1)) + b;
  t--;
  return c/2 * (-pow(2, -10*t) + 2) + b;
}

float easeInOutQuart(float t, float b, float c, float d) {
  t /= d/2;
  if (t < 1) return c/2*t*t*t*t + b;
  t -= 2;
  return -c/2 * (t*t*t*t - 2) + b;
}

float easeInOutCirc(float t, float b, float c, float d) {
  t /= d/2;
  if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
  t -=2;
  return c/2 * (sqrt(1 - t*t) + 1) + b;
}
