import processing.serial.*;

Serial myPort;

int analogVar;
boolean digitalVar;

void setup() {
    // Vi udskriver alle tilgængelige porte/enheder for at få et bedre overblik
    println(Serial.list());

    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);

    // Vi beder vores serialEvent funktion til at vente med at skyde indtil der er modtaget et linjeskift
    myPort.bufferUntil('\n');
}

void draw() {

}

void serialEvent(Serial myPort) {
    // Vi læser den modtagne data indtil vi kommer til linjeskiftet, hvilket vil sige hele beskeden
    // Det sætter vi ind i en midlertidig variabel vi bruger til at bearbejde indholdet
    String received = myPort.readStringUntil('\n');

    // Vi tjekker at vores læste string ikke er null.
    if(received != null){
        // Vi fjerner eventuel ekstra whitespace omkring vores data
        received = trim(received);

        // Vi parser vores data til int-typen og sætter den ind i en passende variabel
        String ID = received.substring(0, 1);
        String value = received.substring(1);

        // Vi tjekker det modtagne ID for at finde ud af hvordan vi skal behandle værdien.
        if(ID.equals("P")){
            // Vi ved at denne værdi er en analog læsning så vi parser den til en int
            analogVar = Integer.parseInt(value);
        } else if(ID.equals("B")){
            // Vi ved at denne værdi er en digital læsning så vi parser den til en boolean.
            // Vi gør dette ved at sammenligne den modtagne streng med .equals(). Se opgave 3 for andre eksempler på hvordan vi også kan konverte denne digitale læsning til en boolean.
            if(value.equals("1")){
                digitalVar = true;
            } else{
                digitalVar = false;
            }
        }

        // Til sidst printer vi værdien
        println();
        print("Den modtagne besked: ");
        println(received);
        print("ID: ");
        println(ID);
        print("Value: ");
        println(value);
    }
}
