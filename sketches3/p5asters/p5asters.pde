

// initial stuff ugh why
int size = 15;
int delta = 0;
float stopTime = 0;

float padding = 2.5;

float winWidth = 300;
float winHeight = 170;

boolean textShow = true;
boolean startSave = false;

color[] p5colors = {
  //color(45, 123, 182),  // blue
  //color(255, 255, 255), // white
  //color(238, 153, 0),   // brown 
  //color(237, 34, 93),   // pink

  color(0,54,67),
  color(71,108,94),
  color(255, 255, 255), // white
  color(249,89,0),
  color(148,203,74),

  //color(51,37,50),
  //color(255,151,79),
  //color(100,77,82),
  //color(255, 255, 255), // white
  //color(247,122,82),

  //color(49,53,61),
  //color(146,205,207),
  //color(68,88,120),
  //color(255, 255, 255), // white
  //color(238,239,247),

  //color(150,82,107),
  //color(235,173,96),
  //color(255, 255, 255), // white
  //color(139,171,141),
  //color(245,207,102),
 
  //color(120,74,86),
  //color(74,46,68),
  //color(255, 255, 255), // white
  //color(255,255,214),
  //color(0,36,46),
  
  //color(255,245,224),
  //color(149,209,149),
  //color(232,230,224),
  //color(255, 255, 255), // white
  //color(147,237,212),

};

ArrayList<Aster> asters = new ArrayList<Aster>();

void setup() {
  size(500, 500);
  background(175);

  Aster bigPink = new Aster(100, 150, 6, p5colors[p5colors.length-1], 0.5);
  asters.add(bigPink);

  // starting tspeed is 0.5 for bigPink
  float tspeed = 0.5;
  color randc;
  float randx, randy, randw, rands;

  for (int i = 0; i<4; i++) {
    randx = random(100, width);
    randy = random(100, height);
    randw = int(random(1, 5));
    randc = p5colors[round(random(0, p5colors.length-1))];
    randc = p5colors[i];
    rands = int(map(randw, 1, 4, 4, 1));
    println("randw: " + randw + " rands: "+ rands);
    tspeed *= rands;
    Aster randaster = new Aster(randx, randy, randw, randc, rands);
    // push a new aster
    asters.add(randaster);
  }

  PFont font = createFont("times", 56);
  textSize(140);
  textFont(font);
  
  // only have to go one fifth to repeat
  stopTime = 360/5 * 2;
  print(stopTime);
}

void draw() {
  //scale(0.4);

  background(175);

  for (int i = 0; i<asters.size(); i++) {
    asters.get(i).drawAster();
  }

  //fill(255);
  //text("THE FUTURE", width/2-200, 40);

  delta++;
  
  if (delta < stopTime) {
   saveFrame("f###.gif");
  } else {
   exit();
  }
}

// Aster class
class Aster {
  float posx;
  float posy;
  float weight;
  color col;
  float speed;

  Aster(float x, float y, float w, color c, float s) {
    this.posx = x;
    this.posy = y;
    this.weight = w;
    this.col = c;
    this.speed = s;
  }

  void drawAster() {
    noStroke();
    pushMatrix();
    translate(this.posx, this.posy);
    rotate(this.speed * radians(delta));
    for (int i = 0; i<5; i++) {
      fill(this.col);
      rotate((-2.0*PI/5.0));
      rect(0 - 23*this.weight/2.0, 0, 23*this.weight, 55*this.weight);
    }
    popMatrix();
  }
}