// jerome martinez
// this draws a mountain range
// using basic perlin noises
// with some basic features like peaks and valleys

class MountainRange {
  
  // altitudinal variation:
  // closer to zero == less jagged -- more hills
  // further from zero == more jagged -- more mountains
  float variation;
  
  // points on the grid that specify significant landmarks
  // i.e. valleys and peaks
  float[] landmarks;
  
  // averaging all landmarks signifies average height
  float avgHeight;
  
  // the mountian color
  color mountainColor;
  
  // mountain constructor
  MountainRange(float v, float[] lm, color c) {
    variation = v;
    mountainColor = c;
    landmarks = lm;
    
    // calculate average height
    float total = 0;
    for (int i=0; i<lm.length; i++) {
      total += lm[i];
    }
    avgHeight = total/lm.length;
  }
  
  
  // main display fuction
  void terraform() {
    for (int x=0; x < width; x++) {
      float noiseVal = noise((mouseX+x)*variation, avgHeight*variation);
      stroke(mountainColor);
      strokeWeight(5);
      line(x, avgHeight+noiseVal*80, x, height);
    }
    
    //for (int x=0; x < width; x++) {
    //  float noiseVal = noise((mouseX+x)*variation, mouseY*variation);
    //  stroke(variation*255);
    //  line(x, mouseY+noiseVal*80, x, height);
    //}
  }
  
}