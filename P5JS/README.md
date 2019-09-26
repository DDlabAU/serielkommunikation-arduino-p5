# Serielkommunikation mellem arduino og P5JS

Denne tutorial vil gøre dig i stand til at etablere serial-kommunikation mellem din p5.js sketch og din arduino gennem node.js.

## Getting started

1. download  repository 

   https://github.com/DDlabAU/serielkommunikation-arduino-p5

2. tilslut din arduino og find ud af hvilken port den er tilsluttet med på din PC/MAC

   ![arduport](https://github.com/DDlabAU/serielkommunikation-arduino-p5/blob/master/P5JS/media/arduino%20port%20name.png)

3. inde i serielkommunikation-arduino-p5/P5JS/P5/sketch.js på linje 6 står der 

   ```javascript
   var portName = '/dev/cu.usbmodem1411';
   ```

   her indsætter du dit eget portname. og gemmer filen (ctrl(cmd)-s)

4. byg kredsløbet til arduinoen i følge tegningen. 

   ![insert schematic](https://github.com/DDlabAU/serielkommunikation-arduino-p5/blob/master/P5JS/media/arduino%20kredsl%C3%B8b.png)

5. Upload scriptet til arduinoen

6. åben PC commandPrompt eller MAC Terminalen

7. npm install p5.serialserver

  ![install serialserver](/media/npm install.png)

8. node ~/node_modules/p5.serialserver/startserver.js
  ![node start server](https://github.com/DDlabAU/serielkommunikation-arduino-p5/blob/master/P5JS/media/node%20start%20server.png)

9. hvis serialserveren kører skulle det gerne se sådan ud.
  ![server is running](https://github.com/DDlabAU/serielkommunikation-arduino-p5/blob/master/P5JS/media/server%20is%20running.png)

10. compile din p5.js sketch og interager med potentiometrene.
