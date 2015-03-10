int thisX = 0;
int thisY = 0;
int amount = 18;
Pointy[] points = new Pointy[amount];

void setup () {
  size(300,300);
  background(0);

  // make some pointies
  for (int i=0; i<amount; i++) {
   points[i] = new Pointy(); 
  }
}

void draw () {
  stroke(255);
  for (int i=0; i<points.length; i++) {
    points[i].display();
  }
}

class Pointy {
 float x;
 float y;
 float speed;
 Pointy() {
   x = random(100, 200);
   y = random(100, 200);
   speed = 7;
 }
 void display() {
   float new_x = x + random(-1*speed, speed);
   float new_y = y + random(-1*speed, speed);
   point(x, y, new_x, new_y);
   x = new_x; y = new_y;
 }
}
