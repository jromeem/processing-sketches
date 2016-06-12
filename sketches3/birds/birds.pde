
int flock_size = 20;
int bird_size = 20;
ArrayList<Bird> flock;

void setup() {
  size(500,500,P2D);
  background(255);
  flock = new ArrayList<Bird>(flock_size);
  
  // initialize your flock ~
  for (int i=0; i<flock_size; i++) {
    Bird bird = new Bird(i*10, i*10, i*10);
    flock.add(bird);
  }
}

void draw() {
  for (Bird b : flock) {
    b.display(); 
  }
}

class Bird {
  float speed;
  float angle;
  PVector pos = new PVector();      // a vector (x, y)
  PVector center = new PVector();   // center of the bird~
  
  Bird (float angle, float xpos, float ypos) {
    this.angle = angle;
    this.pos.x = xpos;
    this.pos.y = ypos;
  }
  
  // draw the birds~~
  void display() {
    pushMatrix();
      translate(this.pos.x, this.pos.y);
      
      float headx = this.pos.x + bird_size*cos(radians(angle));
      float heady = this.pos.y + bird_size*sin(radians(angle));
      
      float tailx = this.pos.x + bird_size*cos(radians(angle+180));
      float taily = this.pos.y + bird_size*sin(radians(angle+180));
      
      line(headx, heady, tailx, taily);
    popMatrix();
  }
}