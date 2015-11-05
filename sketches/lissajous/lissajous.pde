float t;
float tt;
PVector last;
float x = 0;
float y = 0;
float a = int(random(10,20));
float b = int(random(10,20));

PGraphics curvey;

float delta = 600;
float theta = TWO_PI/delta;

float tt_delta = 120;
float tt_theta = TWO_PI/tt_delta;

void setup() {
  size(500,500);
  frameRate(5000);
  background(50);
  curvey = createGraphics(500,500);
  
  a = 15-(tt_delta*0.01);
//  a = 15;
  b = 15;
}
void draw() {
  background(50);
  while (t < TWO_PI) {
    curvey.beginDraw();
    curvey.stroke(0,255,0);
    curvey.translate(250,250);
    last = new PVector(x,y);
    println("a: "+ a + " b: " + b + " r:" + (a/b));
    x = 250*cos(a*t);
    y = 250*cos(b*t);
    if (t > 0)
      curvey.line(last.x, last.y, x, y);
    curvey.endDraw();
    t += theta;
  }
  if (t >= TWO_PI) {
    t = 0;
    scale(sqrt(2)/2);
    translate(500*sqrt(2)/2,500/sqrt(2));
    rotate(QUARTER_PI);
    
    image(curvey, -250, -250);
    reset();
    
    tt += tt_theta;
    a += 0.01;
  }
  
//  saveFrame("f2####.gif");
  if (frameCount == 120) {
    println(frameCount);
    exit(); 
  }
}

void reset() {
  curvey.beginDraw();
  curvey.background(50);
  curvey.endDraw(); 
}

