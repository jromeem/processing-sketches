
int cellwidth = 20;
int cellSpace = 30; 
int cellHeight = 30;
void setup() {
  size(600, 600);
  colorMode(HSB, 100);
  noStroke();
  
  for (int i = 0; i < 10; i++) {
    fill(i*5, 30, 100);
    rect(width/2 - cellwidth/2, i*cellSpace + (height/2 - cellSpace*5), cellwidth, cellHeight);
  }

}