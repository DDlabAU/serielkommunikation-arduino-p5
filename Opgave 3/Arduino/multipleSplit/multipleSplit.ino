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

    // Vi sender vores værdier ved at printe den til serielporten. Vi bruger print og ikke bare println, da vi i processing kigger efter linjeskift (\n) som indikator på endt besked.
    // Alt det vi sender med print kommer i samme besked, som afsluttes med en println, der fortæller processing at de modtagne værdier er én besked, ved at indsætte et linjeskift (\n) til slut.
    Serial.print(potVal);
    Serial.print(seperator);
    Serial.print(buttonVal);
    Serial.println();

    // Man kan også tage værdier og sætte dem sammen til én string og så sende den. For at gøre er vi dog nødt til at caste vores værdier først:
    //
    // String toSend = (String)potPin + seperator + (String)buttonVal;
    // Serial.println(toSend);



    // Vi venter 100 milisekunder inden vi starter forfra.
    delay(100);
}
