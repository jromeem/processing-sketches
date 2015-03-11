float time, angle;
int numFrames = 140*9/2;
int frameSample = 70;
boolean debug = false;
Quare[] quares = new Quare[9];
color[] theme = {
    color(76,78,115),
    color(76,97,115),
    color(60,89,86),
    color(85,217,131),
    color(32,191,27),
    color(34,84,115),
    color(80,191,151),
    color(50,140,107),
    color(44,115,95)
  };

void setup() {
  size(500, 500);
  noStroke();
  for (int i=0; i<9; i++) {
    quares[i] = new Quare(theme[(i+1)%9], theme[i], i*0.5);
  }
}

void draw() {
  background(80);
  translate(40, 40);
  
  // track time for all squares
  time = map(frameCount, 0, numFrames, 0, 4.5);
  
  int count = 0;
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      pushMatrix();
        translate(140*j, 140*i);
        pushMatrix();
//          Quare quare = new Quare(color(255,255,255), color(255,0,0));
//          quare.animate(); 
            quares[count].animate();
        popMatrix();
      popMatrix();
      
      count++;
    } 
  }
 
  if (frameCount == numFrames) {
    exit();
  }
}

class Quare {
  color startColor;  // starting color
  color transColor;  // transitioning color
  float aniDelay;
  
  Quare(color sColor, color tColor, float delay) {
    startColor = sColor;
    transColor = tColor;
    aniDelay = delay;
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
    rect(-(70*sqrt(2)/2),-(70*sqrt(2)/2), 70*sqrt(2), 70*sqrt(2), 8);
  }
  
  void station() {
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
