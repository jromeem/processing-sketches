
// intials
var grid;
var padding = 5;
var baseSize = 48;
var canvasSize = 576;
var scaleMultiplier = [1,1,1,1,
                       2,2,2,3,
                       3,4];
var steps = [];
var stepCount = 0;

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
    // background(255);
    noStroke();

    for (var i=0; i<grid.locs.length; i++) {
        var thisLocation = grid.locs[i];

        // if the current location isn't occupied
        if (!thisLocation.occupied) {
            var randomFit = int(random(1, grid.biggestPossible(i)+1));
            // var randomFit = 1;
            // if (stepCount == 0) {
            //     randomFit == 1;
            // } else if (stepCount == 1 || stepCount == 2 || stepCount == 3) {
            //     randomFit = 3;
            // } else if (stepCount == 4) {
            //     randomFit = 2;
            // } else if (stepCount == 5) {
            //     randomFit = grid.biggestPossible(i);
            //     console.log("fifth", randomFit);
            // }

            var step = new SoundStep(thisLocation.x, thisLocation.y, randomFit);
            grid.blockOff(i, randomFit);
            steps.push(step);
            stepCount++;
        } else {
            continue;
        }

        // if (stepCount == 16) {
        //     break;
        // }

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
    console.log("steps!!", steps);
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
    while (nextRightLocation.x < canvasSize-baseSize && !this.locs[constrain(index, 0, this.locs.length-3)+2].occupied) {
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
