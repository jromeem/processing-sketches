
PImage img = createImage(66, 66, ARGB);
PImage background = createImage(60, 60, ARGB);

void setup() {
  size(200, 200);
  background(255);
  noLoop();
}

void draw() {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(0, 90, 102, i % img.width * 2); 
  }
  img.updatePixels();
  image(img, 17, 17);
  image(img, 34, 34);
}



//void setup() {
//  size(200, 200);
//  background(255);
//  noLoop();
//}

//void draw() {
  
//}