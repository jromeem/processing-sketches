
int theta = 0;
PShape square;

boolean debooger = false;

// radius for circle to trace
float radius = 175;

// circle's center
float h;
float k;

// initial setup
void setup() {
  size(500,500,P2D);
  background(255);
  
  h = width/2;
  k = height/2;
}

void draw() {
  background(255);
  
  // for the debugger 
  if (debooger) {
    debug();
  }
  
  // draw square in different points of the circle
  float x = radius * cos(radians(theta)) + h;
  float y = radius * sin(radians(theta)) + k;
  
  // draw square from the center
  translate(-10, -10);
  stroke(0);
  rect(x, y, 20, 20);
  
  if (debooger) {
    stroke(255,0,0);
    ellipse(x+10, y+10, 3, 3);
  }
  
  theta++;
 
  // gif making!
  // no contraint on frame count
//  if (radians(frameCount) <= TWO_PI) {
//    saveFrame("image-####.gif");
//  } else {
//    exit();
//  }
  
  // frame count contraint -- 120 frames , saves every third frame
  if (frameCount % 3 == 0 && radians(frameCount) <= TWO_PI) {
    saveFrame("f####.gif");
  }
}

// method for drawing visual debugging
void debug() {
  noFill();
  stroke(200);
  ellipse(width/2, height/2, 350, 350);
  
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
}

void keyPressed() {
  if (key == 'd' || key == 'D') {
    debooger = !debooger;
  }
}

