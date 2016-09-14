// jerome martinez
// let's make mountains
// happy birthday #nps!!

//ArrayList<MountainRange> mrs;
int numMountains = 12;
MountainRange[] mrs = new MountainRange[numMountains];

void setup() {
  size(500, 500, P2D);
  //fullScreen(P2D);
  pixelDensity(2);
  
  mrs = new MountainRange[numMountains];
  for (int i=0; i<numMountains; i++) {
    float[] landmarks = new float[3];
    for (int j=0; j<landmarks.length; j++) {
      landmarks[j] = random(10*i*2, 10*i*2+200) + (height/4); 
    }
    color purp = color(215-i*18, 160-i*18, 200-i*18);
    MountainRange mr = new MountainRange(0.012-i*0.0008, landmarks, purp);
    mrs[i] = mr;
  }
  
  noLoop();
}


void draw() {
  background(255, 220, 240);
  for (int i=0; i<mrs.length; i++) {
    MountainRange mr = mrs[i];
    mr.terraform();
  }
  
  saveFrame("nps-####.png");
  exit();
}

void makeNoisey() {
  // make the noisey background using PImage
  // and perlin noise = noise detail
  // see noisey sketch for details~s
}

//void keyPressed() {
//  if (key == ' ') {
//    saveFrame("nps_#####.png");
//    exit();
//  }
//}