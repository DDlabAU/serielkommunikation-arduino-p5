import processing.serial.*;

Serial myPort;

int potVar;
boolean buttonVar;

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
        String[] splitValues = split(received, ",");

        // Vi ved at den første værdi er en analog læsning så denne vil vi gerne have som int
        potVar = Integer.parseInt(splitValues[0]);

        // Vi ved at den anden værdi er en digital læsning der giver mest mening at have som en boolean.
        // I dette tilfælde ved vi også at den er sendt som enten 1 eller 0, så vi kan ikke bruge Boolen.parseBoolean() funktionen.
        // Det er op til jer selv, om i vil sende jeres værdier som 1/0 eller "true"/"false" i jeres egen kode.
        // Forskellen bliver i hvilken kode i vil 'regne om'. Vælger i at sende 1/0 er det i processing i sørger for at værdien bliver fortolket rigtigt, hvilket sker i vores if/else statements.
        // Sender i "true"/"false" er det derimod i arduino koden i sørger for at dataen fortolkes rigtigt, ved allerede dér at konvertere jeres 1/0 (eller HIGH/LOW) til "true"/"false", som nemmere parses her i processing.
        //
        // Her vælger vi at sammenligne den modtagne streng med strengen "1".
        // På den måde bruger vi samme logik som arduino hvor 1 er lig med true og 0 lig med false, uden vi behøver at parse.
        if(splitValues[1].equals("1")){
            buttonVar = true;
        } else {
            buttonVar = false;
        }

        // Man kunne også parse til int og sammenligne med tallet 1. I modsætning til tekststrengen "1" som ovenfor.
        // Det ville se sådan ud:
        //
        // int receivedVal = Integer.parseInt(splitValues[1]);
        // if(receivedVal == 1){
        //     buttonVar = true;
        // } else{
        //     buttonVar = false;
        // }
        //

        // Hvis vi havde sendt "true" eller "false" fra arduino, kunne vi have brugt Boolean.parseBoolean().
        // Der er her markant mindre kode, fordi vi i stedet vil have et if/else statement i vores arduino kode.
        //
        // buttonVar = Boolean.parseBoolean(splitValues[1]);

        // Til sidst printer vi værdierne
        println();
        print("Den modtagne besked: ");
        println(received);
        print("potVar: ");
        println(potVar);
        print("buttonVar: ");
        println(buttonVar);
    }
}
