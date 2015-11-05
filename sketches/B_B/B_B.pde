int[][] result;
float time;
 
void setup() {
  setup_();
  result = new int[width*height][3];
}
 
void draw() {
  for (int i=0; i<width*height; i++)
    for (int a=0; a<3; a++)
      result[i][a] = 0;
 
  for (int sa=0; sa<samplesPerFrame; sa++) {
    time = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
    draw_();
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      result[i][0] += pixels[i] >> 16 & 0xff;
      result[i][1] += pixels[i] >> 8 & 0xff;
      result[i][2] += pixels[i] & 0xff;
    }
  }
 
  loadPixels();
  for (int i=0; i<pixels.length; i++)
    pixels[i] = 0xff << 24 | (result[i][0]/samplesPerFrame) << 16 | 
      (result[i][1]/samplesPerFrame) << 8 | (result[i][2]/samplesPerFrame);
  updatePixels();
 
  saveFrame("f###.gif");
  if (frameCount==numFrames)
    exit();
}
 
//////////////////////////////////////////////////////////////////////////////
 
int samplesPerFrame = 16;
int numFrames = 150;        
float shutterAngle = .75;
 
void setup_() {
  size(500, 500, P2D);
  smooth(8);
  noStroke();
  rectMode(CENTER);
}
 
float tt, ttt, sc;
float sp = 1.35;
float l = 180;
color c1 = color(200,30,0), c1d = color(120,20,0), c2 = color(180), c2d = color(130);
 
void draw_() {
  background(240);
  pushMatrix();
  translate(width/2, height/2);
  scale(pow(2,time));
  rotate(QUARTER_PI + HALF_PI*tt);
  
  if (time <= .5) {
    tt = 2*time;
    fill(c1);
    rect(0, 0, l, l);
    fill(255,0,0);
    for (int i=0; i<4; i++) {
      ttt = constrain(sp*tt-(sp-1)*i/3,0,1);
      ttt = 3*ttt*ttt - 2*ttt*ttt*ttt;
      sc = map(ttt,0,1,1,-1);
      if(ttt <= .5)
        fill(lerpColor(c1,c1d,2*ttt));
      else
        fill(lerpColor(c2,c2d,2-2*ttt));
      pushMatrix();
      rotate(i*HALF_PI);
      translate(0, -l/2);
      scale(1,sc);
      triangle(-l/2, 0, l/2, 0, 0, -l/2);
      popMatrix();
    }
  }
  else {
    tt = 2*time - 1;
    pushMatrix();
    rotate(QUARTER_PI);
    scale(sqrt(.5));
    fill(c2);
    rect(0, 0, l, l);
    fill(255,0,0);
    for (int i=0; i<4; i++) {
      ttt = constrain(sp*tt-(sp-1)*i/3,0,1);
      ttt = 3*ttt*ttt - 2*ttt*ttt*ttt;
      sc = map(ttt,0,1,1,-1);
      if(ttt <= .5)
        fill(lerpColor(c2,c2d,2*ttt));
      else
        fill(lerpColor(c1,c1d,2-2*ttt));
      pushMatrix();
      rotate(i*HALF_PI);
      translate(0, -l/2);
      scale(1,sc);
      triangle(-l/2, 0, l/2, 0, 0, -l/2);
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
}
