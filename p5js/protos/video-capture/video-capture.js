var capture;

function setup() {
    var canvas = createCanvas(640, 480);
    canvas.parent("p5canvas");
    capture = createCapture(VIDEO);
    capture.size(windowWidth, windowHeight);
    capture.hide();
}

function draw() {
    background(255);
    image(capture, 0, 0, 640, 480);
    filter('GRAY');
}
