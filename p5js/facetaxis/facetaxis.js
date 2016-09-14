// jerome martinez
// facetaxis
// http://algorithmicbotany.org/papers/abop/abop-ch4.pdf

console.log('hello facetaxis!');

var capture;
var numFlorets = 3000;
var scaleFloret = 15;
var angleFloret = 137.501;

function setup() {
    // bind parent
    var canvas = createCanvas(1067, 800);
    canvas.parent("p5canvas");

    // capture video
    capture = createCapture(VIDEO);
    capture.size(1067, 800);
    capture.hide();
    
    noStroke();
    colorMode(HSB);
}

function draw() {
    clear();

    // reverse camera
    scale(-1, 1);
    image(capture, -1067, 0, 1067, 800);

    // undo reversal and translate origin
    scale(-1, 1);
    translate(width/2, height/2);

    // create phyllotaxis
    blendMode(SCREEN);
    for (var i=1; i<numFlorets; i++) {
        var radius = scaleFloret * Math.sqrt(i);
        var angle = i*angleFloret;
        var newx = radius*Math.cos(angle);
        var newy = radius*Math.sin(angle);
        fill(i/numFlorets*355, 100, 100);
        createStar(newx, newy);
    }

    // increase angle
    angleFloret+=0.00001;
}

function createStar(x, y) {
    var outerVertex = 7;
    var innerVertex = 2;
    beginShape();
    vertex(x, y-outerVertex);
    vertex(x+innerVertex, y-innerVertex);
    vertex(x+outerVertex, y);
    vertex(x+innerVertex, y+innerVertex);
    vertex(x, y+outerVertex);
    vertex(x-innerVertex, y+innerVertex);
    vertex(x-outerVertex, y);
    vertex(x-innerVertex, y-innerVertex);
    endShape(CLOSE);
}

function keyPressed() {
    if (keyCode === UP_ARROW) {
        angleFloret += 0.001;
    } else if (keyCode === DOWN_ARROW) {
        angleFloret -= 0.001;
    }
}
