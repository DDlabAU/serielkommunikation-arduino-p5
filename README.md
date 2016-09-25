# Serialkommunikation mellem arduino og processing
Dette er en begyndervejledning til serielkommunikation mellem arduino og processing. I vil blive introduceret til simpel kommunikation fra processing til arduino og mere kompleks kommunikation fra arduino til processing.
Det forudsættes at i har styr på det basale arduino og er i stand til at opsætte og læse simple sensorer så som potentiometre og knapper. Der forventes også et basalt kendskab til processing.
Når i færdige med guiden vil i være i stand til at sende simple kommandoer fra processing til arduino og sende op til flere læste værdier fra arduino til processing, enten samlet eller ved hjælp af et simpelt id-system.

## Kom i gang
Inden i starter skal i sørge for at have både arduino og processing installeret og opdateret til de nyeste versioner. Sørg også for at have de nødvendige drivere installeret, så jeres arduino er good to go.

Sparkfun har lavet en fin guide til at komme igang på. Start fra "From Arduino..."-afsnittet og følg guiden til og med "...to Arduino"-afsnittet. Når i har gjort det, vil i være igang med at kommunikere, på en hurtig og simpel måde, fra både fra arduino til processing og den anden vej.

Tip: Hvis i har svært ved at finde jeres arduino-board inde fra processing kan i skrive `println(Serial.list());` for at se alle tilgængelige porte.

### Opgave 1: Kom i gang
Følg guiden til og med "...to Arduino"-afsnittet: https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing


## Modtag data på den lækre måde.
Det bliver hurtigt rodet at skulle modtage data i selve draw-funktionen i processing. Det kan vi undgå ved at gøre brug af den indbyggede `serialEvent` -funktion, som kaldes hver gang der modtages data. Ved hjælp af `bufferUntil()` kan vi endda få funktionen til at vente med at skyde, indtil der er modtaget et selvvalgt tegn. I vores tilfælde venter vi indtil vi modtager `"\n"`, hvilket er et linjeskift der automatisk sendes med når vi anvender println-funktionen i arduino. Når vi modtager dette ved vi altså at vi har modtaget en hel besked.
Vi kan komme ud for, at der kommer ekstra whitespace (mellemrum, linjeskift mm.) på den modtagne data, hvilket kan gøre dataen svær at arbejde med fremadrettet. Ved at bruge `trim()` funktionen kan vi fjerne alt dette og kun have den ønskede data tilbage.

### Opgave 2: Gør det lækkert
* Lav føste del af guiden (arduino til processing), hvor dataen modtages i serialEvent i stedet for draw.
  * Sæt bufferen på serialEvent til at buffer indtil \n ved hjælp af "bufferUntil('\n');"
* Tjek at jeres modtagne string ikke er null
* Rens den modtagne data med "trim()"
* Konverter den modtagne værdi til en passende type og sæt den i en variabel.


## Mere kompleks kommunikation:
På et tidspunkt vil vi gerne sende mere end bare enkelte værdier fra arduino til processsing. Men hvordan gør vi det på en måde så vi stadig ved hvilken data vi modtager?
Vi kan vælge at sende alle værdierne samlet fra processing til arduino. Vi adskiller de enkelte værdier med et selvvalgt tegn og skiller dem ad i processing. Den nemmeste måde at gøre dette er ved at plusse alle værdierne og det selvvalgte tegn sammen til én string, der så sendes afsted:
```arduino  
String toSend = "" + sensorValue1 + "," + sensorValue2;
```

Vi kan også vælge at sende vores data enkeltvis, hvis det giver mere mening. Ulempen er her, at vi altså ikke ved, hvilken data der kommer hvornår. I forrige eksempel kom alle data i samme rækkefølge hver gang. Her kan vi måske komme ud for, at der kommer data fra samme sensor to gange i streg, før vi modtager data fra den anden sensor.
En måde at identificere vores forskellige data på, er ved at vælge et unikt id, f.eks et bogstav, for hver sensor og tilføje dette id til begyndelsen af beskeden.
```arduino
String toSend = "A" + sensorValue1;
Serial.println(toSend);
String toSend = "B" + sensorValue2;
Serial.println(toSend);
```

Når vi modtager data i processing tjekker vi hvad det første tegn i beskeden er. Det kan vi vælge at gøre med `charAt()` eller `substring()`. charAt giver en character og substring en string, vælg den i er tryggest ved.
Er det første tegn i beskeden et 'A' ved vi at værdien er sensorValue1, er det derimod et 'B' ved vi at det er sensorValue2. Derudfra kan vi bearbejde resten af dataen på en passende måde.


### Opgave 3: Kombinér, send, split
* Tilslut mindst to sensorer til jeres arduino.
* Send data fra disse sensorer til processing:
  * I én samlet besked.
  * Separer værdierne med selvvalgt tegn.
* Modtag data i processing (på den lækre måde, som i lærte tidligere):
  * Split jeres data op ved jeres selvvalgte tegn med split()-funktionen.
  * Cast de individuelle værdier til passende typer og put dem i variabler.
  * Print værdierne ud i konsollen eller skriv dem på skærmen.

### Opgave 4: Send separat med ID.
* Tilslut mindst to sensorer til jeres arduino.
* Send data fra disse sensorer til processing:
  * Enkeltvist
  * Vælg et unikt id og sæt dette ind første i dataen som i sender
* Modtag data i processing (på den lækre måde, som i lærte tidligere):
  * Undersøg hvad det første tegn i den modtagne data er.
  * Cast den modtagne værdi til en passende datatype.
  * Sæt værdien ind i den matchende variabel.
  * Print værdierne ud i konsollen eller skriv dem på skærmen.
