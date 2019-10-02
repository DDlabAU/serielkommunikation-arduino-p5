// npm install p5.serialserver
// node ~/node_modules/p5.serialserver/startserver.js

var serial;
var options = {baudRate: 9600};

// Typisk portName på mac
// Kig i arduino IDE for at finde den korrekte port
var portName = '/dev/cu.usbmodem1411';
// Typisk portName på windows
// var portName = 'com10';

var x1;
var y1;
var x2;
var y2;
var xIn;
var yIn;

function setup() {
  createCanvas(800, 800);
  background(0);

  serial = new p5.SerialPort();
  serial.on('data', serialEvent);
//  serial.on('error', serialError);
  serial.open(portName, options);

  x1 = width/2;
  y1 = height/2;
  x2 = width/2;
  y2 = height/2;
}

function draw() {
  fill(255);
  stroke(400);

  x2 = xIn;
  y2 = yIn;

  x2 = constrain(x2, 0, width);
  y2 = constrain(y2, 0, height);

  line(x1, y1, x2, y2);
}

function serialEvent() {
  var inString = serial.readStringUntil('\r\n');
  console.log(inString);

  if (inString.length > 0 ) {
    var splitString = split(inString, "//");
    xIn = Number(splitString[0]);
    yIn = Number(splitString[1]);
  }
}
