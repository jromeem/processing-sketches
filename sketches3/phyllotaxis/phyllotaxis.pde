// Jerome Martinez
// Phyllotaxis
// http://algorithmicbotany.org/papers/abop/abop-ch4.pdf

int numFlorets = 500;
int scaleFloret = 15;
float angleFloret = 137.501;
int hsbRange = 100;

void setup() {
  size(500, 500);
  
  noStroke();
  colorMode(HSB,hsbRange);
}

void draw() {
  background(0,0,hsbRange/3);
  translate(width/2, height/2);
  
  for (int i=0; i<numFlorets; i++) {
    float radius = scaleFloret * sqrt(i);
    float angle = i*angleFloret;
    
    float posx = radius*cos(angle);
    float posy = radius*sin(angle);
    
    float colorVal = map(i, 0, numFlorets, 0, hsbRange);
    fill(colorVal,hsbRange,hsbRange);
    createStar(posx, posy); 
  }
  angleFloret+=0.00001;
}

void createStar(float x, float y) {
  int outerVertex = 7;
  int innerVertex = 2;
  beginShape();
  vertex(x, y-outerVertex);
  vertex(x+innerVertex, y-innerVertex);
  vertex(x+outerVertex, y);
  vertex(x+innerVertex, y+innerVertex);
  vertex(x, y+outerVertex);
  vertex(x-innerVertex, y+innerVertex);
  vertex(x-outerVertex, y);
  vertex(x-innerVertex, y-innerVertex);
  endShape(CLOSE);
}