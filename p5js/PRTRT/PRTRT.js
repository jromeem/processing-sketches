console.log('hello P!');

var colorWheel = 0.0;

function setup() {
    var canvas = createCanvas(windowWidth, windowHeight);
    canvas.parent("p5canvas");
}

function draw() {
    background(0,0,0,0.3);
    
    noStroke();
    colorMode(HSB);
    fill(colorWheel, 100, 100, 0.05);
    ellipse(mouseX, mouseY, 300, 300);
    
    fill(colorWheel, 100, 100, 0.1);
    ellipse(mouseX, mouseY, 250, 250);


    colorMode(HSB);
    strokeWeight(200);
    stroke(colorWheel, 200, 200);
    line(pmouseX, pmouseY, mouseX, mouseY);
    line(ptouchX, ptouchY, touchX, touchY);

    colorWheel+= 0.5;
    colorWheel = colorWheel % 355;
}
