HillsHouses hh;

void setup() {
  hh = new HillsHouses(-1.5, 5);
  
  size(800, 800);
  noStroke();
}

void draw() {
  background(0);
  hh.display();
}