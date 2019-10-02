// npm install p5.serialserver
// node ~/node_modules/p5.serialserver/startserver.js

var serial;
var options = {baudRate: 9600};
var portName = '/dev/cu.usbmodem1411';
var x1 = 0;
var y1 = 0;
var x2 = 0;
var y2 = 0;
var xIn = 0;
var yIn = 0;

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

  if (xIn > 500) {
    x2 += 1;
  } else if (xIn < 300) {
    x2 -= 1;
  }

  if (yIn > 500){
    y2 += 1;
  } else if (yIn < 300){
    y2 -= 1;
  }

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
