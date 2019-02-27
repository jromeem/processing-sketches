import processing.video.*;

Capture cam;
Capture cam2;

void setup() {
  size(960, 540);
  cam = new Capture(this, 1920, 1080, "HD Pro Webcam C920", 30);
  cam.start();

  cam2 = new Capture(this, 1920, 1080, "HD Pro Webcam C920 #2", 30);
  cam2.start();
}

void draw() {
  if (cam.available() == true && cam2.available() == true) {
    cam.read();
    cam2.read();

  }
  image(cam, 0, 0, 480, 270);
  image(cam2, 480, 270, 480, 270);
}
