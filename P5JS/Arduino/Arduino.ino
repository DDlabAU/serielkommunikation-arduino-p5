int potentiometer1; 
int potentiometer2;
int mappedPot1; 
int mappedPot2;

void setup() {
 Serial.begin(9600); }

void loop() {
 potentiometer1 = analogRead(A5);
 potentiometer2 = analogRead(A4);
 mappedPot1 = map(potentiometer1, 0, 1023, 0, 800);
 mappedPot2 = map(potentiometer2, 0, 1023, 0, 800);
 Serial.print(mappedPot1);
 Serial.print("//");
 Serial.println(mappedPot2);
 delay(1); }
