# Serielkommunikation mellem arduino og P5JS

Denne tutorial vil gøre dig i stand til at etablere serial-kommunikation mellem din p5.js sketch og din arduino gennem node.js.



## Getting started

For at lave en forbindelse mellem din arduino og p5js skal du bruge 3 ting: arduinokode, p5js kode og en node serielserver. Trinnene nedenfor sætter denne server op og kører eksempelkode på arduino og p5js, så du kan styre en p5js sketch med to potentiometre fra din arduino.



1. Download eller clone dette repository så du har filerne lokalt på din computer

   https://github.com/DDlabAU/serielkommunikation-arduino-p5

2. Tilslut din arduino, åben arduino IDE'et  og noter hvilken port den er tilsluttet til på din computer

   ![install serialserver](./media/arduino-port-name.png)

3. Åbn så p5js koden der ligger her: ```P5JS/P5JS/sketch.js```
På linje 6 står der

   ```var portName = '/dev/cu.usbmodem1411';```

   her indsætter du dit eget portname som du noterede før. Gem så filen.

4. Byg nu kredsløbet til arduinoen i følge tegningen:

   ![](./media/arduino-kredsløb.png)

5. Åbn så arduinokoden du finder her: ```/P5JS/Arduino/Arduino.ino ``` og upload det til arduinoen

6. Åbn PC commandPrompt eller MAC Terminalen så du kan installere og køre seriel-serveren

7. Skriv først ```npm install p5.serialserver``` for at installere serveren

  ![install serialserver](./media/npm-install.png)

8. Skriv så ```node ~/node_modules/p5.serialserver/startserver.js``` for at starte den

  ![install serialserver](./media/node-start-server.png)

9. Hvis serialserveren kører, skulle det gerne se sådan ud. Lad terminalvinduet forblive åbent så længe du skal bruge serveren. Du vil også se fejlbeskeder her i terminalen, hvis der opstår problemer i kommunikationen mellem arduinoen og p5js.

  ![install serialserver](./media/server-is-running.png)

10. Kør så din p5js sketch og interager med dine potentiometre for at styre p5js sketchen.   
Du kan f.eks. åbne den med ```atom-live-server```-pakken, hvis du bruger Atom.   
Hvis du vil se selve værdierne som sketchen modtager, kan du åbne konsollen i din browser, hvor de bliver vist.
