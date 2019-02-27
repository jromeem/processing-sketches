int randomDistance;
int originX = 250;
int originY = 250;

void setup()
{
  size(500, 500);
  background(255, 150, 150);
  noStroke();
}

void draw()
{
  radiatingPoint();
  
  int a = int(random(360));
  int randomDistance = int(random(150));
  int x = int(originX + randomDistance * cos(a));
  int y = int(originY + randomDistance * sin(a));
  
  noStroke();
  fill(random(255));
  rect(x, y, 10, 10);
}

void radiatingPoint() {
  fill(255, 0, 0);
  ellipse(originX, originY, 10, 10);
}