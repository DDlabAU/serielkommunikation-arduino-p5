import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

void setup() {
    // I know that the first port in the serial list on my mac
    // is Serial.list()[0].
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    println(Serial.list());
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
}

void draw() {
    // If data is available,
    if (myPort.available() > 0){
        // read it and store it in val
        val = myPort.readStringUntil('\n');
    }
    //print it out in the console
    println(val);
}
