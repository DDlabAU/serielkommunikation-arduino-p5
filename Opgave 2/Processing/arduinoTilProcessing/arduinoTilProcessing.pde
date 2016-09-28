import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;     // Den bearbejdede data modtaget fra arduinoen

void setup() {
    // Vi udskriver alle tilgængelige porte/enheder for at få et bedre overblik
    println(Serial.list());


    // I know that the first port in the serial list on my mac
    // is Serial.list()[0].
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);

    // Vi beder vores serialEvent funktion til at vente med at skyde indtil der er modtaget et linjeskift
    myPort.bufferUntil('\n');
}

void draw() {

}

void serialEvent(Serial myPort){
    // Vi læser den modtagne data indtil vi kommer til linjeskiftet, hvilket vil sige hele beskeden
    // Det sætter vi ind i en midlertidig variabel vi bruger til at bearbejde indholdet
    String received = myPort.readStringUntil('\n');

    // Vi tjekker at vores læste string ikke er null.
    if(received != null){
        // Vi fjerner eventuel ekstra whitespace omkring vores data
        received = trim(received);
        // Vi parser vores data til int-typen og sætter den ind i en passende variabel
        val = Integer.parseInt(received);

        //print it out in the console
        println(val);
    }
}