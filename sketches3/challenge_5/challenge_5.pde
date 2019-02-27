// Jerome Martinez
// Challenge 5: Algorithms

// create a list of scenes
int NUM_SCENES = 15;
Scene[] SCENES_LIST = new Scene[NUM_SCENES]; 

// create a list of characters
int NUM_ACTORS = 4;
Actor[] ACTOR_LIST = new Actor[NUM_ACTORS];

int SCENE_COUNTER = 0;


void setup() {
  size(800, 800);
  
  // initalize the SCENE_LIST array
  for (int s = 0; s < NUM_SCENES; s++) {
    // create a white background for the title scene
    if (s == 0) {
      SCENES_LIST[s] = new Scene(color(255)); 
    }
    // create a black background for the finishing scene
    else if (s == NUM_SCENES-1) {
      SCENES_LIST[s] = new Scene(color(0)); 
    }
    // create a new scene for the rest
    else {
      SCENES_LIST[s] = new Scene();
    }
  }
  
  // initalize the ACTOR_LIST array
  for (int a = 0; a < NUM_ACTORS; a++)  {
    if (a == 0) {
      ACTOR_LIST[a] = new Actor(color(255, 0, 0), 200);
    } else {
      ACTOR_LIST[a] = new Actor(); 
    }
  }
}

void draw() {
  // get the current scene
  Scene currentScene = SCENES_LIST[SCENE_COUNTER];
  // display the current scene
  currentScene.displayScene();
  
  // display all the actors
  for (int a = 0; a < NUM_ACTORS; a++) {
    Actor thisActor = ACTOR_LIST[a];
    thisActor.displayActor();
  }
}

// increase the SCENE_COUNTER by pressing the space bar
void keyPressed() {
  if (key == ' ') {
    SCENE_COUNTER++;
    if (SCENE_COUNTER > NUM_SCENES-1) {
      exit(); 
    }
  }
}

// this class represents on section of the story
class Scene {
  color backgroundColor;
  
  Scene () {
    int randomR = int(random(100, 150));
    int randomG = int(random(100, 150));
    int randomB = int(random(100, 150));
    this.backgroundColor = color(randomR, randomG, randomB);
  }

  Scene (color bgColor) {
    this.backgroundColor = bgColor;
  }
  
  void displayScene() {
     background(this.backgroundColor);
  }
}

class Actor {
  color fillColor;
  int actorSize;
  
  Actor () {
    int randomR = int(random(150, 200));
    int randomG = int(random(150, 200));
    int randomB = int(random(150, 200));
    this.fillColor = color(randomR, randomG, randomB);
    this.actorSize = int(random(50, 70));
  }
  
  Actor(color fColor, int aSize) {
    this.fillColor = fColor;
    this.actorSize = aSize;
  }
  
  void displayActor() {
    fill(this.fillColor);
    int randomX = int(random(this.actorSize, width-this.actorSize));
    int randomY = int(random(this.actorSize, height-this.actorSize));
    ellipse(randomX, randomY, this.actorSize, this.actorSize);
  }
  
}