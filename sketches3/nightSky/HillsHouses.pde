class HillsHouses {
  
  int num;
  float speed;
  
  Hill[] hills;
  House[] houses;
  
  HillsHouses(float s, int n) {
    this.speed = s;
    this.num = n;
    hills = new Hill[n];
    houses = new House[n];
    
    for (int i = 0; i < this.num; i++) {
      this.hills[i] = new Hill(random(0, width), 100, -1.5); 
    }
  }
  
  void display() {
    for (int i = 0; i < this.num; i++) {
      this.hills[i].display();
    }
  }
}

class Hill {
  float x;
  float y;
  float s;
  color c;
  float hillWidth = 80;
  
  Hill(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.c = color(random(0, 50), 100, random(0, 50));
  }
  
  void display() {
    fill(this.c);
    rect(this.x, this.y, this.hillWidth, height);
    ellipse(this.x+40, this.y, hillWidth, this.hillWidth);
    
    // create movement
    this.x += this.s;
    if (this.x < -this.hillWidth) {
      this.x = random(width, 2*width); 
    }
  }
}

class House {
  float x;
  float y;
  float s;
  
  House(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
  }
  
  void display() {
    
  }
}