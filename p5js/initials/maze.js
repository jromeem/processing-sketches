/////////////////////////////////
///////////// QUARE /////////////
/////////////////////////////////

function Quare(x, y, s, i) {
    // initial attributes
    this.posx = x;
    this.posy = y;
    this.size = s;
    this.ident = i;
    this.seen = false;
};

Quare.prototype.display = function() {
    rect(this.posx, this.posy, this.size, this.size);
};

Quare.prototype.setNeighbors = function(t, r, b, l) {
    this.top = t;
    this.bottom = b;
    this.left = l;
    this.right = r;

    this.direction = {
        0: this.top,
        1: this.right,
        2: this.bottom,
        3: this.left
    };
};

Quare.prototype.highlightNeighbors = function() {
    if (this.top) { this.top.display(); };
    if (this.bottom) { this.bottom.display(); };
    if (this.left) { this.left.display(); };
    if (this.right) { this.right.display(); };
};

// 0 - top; 1 - right; 2 - bottom; 3 - left
Quare.prototype.chooseNeighbor = function() {
    var randmove;
    var neighbor = null;
    
    // **interactive**
    var distro = [0,1,2,3];

    while (neighbor == null) {
        randmove = distro[_.random(distro.length-1)];
        if (this.direction[randmove]) {
            if (!this.direction[randmove].seen) {
                neighbor = this.direction[randmove];
            };
        };
    };

    return neighbor;
};

Quare.prototype.allVisited = function() {
    var all = true;
    if (this.top != null) { all = all && this.top.seen; };
    if (this.right != null) { all = all && this.right.seen; };
    if (this.left != null) { all = all && this.left.seen; };
    if (this.bottom != null) { all = all && this.bottom.seen; };
    return all;
};

Quare.prototype.connectNeighbor = function(neigh) {
    dx = int((neigh.posx - this.posx) / Math.abs(neigh.posx-this.posx));
    dy = int((neigh.posy - this.posy) / Math.abs(neigh.posy-this.posy));

    rect(dx < 0  ? dx*2*this.size+this.posx: this.posx,
         dy < 0  ? dy*2*this.size+this.posy : this.posy,
         dy == 0 ? this.size*3 : this.size,
         dx == 0 ? this.size*3 : this.size);

    fill(theme.head);
    rect(neigh.posx+2, neigh.posy+2, this.size-4, this.size-4);
};

// like a good neighbor statefarm is there
Quare.prototype.visit = function(neighbor) {
    this.seen = true;
    neighbor.seen = true;
    this.connectNeighbor(neighbor);
    return neighbor;
};

////////////////////////////////
///////////// QRID /////////////
////////////////////////////////

// Qrid class
function Qrid(s) {
    this.size = s;  // side length i.e. quare x quare length
    this.qrid = []; // list of quares
    this.initializeQuares();
    this.makeNeighbors();
};

Qrid.prototype.initializeQuares = function() {
    var dim;
    var offset;
    var k = 0;
    // new quares into our grid
    for (var i=0; i<2*this.size; i+=2) {
        for (var j=0; j<2*this.size; j+=2) {
            dim = SIZE / (this.size * 2.0);
            offset = 0.5 * dim;
            this.qrid[k] = new Quare((j*dim)+offset, (i*dim)+offset, dim, k);
            k++;
        };
    };
};

// display debugging :)
Qrid.prototype.displayQrid = function() {
    for (var i=0; i<this.size+1; i++) {
        line(i*SIZE/this.size, 0, i*SIZE/this.size, SIZE);
    };
    for (var j=0; j<this.size+1; j++) {
        line(0, j*SIZE/this.size, SIZE, j*SIZE/this.size);
    };
};

// display debugging :D
Qrid.prototype.displayQuares = function() {
    for (var i = this.qrid.length - 1; i >= 0; i--) {
        this.qrid[i].display();
    };
};

// picks a rando cell
Qrid.prototype.highlightRandom = function() {
    var randpos = _.random(this.qrid.length - 1);
    this.qrid[randpos].display();
    return this.qrid[randpos];
};

// connect cells with their neighbors :)
Qrid.prototype.makeNeighbors = function() {
    for (var k=0; k<this.qrid.length; k++) {
        var top    = (k-this.size < 0) ? null : this.qrid[k-this.size];
        var right  = (k%this.size == this.size-1) ? null : this.qrid[k+1];
        var bottom = (k+this.size > this.qrid.length-1) ? null : this.qrid[k+this.size];
        var left   = (k%this.size == 0) ? null : this.qrid[k-1];
        this.qrid[k].setNeighbors(top, right, bottom, left);
    };
};

/////////////////////////////////
///////////// THEME /////////////
/////////////////////////////////

function Theme() {
    this.name;
    this.background;
    this.snake;
    this.psnake;
    this.head;
    this.themes = {
        0:this.Minuet,
        1:this.Bolero,
        2:this.Serenade,
        3:this.Requiem,
        4:this.Nocturne,
        5:this.Prelude
    }
    this.size = 6;
};

Theme.prototype.Minuet = function() {
    this.name = 'minuet';
    this.background = color(0,54,67);
    this.snake = color(148,203,74);
    this.psnake = color(71,108,94);
    this.head = color(249,89,0);
};

Theme.prototype.Bolero = function() {
    this.name = 'bolero';
    this.background = color(51,37,50);
    this.snake = color(255,151,79);
    this.psnake = color(100,77,82);
    this.head = color(247,122,82);
};

Theme.prototype.Serenade = function() {
    this.name = 'serenade';
    this.background = color(49,53,61);
    this.snake = color(146,205,207);
    this.psnake = color(68,88,120);
    this.head = color(238,239,247);
};

Theme.prototype.Requiem = function() {
    this.name = 'requiem';
    this.background = color(245,207,102);
    this.snake = color(150,82,107);
    this.psnake = color(235,173,96);
    this.head = color(139,171,141);
};

Theme.prototype.Nocturne = function() {
    this.name = 'nocturne';
    this.background = color(0,36,46);
    this.snake = color(120,74,86);
    this.psnake = color(74,46,68);
    this.head = color(255,255,214);
};

Theme.prototype.Prelude = function() {
    this.name = 'prelude';
    this.background = color(255,245,224);
    this.snake = color(149,209,149);
    this.psnake = color(232,230,224);
    this.head = color(147,237,212);
};

Theme.prototype.randomTheme = function() {
    var rand = _.random(this.size-1);
    switch (rand) {
        case 0: this.Minuet(); break;
        case 1: this.Bolero(); break;
        case 2: this.Serenade(); break;
        case 3: this.Requiem(); break;
        case 4: this.Nocturne(); break;
        case 5: this.Prelude(); break;
        default: break;
    }
};

/////////////////////////////////
///////////// HELLO /////////////
/////////////////////////////////

// globals should be interactives
var SIZE = 500; // size of canvas in pixels
var QSIZE = 10; // 50 x 50 square matrix
var UIWIDTH = 200;

var q = new Qrid(QSIZE);
var theme = new Theme();

var stack;
var current;
var next;

//// UISTUFF ////
var uidiv;
// change size, directional biases
var sizeSlider,
    upButton, downButton, leftButton, rightButton;
// theme buttons 
var minuetButton, boleroButton, serenadeButton,
    requiemButton, nocturneButton, preludeButton;
/////////////////

function setup() {
    var canvas = createCanvas(SIZE, SIZE);
    canvas.parent("p5canvas");

    //  ** ui setup **
    uiSetup();

    noStroke();
    theme.Bolero();
    background(theme.background);

    // masks artifact from highlightRandom()
    fill(theme.background);
    stack = [q.highlightRandom()];
    frameRate(300);

    // help me with the border
    scale(0.98);
    translate(5,5);
};

function draw() {
    current = stack[stack.length-1];
    // if all neightbors have been visited
    if (current.allVisited()) {
        fill(theme.snake); // snake

        // pop off the stack
        if (stack.length > 1) {
            current.connectNeighbor(stack[stack.length-2]);
            stack.pop();

        // ending
        } else {
            fill(theme.snake);
            var dim = SIZE/(QSIZE*2.0);
            var offset = 0.5*dim;
            current.display();
            rect(0 - 10, offset, SIZE/QSIZE/2.0 + 10, SIZE/QSIZE/2.0);
            rect(SIZE-offset, SIZE-3.0*offset, SIZE/QSIZE/4.0 + 50, SIZE/QSIZE/2.0);
            noLoop();
        };
        
    // otherwise
    } else {
        // add to the stack
        next = current.chooseNeighbor();
        fill(theme.psnake); // psnake
        current.visit(next);
        stack.push(next);
    };
};

function uiSetup() {
    uidiv = createDiv('');
    uidiv.parent("p5canvas")
        .id('ui')
        .style('height', '100%')
        .style('width', '20%')
        .style('float', 'right')
        .style('display', 'block');

    sizeSlider = createSlider(5, 50, 10)
    sizeSlider.parent('size-slider')
        .style('width', '225px')
        .mouseReleased(reloadSize);

    // wow make this dynamic later
    minuetButton = select('#minuet')
        .style('color', '#003643')
        .style('background-color', '#94CB4A')
        .mousePressed(loadMinuet);

    boleroButton = select('#bolero')
        .style('color', '#332532')
        .style('background-color', '#FF974F')
        .mousePressed(loadBolero);

    serenadeButton = select('#serenade')
        .style('color', '#31353D')
        .style('background-color', '#92CDCF')
        .mousePressed(loadSerenade);

    nocturneButton = select('#nocturne')
        .style('color', '#CFCFCF')
        .style('background-color', '#784A56')
        .mousePressed(loadNocturne);

    requiemButton = select('#requiem')
        .style('color', '#96526B')
        .style('background-color', '#F5CF66')
        .mousePressed(loadRequiem);

    preludeButton = select('#prelude')
        .style('color', '#84C084')
        .style('background-color', '#E8E6E0')
        .mousePressed(loadPrelude);
}

function resetMaze() {
    q = new Qrid(QSIZE);

    current = null;
    next = null;
    stack = [q.highlightRandom()];

    background(theme.background);
    loop();
    redraw();
}

function reloadSize() {
    QSIZE = sizeSlider.value();
    resetMaze();
}

function loadMinuet() {
    theme.Minuet();
    resetMaze();
}

function loadBolero() {
    theme.Bolero();
    resetMaze();
}

function loadSerenade() {
    theme.Serenade();
    resetMaze();
}

function loadNocturne() {
    theme.Nocturne();
    resetMaze();
}

function loadRequiem() {
    theme.Requiem();
    resetMaze();
}

function loadPrelude() {
    theme.Prelude();
    resetMaze();
}