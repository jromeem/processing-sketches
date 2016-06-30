console.log('hello observatori!');

var analyzer, randomSong;

var songs = [];
var songFiles = [
    "XC13883.mp3",  // Lazuli Bunting - Passerina amoena
    "XC268216.mp3", // Mourning Dove - Zenaida macroura marginella
    "XC278637.mp3", // Banded Wren - Thryophilus pleurostictus
    "XC309897.mp3", // Yellow-throated Vireo - Vireo flavifrons
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
    var canvas = createCanvas(500, 500);
    canvas.parent("p5canvas");

    // get a song
    randomSong = songs[int(random(songs.length))];
    randomSong.play();

    // create a new Amplitude analyzer
    analyzer = new p5.Amplitude();
    // Patch the input to an volume analyzer
    analyzer.setInput(randomSong);
}

function draw() {
    if (!randomSong.isPlaying())
        noLoop();

    background(100);

    var rms = analyzer.getLevel();
    // Get the average (root mean square) amplitude
    var rms = analyzer.getLevel();
    fill(200,250,100);
    noStroke(0);

    // Draw an ellipse with size based on volume
    ellipse(width/2, height/2, 10+rms*300, 10+rms*300);
    console.log("rms: ", rms);
}
