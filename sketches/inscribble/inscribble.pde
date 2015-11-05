// Jerome Martinez
// single-word timing to sync with video/audio files
// what will you caption today?

import processing.video.*;

Movie french;

void setup() {
  // setup some stuff
  println("wow lets do something");
  
  size(800, 460);
  background(255);
  
  french = new Movie(this, "bad_french.mov");
  french.loop();
}

void movieEvent(Movie m) {
  m.read(); 
}

void draw() {
  // draw some stuff
  image(french, 0, 0, 640, 360);
}
