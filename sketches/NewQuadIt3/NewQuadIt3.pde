//no error handling for non image files!

PImage img;
int newCanvasWidth  = MIN_WINDOW_WIDTH;  // made global to  use in draw
int newCanvasHeight = MIN_WINDOW_HEIGHT;
String path ="";
 
java.awt.Insets insets;  //"An Insets object is a representation of the borders of a container"
//from: docs.oracle.com/javase/1.4.2/docs/api/java/awt/Insets.html

float maxDeviation = 55000;
float x = 0;

File selection;

void setup()
{
  size(400, 200);
  frame.pack();     //frame.pack() ... plus insets
  insets = frame.getInsets();
  frame.setResizable(true);
  noStroke();
  
  /// for debugging, system dependent, at least screen is...
  print("MIN_WINDOW_WIDTH = " + MIN_WINDOW_WIDTH);
  print("   MIN_WINDOW_HEIGHT = " + MIN_WINDOW_HEIGHT);
  print("   screenWidth = " + displayWidth);
  println("    screenHeight = " + displayHeight);
  
  fill(0);
  textSize(24);
  text("click window to load an image", 10, 100);
  
}

void draw()
{ 
  if (img != null) {
    if (maxDeviation>100)
      maxDeviation-=400*(pow(.955,x));
//    println (maxDeviation, x);
  
    saveFrame("f####.gif");
    analyze( 0, 0, img.width, img.height, maxDeviation);
    x += 0.15;
  }
}

void keyPressed() {
  if (key == 'b' || key == 'B') {
    exit();
  }
}



void analyze( int origx, int origy, int wdt, int hgt, float maxDev)
{
  int x,y;
  float Raccum, Gaccum, Baccum;
  color pix;
  float area;
  float Ravg, Gavg, Bavg;
  color avg;  
  float dev;
  
  Raccum = Gaccum = Baccum = 0;
  area = wdt*hgt;
  for (x=origx; x<origx+wdt; x++)
  {
    for (y=origy; y<origy+hgt; y++)
    {
      pix = img.get(x,y);
      
      Raccum += red(pix);
      Gaccum += green(pix);
      Baccum += blue(pix);
    }
  }
  Ravg = Raccum/area;
  Gavg = Gaccum/area;
  Bavg = Baccum/area;
  avg = color(Ravg, Gavg, Bavg);
  
  Raccum = Gaccum = Baccum = 0;
  for (x=origx; x<origx+wdt; x++)
  {
    for (y=origy; y<origy+hgt; y++)
    {
      pix = img.get(x,y);
      
      Raccum += sq(Ravg-red(pix));
      Gaccum += sq(Gavg-green(pix));
      Baccum += sq(Bavg-blue(pix));
    }
  }
  dev = sqrt(Raccum+Baccum+Gaccum);
  
  fill(avg);
  rect(origx,origy,wdt,hgt);

  if (dev>maxDev && wdt >= 4)
  {
    analyze( origx,       origy,       wdt/2, hgt/2, maxDev-10);
    analyze( origx+wdt/2, origy,       wdt/2, hgt/2, maxDev-10);
    analyze( origx,       origy+hgt/2, wdt/2, hgt/2, maxDev-10);
    analyze( origx+wdt/2, origy+hgt/2, wdt/2, hgt/2, maxDev-10);
  }
}

 
void getImageAndResize() { 
  selectInput("select an image", "handleImage");
}
 
void handleImage(File selection) {
  if (selection == null && img == null) {
    println ("nono");
  } 
  else {
    path = selection.getAbsolutePath();
    img = loadImage(path);
 
    // a temp variable for readability 
    int widthInsets =insets.left + insets.right;
    int heightInsets =insets.top + insets.bottom;
 
    // constrain values between screen size and minimum window size
    int newFrameWidth  = constrain(img.width + widthInsets, MIN_WINDOW_WIDTH, displayWidth);
    int newFrameHeight = constrain(img.height + heightInsets, MIN_WINDOW_HEIGHT, displayHeight);
 
    // Canvas should consider insets for constraining? I think so...
    newCanvasWidth  = constrain(img.width, MIN_WINDOW_WIDTH - widthInsets, displayWidth - widthInsets);
    newCanvasHeight = constrain(img.height, MIN_WINDOW_HEIGHT - heightInsets, displayHeight - heightInsets);
 
    // set canvas size to img size WITHOUT INSETS
    // set frame size to image + Insets size
    setSizes(newCanvasWidth, newCanvasHeight, newFrameWidth, newFrameHeight);
 
    //// for debuging
    println(path);
    println(" ");
    print("imgW      = " + img.width);
    println("   imgH       = " + img.height);
    print("width+ins = " + widthInsets);
    println("      height+ins = " + heightInsets);
    print("nFrameW   = " + newFrameWidth);
    println("   nFrameH    = " + newFrameHeight);
    print("nCanvasw  = " + newCanvasWidth);
    println("   nCanvsH    = " + newCanvasHeight);
    println(" ------  ");
  }
  println(width + "  "+ height);
}
 
void setSizes (int canvasX, int canvasY, int frameX, int frameY) {
  // set canvas size to img size WITHOUT INSETS
  setSize(canvasX, canvasY);
 
  // set frame size to image + Insets size
  frame.setSize(frameX, frameY);
  println(width + "  "+ height);
}
 
void mouseClicked() {
  restart();
  getImageAndResize();
}

void restart() {
  img = null;
  newCanvasWidth  = MIN_WINDOW_WIDTH;  // made global to  use in draw
  newCanvasHeight = MIN_WINDOW_HEIGHT;
  path = "";
  maxDeviation = 55000;
  x = 0;
  frame.pack();     //frame.pack() ... plus insets
  insets = frame.getInsets();
  frame.setResizable(true);
}
