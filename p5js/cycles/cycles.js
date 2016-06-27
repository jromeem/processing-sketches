////////////////////////////////
///////////// Movi /////////////
////////////////////////////////

function Movi(x, y, o) {
    this.v = createVector(x, y);
    this.offset = o;
    this.size = 3;
}

Movi.prototype.display = function() {
    noStroke();
    fill(theme.cyc);
    ellipse(this.v.x, this.v.y, this.size, this.size);
};

///////////////////////////////
///////////// CYC /////////////
///////////////////////////////

function Cyc(x, y, s) {
    this.v = createVector(x, y);
    this.size = s;
    this.radius = this.size/2.0;

    var rand = _.random(1);
    this.direction = rand == 1 ? 1 : -1;
    this.velocity = 1 * this.direction;

    var rangle = _.random(0, TWO_PI);
    var mmx = this.v.x + this.radius * cos(rangle);
    var mmy = this.v.y + this.radius * sin(rangle);
    this.mm = new Movi(mmx, mmy, rangle);
}

Cyc.prototype.display = function() {
    // noFill();
    // stroke(100);
    // ellipse(this.v.x, this.v.y, this.size, this.size);
    this.mm.v.set(this.v.x + this.radius * cos(this.velocity * (this.mm.offset * cycle)),
                  this.v.y + this.radius * sin(this.velocity * (this.mm.offset * cycle)));
    this.mm.display();
};

/////////////////////////////////
///////////// HELLO /////////////
/////////////////////////////////

var CYCS = 20;
var THRESH = 60;

var theme;
var cycle = 0;
var cycs = [];

function resetCyc() {
    cycs = [];
    for (var i = 0; i < CYCS; i++) {
        cycs[i] = new Cyc(_.random(100,400),_.random(100,400),_.random(40,150));
    };
    loop();
    redraw();
}

function setup() {
    var canvas = createCanvas(500, 500);
    canvas.parent("p5canvas");

    // blendMode(LIGHTEST);
    loadIdeal();

    /* UI SETUP */
    uiSetup();
    resetCyc();
}

function draw() {
    background(theme.bg);
    for (var i = cycs.length - 1; i >= 0; i--) {
        cycs[i].display();

        for (var j = cycs.length - 1; j >= 0; j--) {
            var dist = cycs[i].mm.v.dist(cycs[j].mm.v);
            if (dist < THRESH) {
                // stroke(map(dist,0,THRESH,red(theme.cyc),red(theme.bg)),
                //        map(dist,0,THRESH,green(theme.cyc),green(theme.bg)),
                //        map(dist,0,THRESH,blue(theme.cyc),blue(theme.bg)));
                stroke(theme.cyc);
                line(cycs[i].mm.v.x, cycs[i].mm.v.y, cycs[j].mm.v.x, cycs[j].mm.v.y);
            }
        };
    };
    cycle += 0.01;
}

//////////////////////////////
///////////// UI /////////////
//////////////////////////////

var numSlider, threshSlider;
var crazeButton, tepidButton,
    idealButton, awakeButton;

function uiSetup() {
    uidiv = createDiv('');
    uidiv.parent("p5canvas")
        .id('ui')
        // interfers with existing css
        // .style('height', '100%')
        // .style('width', '20%')
        // .style('float', 'right')
        // .style('display', 'block');

    numSlider = createSlider(10, 60, 20)
    numSlider.parent('num-slider')
        .style('width', '225px')
        .mouseReleased(reloadAmount);

    threshSlider = createSlider(40, 150, 62)
    threshSlider.parent('thresh-slider')
        .style('width', '225px')
        .mouseReleased(reloadThresh);

    // wow make this dynamic later
    // crazeButton = getElement('craze')
    //     .style('color', '#003643')
    //     .style('background-color', '#94CB4A')
    //     .mousePressed(loadCraze);

    // tepidButton = getElement('tepid')
    //     .style('color', '#332532')
    //     .style('background-color', '#FF974F')
    //     .mousePressed(loadTepid);

    // idealButton = getElement('ideal')
    //     .style('color', '#31353D')
    //     .style('background-color', '#92CDCF')
    //     .mousePressed(loadIdeal);

    // awakeButton = getElement('awake')
    //     .style('color', '#CFCFCF')
    //     .style('background-color', '#784A56')
    //     .mousePressed(loadAwake);
};

function reloadAmount() {
    CYCS = numSlider.value();
    resetCyc();
};
function reloadThresh() {
    THRESH = threshSlider.value();
    resetCyc();
};

function loadCraze() {
    theme = { bg: color(30,20,20),
              cyc: color(250,80,80) };
};
function loadTepid() {
    theme = { bg: color(20,20,20),
              cyc: color(100,100,200) };
};
function loadIdeal() {
    theme = { bg: color(44,46,42),
              cyc: color(40,200,52) };
};
function loadAwake() {
    theme = { bg: color(30,30,30),
              cyc: color(240,240,240) };
};

