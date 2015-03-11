int OPT = 1;
boolean debug = false;

void setup() {
   size(500, 500);
   background(255);
}

void draw() {
   
   if (debug) {
     rect(40, 40, 420, 420); 
     
     line(140+40, 0, 140+40, 500);
     line(140+140+40, 0, 140+140+40, 500);
     
     line(0, 140+40, 500, 140+40);
     line(0, 140+140+40, 500, 140+140+40);
   }
   
   translate(40, 40);
   for (int i=0; i<3; i++) {
     for(int j=0; j<3; j++) {
       pushMatrix();
       translate(140*j, 140*i);
       //rect(20, 20, 100, 100);
       if (debug)
         ellipse(70, 70, 140, 140);
       rect((140-70*sqrt(2))/2,(140-70*sqrt(2))/2, 70*sqrt(2), 70*sqrt(2));
       popMatrix();
     } 
   }
 
   
}
