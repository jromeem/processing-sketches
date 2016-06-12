
Bird b;
int bird_size = 10;
float theta = 0;

ArrayList<Bird> bb;

void setup() {
  size(500, 500, P2D);
  background(255);
  b = new Bird(250, 250, 45);
  bb = new ArrayList<Bird>();
  
  for (int i=0; i<500+2*bird_size; i+=2*bird_size) {
    for (int j=0; j<500+2*bird_size; j+=2*bird_size) {
      Bird b = new Bird(j%500, i, 0);
      bb.add(b);
    } 
  }
  
}

void draw() {
  background(255);
  
  for (Bird b : bb) {
    b.display(); 
  }
  theta += 1;
}

float findAngle(float x1, float y1, float x2, float y2) {
  float h = dist(x1, y1, x2, y2);
  float a = abs(y2 - y1);
  float angle = acos(a/h);
  if ((x1 < x2 && y1 < y2) || (x2 < x1 && y2 < y1)) {
    angle = -angle;
  }
  return angle+PI/2;
}


class Bird {
  float speed;
  float angle;
  PVector pos = new PVector();      // a vector (x, y)
  PVector center = new PVector();   // center of the bird~
  
  Bird (float xpos, float ypos, float angle) {
    this.angle = angle;
    this.pos.x = xpos;
    this.pos.y = ypos;
  }
  
  // draw the birds~~
  void display() {
    
    float angle = findAngle(this.pos.x, this.pos.y, mouseX, mouseY);
    
    
    pushMatrix();
    pushStyle();
      translate(this.pos.x, this.pos.y);
      
      noFill();
      ellipseMode(CENTER);
      //stroke(200);
      //ellipse(0, 0, 2*bird_size, 2*bird_size);
      
      strokeWeight(1);
      stroke(255,0,0);
      
      float headx = bird_size*cos(angle);
      float heady = bird_size*sin(angle);
      
      float tailx = bird_size*cos(angle+PI);
      float taily = bird_size*sin(angle+PI);
      
      line(headx, heady, tailx, taily);
    popStyle();
    popMatrix();
  }
}