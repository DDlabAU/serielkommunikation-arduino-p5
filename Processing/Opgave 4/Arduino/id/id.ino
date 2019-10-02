// De to pins vi vil læse fra
int potPin = A0;
int buttonPin = 2;

// Variabler der holder de læste værdier inden de bliver sat sammen til en samlet besked
int potVal;
boolean buttonVal;

// Et selvalgt tegn der bruges til at adskille værdierne. Det er denne værdi i giver til split() funktionen i processing.
String potID = "P";
String buttonID = "B";

void setup() {
    pinMode(potPin, INPUT);
    pinMode(buttonPin, INPUT);

    Serial.begin(9600);
}

void loop() {
    // Vi læser vores to værdier
    potVal = analogRead(potPin);
    buttonVal = digitalRead(buttonPin);

    // Vi sender vores værdier og to seperate beskeder. Hver besked indeholder et id og selve værdien vi vil sende.
    // Vi kombinerer ID og værdi ved at skrive ID'en med print efterfulgt af værdien med print*ln*.
    // Det er som sagt først når processing ser linjeskiftet fra println, at den tolker det som en hel besked.
    // Besked med potentiometerværdi sendes
    Serial.print(potID);
    Serial.println(potVal);

    // Besked med knapværdi sendes
    Serial.print(buttonID);
    Serial.println(buttonVal);

    // Vi kunne også kombinere ID og værdi til én streng (for hver besked) inden vi sender, ved at caste værdien til en streng og plusse den sammen med ID'et:
    //
    // Serial.println(potID + (String)potVal);
    // Serial.println(buttonID + (String)buttonVal);


    // Vi venter 100 milisekunder inden vi starter forfra.
    delay(100);
}
