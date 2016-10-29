
// intials
var grid;
var padding = 5;
var baseSize = 48;
var canvasSize = 576;
var scaleMultiplier = [1,1,1,1,
                       2,2,2,3,
                       3,4];
var steps = [];

function setup() {
    // set the canvas
    var canvas = createCanvas(canvasSize, canvasSize);
    canvas.parent("p5canvas");

    noLoop();
    noStroke();
    colorMode(RGB,255);

    grid = new Grid();
}

function draw() {
    background(255);
    for (var i=0; i<grid.locs.length; i++) {
        var thisLocation = grid.locs[i];
        var biggestSize = grid.biggestPossible(i);

        // if the current location isn't occupied
        // if (!thisLocation.occupied) {
        //     var biggestSize = grid.biggestPossible(i);
        //     console.log("the biggest so far", biggestSize);
        //     var step = new SoundStep(thisLocation.x, thisLocation.y, biggestSize);
        //     steps.push(step);
        // } else {
        //     continue;
        // }
    }
}

////////////////////////////////
///////  -- SoundStep -- ///////
////////////////////////////////
function SoundStep(x, y, s) {
    this.posx = x;
    this.posy = y;
    this.stepSize = s;
}
SoundStep.prototype.display = function() {
    fill(random(255),70,100);
    rect(this.posx+padding, this.posy+padding, this.stepSize-padding*2, this.stepSize-padding*2);
};


///////////////////////////
///////  -- Grid -- ///////
///////////////////////////
function Grid() {
    this.locs = [];
    var ind = 0;
    for (var i=0; i<canvasSize; i+=baseSize) {
        for (var j=0; j<canvasSize; j+=baseSize) {
            var loc = new Location(j, i);
            this.locs[ind++] = loc;
        }
    }
}
// set the occupational status of the given cell
Grid.prototype.setOccupation = function(i, o) {
    var thisLocation = this.locs[i];
    thisLocation.occupied = o;
};
// return the biggest possible square that can be made at this location
Grid.prototype.biggestPossible = function(index) {
    // if this location is occupied then return a 0 scale;
    var thisLocation = this.locs[index];
    if (thisLocation.occupied) {
        return 0;
    }
    // check to your right
    var nextRight = 1;
    var nextRightLocation = this.locs[index];
    while (nextRightLocation.x < canvasSize-baseSize && !nextRightLocation.occupied) {
        nextRightLocation = this.locs[nextRight+index];
        nextRight++; // every column
    }

    // check below you
    var nextDown = 1;
    var nextDownLocation = this.locs[index];
    var yOffset = canvasSize / baseSize;
    while (nextDownLocation.y < canvasSize-baseSize && !nextDownLocation.occupied) {
        nextDownLocation = this.locs[nextDown*yOffset+index];
        nextDown++; // every next row
    }

    // return the smallest scale out of the two with each constrained to 3 as the max scale
    var smallestScale = min(constrain(nextRight, 1, 3), constrain(nextDown, 1, 3));
    return smallestScale;
};

///////////////////////////////
///////  -- Location -- ///////
///////////////////////////////
function Location(i, j) {
    this.x = i;
    this.y = j;
    this.occupied = false;
}
