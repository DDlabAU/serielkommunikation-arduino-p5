int pot1Pin = A4;
int pot2Pin = A5;
int pot1Val;
int pot2Val;
int mappedPot1Val;
int mappedPot2Val;

void setup() {
  pinMode(pot1Pin, INPUT);
  pinMode(pot2Pin, INPUT);

  Serial.begin(9600);
}

void loop() {
 pot1Val = analogRead(pot1Pin);
 pot2Val = analogRead(pot2Pin);
 mappedPot1Val = map(pot1Val, 0, 1023, 0, 800);
 mappedPot2Val = map(pot2Val, 0, 1023, 0, 800);
 Serial.print(mappedPot1Val);
 Serial.print("//");
 Serial.println(mappedPot2Val);
 delay(1); 
}
