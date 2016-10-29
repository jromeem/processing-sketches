// generative sound steps

int areaToFill;
int totalArea = 576;
int[] stepSizes = {12, 10, 8, 6, 4, 2, 1};
ArrayList<StepSquare> steps;
int stepPadding = 4;

void setup() {
  size(576, 576);
  background(255);
  
  // initialize~
  areaToFill = totalArea;
  steps = new ArrayList<StepSquare>();
  
  // add one to the list!
  int randInd = int(random(stepSizes.length));
  int randSize = stepSizes[randInd] * 24;
  StepSquare firstStep = new StepSquare(randSize);
  steps.add(firstStep);
}

void draw() {
  int randInd = int(random(stepSizes.length));
  //int randInd = 6;
  int randSize = stepSizes[randInd] * 24;
  
  StepSquare newStep = new StepSquare(randSize);
  
  // check all the squares for collision
  for (int i=0; i<steps.size(); i++) {
    StepSquare thisStep = steps.get(i);
    
    if (newStep.posx < thisStep.posx + thisStep.size &&
        newStep.posx + newStep.size > thisStep.posx &&
        newStep.posy < thisStep.posy + thisStep.size &&
        newStep.size + newStep.posy > thisStep.posy) {
        // collision detected!
        // do nothing
    } else {
      // add it to the list if no collision!
      steps.add(newStep);
    }
  }
  
  // draw all the squares
  for (int i=0; i<steps.size(); i++) {
    steps.get(i).display();
  }
  
}

class StepSquare {
  int size;
  int posx;
  int posy;
  
  StepSquare(int s) {
    this.size = s;
    this.posx = int(random(1, 24)) * 23;
    this.posy = int(random(1, 24)) * 23;
  }
  
  // chose a random place to put the square
  void display() {
    println("randomx " + this.posx + " randomy" + this.posy);
    //rect(this.posx, this.posy, this.size, this.size);
    fill(0);
    noStroke();
    rect(this.posx+stepPadding,
         this.posy+stepPadding,
         this.size-stepPadding*2,
         this.size-stepPadding*2);
  }
}