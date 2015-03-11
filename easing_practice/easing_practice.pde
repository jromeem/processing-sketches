float time, angle;
int numFrames = 140;

boolean debug = false;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  background(255);
  translate(40, 40);
  
  // track time for all squares
  time = map(frameCount, 0, numFrames, 0, 1);
  
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      pushMatrix();
      translate(140*j, 140*i);
      if (debug)
        ellipse(70, 70, 140, 140);
        
        Quare quare = new Quare(color(255,255,255), color(255,0,0));
        quare.animate();
      
      popMatrix();
    } 
  }
 
  if (frameCount == numFrames) {
    exit();
  }
}

class Quare {
  color startColor;  // starting color
  color transColor;  // transitioning color
  
  Quare(color sColor, color tColor) {
    startColor = sColor;
    transColor = tColor; 
  }
  
  // animating function - using time global
  void animate() {
    // time constrains
    if (time < 0.15) {
      angle = easeOutQuart(time, 0, -20, 0.15);
    } else {
      float ani2 = map(time, 0.15, 1, 0, 0.85);
      angle = easeOutQuart(ani2, -20, 20+270, 0.85);
    }
    
    // angle constrains
    if (angle < 45) {
      fill(startColor); 
    } else if (angle > 45 && time < 0.5) {  // wow so hacky sack
      fill(colorEase(startColor, transColor, 0.5));
    } else {
      fill(transColor);
    }
    
    translate(70, 70);
    rotate(radians(angle));
    rect(-(70*sqrt(2)/2),-(70*sqrt(2)/2), 70*sqrt(2), 70*sqrt(2));
  }
}

color colorEase(color current, color target, float duration) {
  float r = easeInOutQuart(time, red(current), red(target)-red(current), duration, 0);
  float g = easeInOutQuart(time, green(current), green(target)-green(current), duration, 0);
  float b = easeInOutQuart(time, blue(current), blue(target)-blue(current), duration, 0);
  return color(r, g, b);
}

float linearTween(float t, float b, float c, float d, float delay) {
  assert delay < d;
  if (time < delay)
    return b;
  else {
    return c*(t-delay)/(d-delay) + b;
  }
}

float easeOutQuart(float t, float b, float c, float d) {
  t /= d;
  t--;
  return -c * (t*t*t*t - 1) + b; 
}

float easeInOutSine(float t, float b, float c, float d) {
  return -c/2 * (cos(PI*t/d) - 1) + b; 
}

float easeInOutExpo(float t, float b, float c, float d, float delay) {
  if (t < delay) {
    return b; 
  } else {
    t = t-delay; d = d-delay;   
    t /= d/2;
    if (t < 1) return c/2 * pow(2, 10*(t-1)) + b;
    t--;
    return c/2 * (-pow(2, -10*t) + 2) + b;
  }
}

float easeInOutQuart(float t, float b, float c, float d, float delay) {
  if (t < delay) {
    return b;
  } else {
    // offset time and duration by delay
    t = t-delay; d = d-delay;
    t /= d/2;
    if (t < 1) return c/2*t*t*t*t + b;
    t -= 2;
    return -c/2 * (t*t*t*t - 2) + b;
  }
}

float easeInOutCirc(float t, float b, float c, float d) {
  t /= d/2;
  if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
  t -=2;
  return c/2 * (sqrt(1 - t*t) + 1) + b;
}
