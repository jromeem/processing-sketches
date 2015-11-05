boolean off = false;
float RADIUS = 66.0;
int thisX = 0;
int thisY = 0;
color[] theme = { color(217,30,46),
                  color(45,58,66),
                  color(217,230,190),
                  color(123,166,126),
                  color(242,84,48) };

void setup() {
 size(800, 600);
 background(color(123, 34, 55));
}

void drawCircle() {
  fill(theme[int(random(0, 5))]);
  ellipse(mouseX, mouseY, RADIUS, RADIUS);
}

boolean distanceCleared() {
  if (dist(thisX, thisY, mouseX, mouseY) >= RADIUS/2) {
    thisX = mouseX;
    thisY = mouseY;
    return true;
  } else {
    return false;
  }
}

void draw() {
  if (mouseX != 0 && mouseY != 0) {
    if (distanceCleared() || off) {
      drawCircle();
    } 
  } 
}

class Color {
  int R;
  int G;
  int B;  
  Color(int r, int g, int b) {
    R = r;
    G = g;
    B = b;
  }
}
