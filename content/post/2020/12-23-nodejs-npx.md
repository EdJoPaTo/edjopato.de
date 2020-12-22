---
background:
  name: Steinstufen im Regen
  style: url(/assets/2020/12/wl-rain-steps.jpg)
date: 2020-12-23T00:07:00+01:00
lastmod: 2020-12-23T18:07:00+01:00
title: NodeJS binaries ausführen ohne npx
tags:
  - command-line
  - nodejs
  - npm
  - javascript
  - typescript
---
Wer mit NodeJS arbeitet und entwickelt, der nutzt sicherlich auch Tools, welche beispielsweise als devDependency im Projekt hinterlegt sind.
Beispielsweise einen Test Runner wie `ava` oder einen Code Linter wie `xo` oder `eslint`.

Um solch ein Tool auszuführen gibt es mehrere Wege.
<!--more-->

# NPM Script

Der vermutlich bekannteste Weg sind die Skripte in der `package.json`.
```json
{
  "scripts": {
    "ava": "ava",
    "ava:watch": "ava --watch",
    "test": "ava"
  }
}
```

Will man jetzt eines der Scripte ausführen, benutzt man `$ npm run <name>`.
Es ist relativ normal das script `start` und `test` zu verwenden, da man dann, ohne das Projekt zu kennen `$ npm start` und `$ npm test` verwenden kann.
So verwenden beispielsweise Continous Testing Plattformen automatisch schon `$ npm test` als Standard Skript.

Wenn man sich die `package.json` von verschiedenen Projekten anschaut, dann findet man häufig das konstrukt, dass key und value gleich sind, wie auch oben im Beispiel: `"ava": "ava"`.
Dies hat den Vorteil, dass man so leicht ava mit Argumenten aufrufen kann:
`$ npm run ava -- --help` oder `$ npm run ava -- --watch`.
Allerdings muss man jedes dieser Tools einzeln manuell auflisten.

Aber das muss doch auch einfacher gehen?

# NPX

[npx](https://github.com/npm/npx) ist ein "kleines" Skript, welches in normalen NodeJS/NPM installationen ebenfalls ausgeliefert wird.
In Arch Linux ist es beispielsweise teil des [npm packages](https://archlinux.org/packages/community/any/npm/files/).
Dieses Script hat hauptsächlich eine Bewandnis:
Mal eben eine binary aus einem npm package ausführen.

`$ npx ava` und ava wird ausgeführt.
`$ npx ava --watch` und ava wird mit dem Argument `--watch` ausgeführt.

Eigentlich ja ganz schick, aber was ist das Problem?

Zum einen, dass `npx` mächtiger ist, als einfach nur eine binary eines bereits installierten Packages zu installieren.
`npx` kann auch, wenn man in einem Ordner, der kein NodeJS Projekt ist, das jeweilige package herunterladen und direkt ausführen.
Wie häufig war ich schon in einem falschen Ordner und habe `npx` beim Herunterladen abgebrochen, nur um dann in den richtigen Ordner zu wechseln?

Gut man könnte sich einen alias `alias npx='npx --no-install'` setzen, aber warum ein komplexes Tool für eine einfache Aufgabe?

Das andere Problem ist der Zustand des Projektes.
Wenn man auf [GitHub](https://github.com/npm/npx) schaut, dann scheint es nicht all zu häufig updates zu geben.
Wenn ein Tool stabil ist, ist das doch auch garnicht nötig?
Stimmt, aber `git clone` mal das projekt und führe `$ npm audit` aus:
```
found 89 vulnerabilities (41 low, 25 moderate, 23 high)
```

Ups…

# Self made

Was genau passiert denn da eigentlich im Hintergrund?
Was genau davon brauche ich?

Wenn man ein npm package wie ava installiert, dann wird dies in `node_modules/ava` entpackt.
In der `package.json` von ava ist eine binary `ava` definiert: `"bin": {"ava": "cli.js"}`.
Jetzt könnte man natürlich alle packages durchsuchen, ob jeweils binaries definiert sind.
Muss man aber garnicht, `npm` tut dies schon beim Installieren und linkt alle in `node_modules/.bin`.
```bash
$ ls -l
ava -> ../ava/cli.js
```

`$ npx ava --watch` führt effektiv nur das Argument `ava --watch` mit der in `node_modules/.bin` verlinkten binary `ava` aus.

Wenn man eine Binary auf einem Rechner ausführt, wie zum Beispiel `echo`, dann muss der Rechner diese Binary finden.
Dafür gibt es die `$PATH` Variable, in welchen Ordnern gesucht werden soll.
Wenn wir dieser Variable einfach den Pfad `./node_modules/.bin` hinzufügen, dann wird auch in diesem Ordner gesucht.
Das `./` bedeutet, dass dies vom aktuellen Ordner ausgeht.
Wenn man also in einem Ordner ist, der einen `node_modules` Ordner hat, kann dies funktionieren, in einem ganz anderen Ordner wird dies einfach ignoriert.

```bash
export PATH=$PATH:./node_modules/.bin
```

Fügt man dies in seine `.bashrc` (`.zshrc`, …) ein, wird dies automatisch bei jedem Starten der Shell zur `$PATH` Variable hinzugefügt.

Dadurch dass die npm packages jetzt mit im `$PATH` sind, können diese wie alle anderen Programme auch ausgeführt werden.
Im Falle von `ava` kann man einfach `$ ava` oder `$ ava --watch` benutzen.

Einziger Nach- (und Vor)teil den ich aktuell sehe: Dadurch dass der Pfad an die `$PATH` variable angehängt wird, wird hier zuletzt gesucht.
Wenn es sowohl ein npm package als auch eine system executable mit dem selben Namen gibt, wird die erste im Pfad, die aus dem System, genutzt.
Es passiert also nicht so leicht, dass etwas anderes passiert, als man erwartet.
Wenn also jemand ein npm package `echo` baut und dies installiert, dann wird weiterhin die System `echo` genutzt.
Will man trotzdem das npm package ausführen, sollte man dies manuell über `./node_modules/.bin/echo` ausführen.
Die Alternative wäre, den Pfad an den Anfang von `$PATH` zu stellen, dabei aber zu riskieren, dass Commands plötzlich etwas völlig anderes tun.

Ich weiß nicht, wie sich potenziell global installierte npm packages verhalten, die außerdem noch lokal installiert sind.
Tendenziell wird weiterhin zuerst die global installierte Variante ausgeführt.
Ich persönlich vermeide allerdings global installierte npm packages, werde es also so schnell auch nicht heraus finden.
Für mich sollte alles im jeweiligen Repo sein, das Repo soll in sich vollständig sein und ohne großartig äußere Abhängigkeiten laufen, die nicht als dependencies gelistet sind.

Mit der Anpassung der `$PATH` Variable gibt es einen Weg, ohne `npx` oder viele scripts in der `package.json` mit dem selben key und value.
Und der Weg ist aus meiner Sicht auch noch simpler.

Was mich jedoch wundert:
Hat dieser Weg noch einen weiteren Nachteil, den ich nicht sehe?
Ansonsten würde dieser doch häufiger irgendwo erwähnt?
