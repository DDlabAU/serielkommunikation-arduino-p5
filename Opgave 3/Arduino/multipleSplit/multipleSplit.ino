// De to pins vi vil læse fra
int potPin = A0;
int buttonPin = 2;

// Variabler der holder de læste værdier inden de bliver sat sammen til en samlet besked
int potVal;
boolean buttonVal;

// Et selvalgt tegn der bruges til at adskille værdierne. Det er denne værdi i giver til split() funktionen i processing.
String seperator = ",";

void setup() {
    pinMode(potPin, INPUT);
    pinMode(buttonPin, INPUT);

    Serial.begin(9600);
}

void loop() {
    // Vi læser vores to værdier
    potVal = analogRead(potPin);
    buttonVal = digitalRead(buttonPin);

    // Her plusser vi vores værdier sammen til en stor tekststreng og sætter det ind i en variabel.
    // Husk at starte med "", da det gør at man med +-operatoren ligger værdier til strengen i stedet for at forsøge at plusse dem sammen som tal.
    String toSend = "" + potVal + seperator + buttonVal;

    // Vi sender vores streng ved at printe den til serielporten. Vi bruger print*ln* og ikke bare print, da vi i processing kigger efter linjeskift (\n) som indikator på endt besked.
    // println tilføjer automatisk dette linjeskift, i modsætning til print.
    Serial.println(toSend);

    // Vi venter 100 milisekunder inden vi starter forfra.
    delay(100);
}
