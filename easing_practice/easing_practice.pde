float time, angle;
int numFrames = 100;
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
boolean switched = false;


color BL = color(62,97,166);
color GN = color(142,191,69);
color YL = color(217,192,67);
color PK = color(255,160,169);
color LGN = color(163,212,111);
color WT = color(255,255,255);

void setup() {
  size(500, 500);
  noStroke();
  for (int i=0; i<9; i++) {
    if (i % 2 == 0) {
      quares[i] = new Quare(LGN,WT,i*0.0);
    } else {
      quares[i] = new Quare(WT,LGN,i*0.0); 
    }
    //quares[i] = new Quare(theme[(i+1)%9], theme[i], i*0.05);
  }
}

void draw() {
  background(PK);
  translate(40, 40);
  
  // track time for all squares
  time = map(frameCount, 0, numFrames, 0, 1) % 1;
  
  int count = 0;
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      pushMatrix();
        translate(140*j, 140*i);
        //pushMatrix();
          //Quare quare = new Quare(color(255,255,255), color(255,0,0));
          //quare.animate();
          // each animation starts at each 0.5 mark
          if (time - quares[count].delay > 0 && time - quares[count].delay <= 1)
            quares[count].animate();
          else
            quares[count].station();
        //popMatrix();
      popMatrix();
      
      count++;
    } 
  }
  
  if (frameCount % 100 == 0) {
    switched = !switched; 
  }
  
//  saveFrame("f###.gif");
//  if (frameCount == 200) {
//    exit();
//  }
}

class Quare {
  color startColor;  // starting color
  color transColor;  // transitioning color
  float delay;
  

  
  Quare(color sColor, color tColor, float d) {
    startColor = sColor;
    transColor = tColor;
    delay = d;
  }
  
  // animating function - using time global
  void animate() {
    // time constrains
    if (time-delay < 0.15) {
      angle = easeOutQuart(time-delay, 0, -20, 0.15);
    } else {
      float ani2 = map(time-delay, 0.15, 1, 0, 0.85);
      angle = easeOutQuart(ani2, -20, 20+270, 0.85);
    }
    
    // angle constrains
    if (angle < 45) {
      if (switched)
        fill(startColor); 
      else
        fill(transColor);
    } else if (angle > 45 && time-delay < 0.5) {  // wow so hacky sack
      if (switched)
        fill(colorEase(startColor, transColor, 0.5));
      else
        fill(colorEase(transColor, startColor, 0.5));
    } else {
      if (switched)
        fill(transColor);
      else
        fill(startColor);
    }
    
    translate(70, 70);
    rotate(radians(angle));
    rect(-(70*sqrt(2)/2),-(70*sqrt(2)/2), 70*sqrt(2), 70*sqrt(2), 8);
  }
  
  void station() {
    pushMatrix();
    translate(70, 70);
    if (switched)
      fill(transColor);
    else
      fill(startColor);
    rect(-(70*sqrt(2)/2),-(70*sqrt(2)/2), 70*sqrt(2), 70*sqrt(2), 8);
    popMatrix();
  }
  
  color colorEase(color current, color target, float duration) {
    float r = easeInOutQuart(time-delay, red(current), red(target)-red(current), duration, 0);
    float g = easeInOutQuart(time-delay, green(current), green(target)-green(current), duration, 0);
    float b = easeInOutQuart(time-delay, blue(current), blue(target)-blue(current), duration, 0);
    return color(r, g, b);
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
