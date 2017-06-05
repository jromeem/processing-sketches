Iris[] newIris = new Iris[1000];

// noise factors
float noiseScale = 500, noiseStrength = 50;

// noise display factors
float overlayAlpha = 0, irisAlpha = 255, strokeWidth = 0.75;

// main circle parameters
float radius = 150;
float rTemp = radius;

// animation related variables
float limit = 200, timer = 0;

// colors
color bckg = #000000, c1 = #ffffff;

color cc;

void setup() {
  size(700,700);
  pixelDensity(2);
  smooth();
  
  background(bckg);
  frameRate(25);

  for (int i = 0; i < newIris.length; i++) {
    newIris[i] = new Iris();
  }
}

void draw() {
  // draw background grid
  for (int i=0; i<width; i+=30) {
    for (int y=0; y<height; y+=30) {
      stroke(random(255), random(255), random(255));
      point(i, y);
    }
  }
  
  
  // background related
  fill(bckg, overlayAlpha);
  rect(-5, -5, width+10, height+10);
  
  if ( (timer = (timer + .5)) > limit - 20) {
    // this is for that quick fade at the end of a cycle
    fill(bckg, overlayAlpha + 40);
    rect(-5, -5, width+10, height+10);
  }

  // Animate Iris
  cc = color(random(255), random(255), random(255));
  for (int i = 0; i < newIris.length; i++) newIris[i].drawIris(cc);

  // reset parameters every time 'limit' is hit
  if ( (timer = (timer + .5) % limit) == 0 ) {
    for (int i = 0; i < newIris.length; i++) {
      newIris[i].reDrawIt();
    }
  }
  //saveFrame("f####.gif");
}


///////////////////////


class Iris {
  // x,y    = the current position
  // ox,oy  = the position, but slightly back in time
  // sx,sy  = start positions
  float x, y, ox, oy, sx, sy;

  float angle = 0, step;
  int NDo;
  boolean isOutside = false;  

  Iris() {
    step = 5;
    NDo = int(random(360));
    sx = width/2  + radius * cos(NDo);
    sy = height/2 + radius * sin(NDo);
    x = sx;
    y = sy;
  }

  void drawIris(color cF) {
    // calculate angle which is based on noise
    // and then use it for x and y positions
    angle = noise(x / noiseScale, y / noiseScale) * noiseStrength;

    // write in the last value of x,y into ox,oy >> old x, old y
    // i need these values to display the line();
    ox = x;
    oy = y;

    // radius change for every cycle
    radius = rGen();

    // calculate new x and y position
    x += cos(angle) * step;
    y += sin(angle) * step;

    // what happens when x and y hit the outside
    if (x < -2) isOutside = true;
    else if (x > width + 2) isOutside = true;
    else if (y < -2) isOutside = true;
    else if (y > height + 2) isOutside = true;

    if (isOutside) {
      x = ox;
      y = oy;
    }

    // display it
    noFill();
    if (int(random(200)) < 80) {
      stroke(cF, irisAlpha);
    } else {
      stroke(c1, irisAlpha); 
    }
    strokeWeight(strokeWidth);
    //line(ox, oy, x, y);
    point(ox, oy);
    point(x, y);
    
    // return boolean to false for next cycle
    isOutside = false;
  }

  void reDrawIt() {
    // background reset
    fill(bckg);
    rect(-5, -5, width+10, height+10);

    // new noise
    noiseScale = int(random(400, 700));
    noiseStrength = int(random(25,75));
    noiseDetail(int(random(1, 10)), 0.5);

    // parameters reset
    x = sx;
    y = sy;
    NDo = int(random(360));
    sx = width/2  + radius * cos(NDo);
    sy = height/2 + radius * sin(NDo);
    ox = x;
    oy = y;
  }
}

float rGen() {
  float r = random(0.65, 1.5) * rTemp;
  return r;
}