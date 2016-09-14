console.log('hello observatori!');

var fft, analyzer, randomSong, randX, randY, offset;
var oldX, oldY, newX, newY;
var lineSize = 20;
var newSong;

var songs = [];
var songFiles = [
    "XC13883.mp3",  // Lazuli Bunting - Passerina amoena
    "XC268216.mp3", // Mourning Dove - Zenaida macroura marginella
    "XC278637.mp3", // Banded Wren - Thryophilus pleurostictus
    "XC309897.mp3", // Yellow-throated Vireo (with commentary) - Vireo flavifrons
    "XC316110.mp3", // Wood Thrush - Hylocichla mustelina
    "XC318940.mp3", // Painted Bunting - Passerina ciris
    "XC318977.mp3", // Common Blackbird - Turdus merula
    "XC321788.mp3", // Northern Mockingbird - Mimus polyglottos
    "XC34578.mp3",  // Painted Bunting - Passerina ciris
    "XC53772.mp3",  // Yellow-throated Vireo - Vireo flavifrons
];

function preload() {
    for (var i = 0; i < songFiles.length; i++) {
        var songFile = songFiles[i];
        var song = loadSound('songs/' + songFile);
        songs.push(song);
    }
}

function setup() {
    var canvas = createCanvas(window.innerWidth, window.innerHeight);
    canvas.parent("p5canvas");

    // get a song
    randomSong = songs[int(random(songs.length))];
    randomSong.play();

    // create a new Amplitude analyzer
    analyzer = new p5.Amplitude();
    fft = new p5.FFT();

    // Patch the input to an volume analyzer
    analyzer.setInput(randomSong);
    fft.setInput(randomSong);

    offset = 0;
    randX = int(random(0+offset, width-offset));
    randY = int(random(0+offset, height-offset));
    background(190, 235, 159, 10);
}

function draw() {
    if (!randomSong.isPlaying())
        noLoop();

    // fill(0, 163, 136, 2);
    // rect(0, 0, width, height);

    // Get the average (root mean square) amplitude
    var rms = analyzer.getLevel();
    var normRms = rms * 100;
    var colr, colg, colb;
    colr = map(rms, 0, 0.1, 0, 190);
    colg = map(rms, 0, 0.1, 163, 235);;
    colb = map(rms, 0, 0.1, 136, 159);;

    // stroke(colr,colg,colb);
    var lineTop = map(rms, 0.0, 1.0, 0.0, height);
    var lineBottom = map(rms, 0.0, 1.0, height, 0.0);
    var lineLeft = map(rms, 0.0, 1.0, 0.0, width);
    var lineRight = map(rms, 0.0, 1.0, width, 0.0);
    noStroke();
    fill(colr, colg, colb);
    rect(0, lineBottom-lineBottom%lineSize, width, lineSize);
    rect(0, lineTop-lineTop%lineSize, width, lineSize);
    rect(lineLeft-lineLeft%lineSize, 0, lineSize, height);
    rect(lineRight-lineRight%lineSize, 0, lineSize, height);

    // line(0, lineBottom, width, lineBottom);
    // line(0, lineTop, width, lineTop);
    // line(lineLeft, 0, lineLeft, height);
    // line(lineRight, 0, lineRight, height);

    noStroke();
    noStroke(0);
    fill(colr,colg,colb);
    var ellipseSize = (10+rms*500) - 10+rms*500%20;
    ellipse(randX, randY, ellipseSize, ellipseSize);
    newSong = true;
    console.log("rms: ", rms, 'normalized: ', normRms);
}
