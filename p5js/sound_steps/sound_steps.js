
// intials
var grid;
var steps = [];
var padding = 15;
var maxScale = 3;
var baseSize = 72;
var canvasSize = 720;

function setup() {
    // set the canvas
    var canvas = createCanvas(canvasSize, canvasSize);
    canvas.parent("p5canvas");

    noLoop();
    noStroke();
    colorMode(RGB,255);
    // colorMode(HSB,canvasSize);

    grid = new Grid();
}

function draw() {
    // background(255);
    noStroke();

    for (var i=0; i<grid.locs.length; i++) {
        var thisLocation = grid.locs[i];

        // if the current location isn't occupied
        if (!thisLocation.occupied) {
            var randomFit = int(random(1, grid.biggestPossible(i)+1));
            var step = new SoundStep(thisLocation.x, thisLocation.y, randomFit);
            grid.blockOff(i, randomFit);
            steps.push(step);
        } else {
            continue;
        }
    }

    // debugging
    // for (var i=0; i<grid.locs.length; i++) {
    //     var thisLoc = grid.locs[i];
    //     stroke(255,100,100);
    //     if (thisLoc.occupied) {
    //         fill(255,100,100,200);
    //     } else {
    //         noFill();
    //     }
    //     rect(grid.locs[i].x,grid.locs[i].y, baseSize, baseSize);
    // }
    // end debug

    for (var i=0; i<steps.length; i++) {
        steps[i].display();
    }
    console.log("steps!!", steps.length);
    console.log("steps!!", grid);
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
    // fill(this.posx+random(-50,50),canvasSize*0.70,canvasSize+random(-50,50));
    rect(this.posx+padding, this.posy+padding, this.stepSize*baseSize-padding*2, this.stepSize*baseSize-padding*2);
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

    while (nextRightLocation.x < canvasSize-baseSize && !this.locs[constrain(index, 0, this.locs.length-maxScale)+maxScale-1].occupied) {
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
    var smallestScale = min(constrain(nextRight, 1, maxScale), constrain(nextDown, 1, maxScale));
    return smallestScale;
};
// given a size and a location, block off locations as occupied
Grid.prototype.blockOff = function(index, givenScale) {
    var yOffset = canvasSize / baseSize;
    for (var y=0; y<givenScale*yOffset; y+=yOffset) {
        for (var x=0; x<givenScale; x++) {
            this.locs[x+y+index].occupied = true;
        }
    }
};

///////////////////////////////
///////  -- Location -- ///////
///////////////////////////////
function Location(i, j) {
    this.x = i;
    this.y = j;
    this.occupied = false;
}
