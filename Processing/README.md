# Serielkommunikation mellem arduino og processing
Dette er en begyndervejledning til serielkommunikation mellem arduino og processing. I vil blive introduceret til simpel kommunikation fra processing til arduino og mere kompleks kommunikation fra arduino til processing.
Det forudsættes at i har styr på det basale arduino og er i stand til at opsætte og læse simple sensorer så som potentiometre og knapper. Der forventes også et basalt kendskab til processing.
Når i færdige med guiden vil i være i stand til at sende simple kommandoer fra processing til arduino og sende op til flere læste værdier fra arduino til processing, enten samlet eller ved hjælp af et simpelt id-system.

## Kom i gang
Inden i starter skal i sørge for at have både arduino og processing installeret og opdateret til de nyeste versioner. Sørg også for at have de nødvendige drivere installeret, så jeres arduino er good to go.

Sparkfun har lavet en fin guide til at komme igang på. Start fra "From Arduino..."-afsnittet og følg guiden til og med "...to Arduino"-afsnittet. Når i har gjort det, vil i være igang med at kommunikere, på en hurtig og simpel måde, fra både fra arduino til processing og den anden vej.

Tip: Hvis i har svært ved at finde jeres arduino-board inde fra processing kan i skrive `println(Serial.list());` for at se alle tilgængelige porte.

### Opgave 1: Kom i gang
Følg guiden til og med "...to Arduino"-afsnittet: https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing


## Modtag data på den pæne måde
Det bliver hurtigt rodet at skulle modtage data i selve draw-funktionen i processing. Det kan vi undgå ved at gøre brug af den indbyggede `serialEvent` -funktion, som kaldes hver gang der modtages data. Ved hjælp af `bufferUntil()` kan vi endda få funktionen til at vente med at skyde, indtil der er modtaget et selvvalgt tegn. I vores tilfælde venter vi indtil vi modtager `"\n"`, hvilket er et linjeskift der automatisk sendes med når vi anvender println-funktionen i arduino. Når vi modtager dette ved vi altså at vi har modtaget en hel besked.
Vi kan så læse hele denne besked ved hjælp af `readStringUntil()`, der læser alt der er tilgængeligt op til en given karakter. I vores tilfælde giver det mening at lade denne karakter være '\n', da det er den sidste i beskeden, hvilket betyder at vi læser hele beskeden (med undtagelse af linjeskiftet) ind som en string.
Det kan hænde at der sker fejl i kommunikationen mellem arduino og processing og den læste string faktisk ikke indeholder noget. For at sikre os imod det laver vi et simpelt tjek `modtagetString != null`.
Vi kan også komme ud for, at der kommer ekstra whitespace (mellemrum) på den modtagne data, hvilket kan gøre dataen svær at arbejde med fremadrettet. Ved at bruge `trim()` funktionen kan vi fjerne alt dette og kun have den ønskede data tilbage.

Vi er nu sikre på at vores modtagne data faktisk indeholder noget (ikke er null) og vi har renset den for whitespace. Nu vil den opmærksomme studerende måske have lagt mærke til, at vi har indlæst og behandlet denne data som en string. Det gør vi fordi det simpelthen bare er nemmest at læse og behandle dataen når det er i denne type. Men hvad gør vi, hvis det vi har modtaget ikke er en tekststreng, men derimod et tal eller en boolean? Løsningen på dette er at *parse* vores modtagne data til en anden type. De typer vi typisk gerne vil parse til har heldigvis hverisær indbyggede funktioner, til at tage imod sådan en string og spytte den ud som sin egen type:

```
int heltalsVariabel = Integer.parseInt(modtagetString);
float kommatalsVariabel = Float.parseFloat(modtagetString);
boolean bolskVaribel = Boolean.parseBoolean(modtagetString);
```

Vær opmærksom på at parseBoolean funktionen kan være lidt drilsk da den kun parser en string der indholder "true" som *true* og alt andet som *false*. I kan altså ikke, når i vil parse, bruge arduino logikken hvor 1 betyder *true* og 0 betyder *false*. I det tilfælde giver det bedre mening at tjekke om strengen er lig med `.equals()` enten "0" eller "1" og så indsætte en værdi i jeres boolean variabel derefter. I kan også parse til en int og tjekke ved hjælp af `==`.

### Opgave 2: Gør det pænt
Lav føste del af guiden (arduino til processing), hvor dataen modtages i serialEvent istedet for draw. For bedre at illustrere alle de trin der kan finde sted, så sender vi et heltal, i stedet for "Hello World!"
* Ret i arduinokoden så I sender et tal i stedet for tekstbeskeden fra tidligere
* Indsæt serialEvent funktionen i jeres kode.
* Sæt bufferen på serialEvent til at buffer indtil \n ved hjælp af "bufferUntil('\n');"
* Læs den modtagne besked i serialEvent med readStringUntil-funktionen
* Tjek at den læste streng ikke er null
* Rens den modtagne data med "trim()"
* Parse den modtagne værdi til en passende type og sæt den i en variabel.


## Mere kompleks kommunikation
På et tidspunkt vil vi gerne sende mere end bare enkelte værdier fra arduino til processsing. Men hvordan gør vi det på en måde, så vi stadig ved, hvilken data vi modtager?
Vi kan vælge at sende alle værdierne samlet fra arduino til processing, i én besked. Vi adskiller de enkelte værdier med et selvvalgt seperator-tegn og skiller dem ad igen i processing med `split()` funktionen.  
Den simpleste måde at gøre dette på er ved at benytte `print()` funktionen til at skrive alle værdier og seperatorer til samme linje og afslutte med en `println()`, der indsætter et linjeskift.
```arduino
print(sensorValue1);
print(",");
print(sensorValue2);
println();
```
Vi kan også kombinere værdierne og seperatorerne til én streng og sende denne streng med en println. Det kræver bare at vi caster vores værdier om til strenge:
```
String toSend = (String) sensorValue1 + "," + (String) sensorValue2;
Serial.println(toSend);
```
I processing modtager, tjekker og trimmer vi beskeden og splitter den så op til en liste af værdier:
```
String[] splitValues = split(received, ",");
int sensor1Var = Integer.parseInt(splitValues[0]);
```

Vi kan også vælge at sende vores data enkeltvist, hvis det giver mere mening. Ulempen er her, at vi ikke ved, hvilken data der kommer hvornår. I forrige eksempel kom alle data i samme rækkefølge hver gang. Her kan vi måske komme ud for, at der kommer data fra samme sensor to gange i streg, før vi modtager data fra den anden sensor.
En måde at identificere vores forskellige data på, er ved at vælge et unikt ID, f.eks et bogstav, for hver sensor og tilføje dette ID til begyndelsen af beskeden. Igen kan dette gøres enten ved at kombinere prints og printlns
```arduino
Serial.print("A");
Serial.println(sensorValue1);
Serial.print("B");
Serial.println(sensorValue2);
```
eller ved at caste værdien og kombinere den med ID'et til en streng.
```arduino
Serial.println("A" + (String) sensorValue1);
Serial.println("B" + (String) sensorValue2);
```

Når vi har modtaget, tjekket og trimmet vores besked i processing vil vi gerne splitte den op i et ID og en værdi. Det gør vi ved at bruge `substring()`.
Derefter kan vi, ud fra dette ID, finde ud af hvilken type det giver mest mening at parse vores modtagne værdi til:
```
String ID = receivedMessage.substring(0, 1);
String value = receivedMessage.substring(1);
if(ID.equals("A")){
    // Parse value-variablen til en bestemt type
} else if(ID.equals("B")){
    // Parse den til en anden type
}
```

### Opgave 3: Kombinér, send, split
* Tilslut et potentiometer og en knap til jeres arduino.
* Læs og send data fra disse til processing:
  * I én samlet besked.
  * Separer værdierne med selvvalgt tegn.
* Modtag data i processing (på den pæne måde, som i lærte tidligere):
  * Split jeres data op ved jeres selvvalgte tegn med split()-funktionen.
  * Parse de individuelle værdier til passende typer og sæt dem i variabler.
  * Print værdierne ud i konsollen eller skriv dem på skærmen.

### Opgave 4: Send separat med ID
* Tilslut et potentiometer og en knap til jeres arduino.
* Læs og send data fra disse til processing:
  * Enkeltvist
  * Vælg et unikt id og sæt dette ind første i dataen som i sender.
* Modtag data i processing (på den pæne måde, som i lærte tidligere):
  * Del den modtagne data op i ID og værdi og sæt disse i passende variabler
  * Parse den modtagne værdi til en passende datatype udfra dets ID.
  * Sæt værdien ind i den matchende variabel.
  * Print værdierne ud i konsollen eller skriv dem på skærmen.

## Links
### Generelle
https://processing.org/reference/    
https://processing.org/reference/libraries/serial/    
https://www.arduino.cc/en/Reference/HomePage

### Opgave 2
[serialEvent](https://processing.org/reference/libraries/serial/serialEvent_.html)    
[bufferUntil](https://processing.org/reference/libraries/serial/Serial_bufferUntil_.html)    
[readStringUntil](https://processing.org/reference/libraries/serial/Serial_readStringUntil_.html)    
[trim](https://processing.org/reference/trim_.html)    
[equals](https://processing.org/reference/String_equals_.html)    

### Opgave 3
[split](https://processing.org/reference/split_.html)    

### Opgave 4
[substring](https://processing.org/reference/String_substring_.html)    
