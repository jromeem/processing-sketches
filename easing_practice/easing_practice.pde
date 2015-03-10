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
  fill(easeInOutQuart(time, -500, 255+500, 1),
       easeInOutQuart(time, 0, -500, 1),
       easeInOutQuart(time, 0, -500, 1));
  
  angle = 0;
  if (time < 0.09) {
//    float ani1 = map(time, 0, 0.1, 0, 0.1);
    angle = easeInOutExpo(time, 0, -20, 0.09);
    
  } else {
    float ani2 = map(time, 0.09, 1, 0, 0.91);
    angle = easeInOutExpo(ani2, -20, 20+360, 0.91);
  }
  
  if (frameCount == numFrames) {
    exit();
  }
  
  rotate(radians(angle));
  rect(-50, -50, 100, 100);
}

float easeOutQuart(float t, float b, float c, float d) {
  t /= d;
  t--;
  return (c*t*t*t*t - 1) + b; 
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
