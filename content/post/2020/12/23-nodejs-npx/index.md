---
title: Node.js binaries ausführen ohne npx
date: 2020-12-23T00:07:00+01:00
categories:
  - open-source
tags:
  - command-line
  - nodejs
  - typescript
---
Wer mit Node.js arbeitet und entwickelt, der nutzt sicherlich auch Tools, welche beispielsweise als devDependency im Projekt hinterlegt sind.
Beispielsweise einen Test Runner wie `ava` oder einen Code Linter wie `xo` oder `eslint`.

Um solch ein Tool auszuführen, gibt es mehrere Wege.
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
Es ist relativ normal das Script `start` und `test` zu verwenden, da man dann, ohne das Projekt zu kennen `$ npm start` und `$ npm test` verwenden kann.
So verwenden beispielsweise Continous Testing Plattformen automatisch schon `$ npm test` als Standard Skript.

Wenn man sich die `package.json` von verschiedenen Projekten anschaut, dann findet man häufig das Konstrukt, dass Key und Value gleich sind, wie auch oben im Beispiel: `"ava": "ava"`.
Dies hat den Vorteil, dass man so leicht ava mit Argumenten aufrufen kann:
`$ npm run ava -- --help` oder `$ npm run ava -- --watch`.
Allerdings muss man jedes dieser Tools einzeln manuell auflisten.

Aber das muss doch auch einfacher gehen?

# NPX

[npx](https://github.com/npm/npx) ist ein "kleines" Skript, welches in normalen Node.js/NPM installationen ebenfalls ausgeliefert wird.
In Arch Linux ist es beispielsweise teil des [npm packages](https://archlinux.org/packages/community/any/npm/files/).
Dieses Script hat hauptsächlich eine Bewandtnis:
Mal eben eine Binary aus einem NPM package ausführen.

`$ npx ava` und ava wird ausgeführt.
`$ npx ava --watch` und ava wird mit dem Argument `--watch` ausgeführt.

Eigentlich ja ganz schick, aber was ist das Problem?

Zum einen, dass `npx` mächtiger ist, als einfach nur eine Binary eines bereits installierten Packages zu installieren.
`npx` kann auch, wenn man in einem Ordner, der kein Node.js Projekt ist, das jeweilige package herunterladen und direkt ausführen.
Wie häufig war ich schon in einem falschen Ordner und habe `npx` beim Herunterladen abgebrochen, nur um dann in den richtigen Ordner zu wechseln?

Gut man könnte sich einen alias `alias npx='npx --no-install'` setzen, aber warum ein komplexes Tool für eine einfache Aufgabe?

Das andere Problem ist der Zustand des Projektes.
Wenn man auf [GitHub](https://github.com/npm/npx) schaut, dann scheint es nicht allzu häufig Updates zu geben.
Wenn ein Tool stabil ist, ist das doch auch gar nicht nötig?
Stimmt, aber `git clone` mal das Projekt und führe `$ npm audit` aus:

```plaintext
found 89 vulnerabilities (41 low, 25 moderate, 23 high)
```

Ups…

# Self made

Was genau passiert denn da eigentlich im Hintergrund?
Was genau davon brauche ich?

Wenn man ein NPM package wie ava installiert, dann wird dies in `node_modules/ava` entpackt.
In der `package.json` von ava ist eine Binary `ava` definiert: `"bin": {"ava": "cli.js"}`.
Jetzt könnte man natürlich alle packages durchsuchen, ob jeweils Binaries definiert sind.
Muss man aber gar nicht, `npm` tut dies schon beim Installieren und linkt alle in `node_modules/.bin`.

```bash
$ ls -l
ava -> ../ava/cli.js
```

`$ npx ava --watch` führt effektiv nur das Argument `ava --watch` mit der in `node_modules/.bin` verlinkten binary `ava` aus.

Wenn man eine Binary auf einem Rechner ausführt, wie zum Beispiel `echo`, dann muss der Rechner diese Binary finden.
Dafür gibt es die `$PATH` Variable, in welchen Ordnern gesucht werden soll.
Wenn wir dieser Variable den Pfad `./node_modules/.bin` hinzufügen, dann wird auch in diesem Ordner gesucht.
Das `./` bedeutet, dass dies vom aktuellen Ordner ausgeht.
Wenn man also in einem Ordner ist, der einen `node_modules` Ordner hat, kann dies funktionieren, in einem ganz anderen Ordner wird dies ignoriert.

```bash
export PATH=$PATH:./node_modules/.bin
```

Fügt man dies in seine `.bashrc` (`.zshrc`, …) ein, wird dies automatisch bei jedem Starten der Shell zur `$PATH` Variable hinzugefügt.

Dadurch dass die NPM packages jetzt mit im `$PATH` sind, können diese wie alle anderen Programme auch ausgeführt werden.
Im Falle von `ava` kann man `$ ava` oder `$ ava --watch` benutzen.

Einziger Nach- (und Vor)teil den ich aktuell sehe: Dadurch dass der Pfad an die `$PATH` variable angehängt wird, wird hier zuletzt gesucht.
Wenn es sowohl ein NPM package als auch eine System Executable mit demselben Namen gibt, wird die Erste im Pfad, die aus dem System, genutzt.
Es passiert also nicht so leicht, dass etwas anderes passiert, als man erwartet.
Wenn also jemand ein NPM package `echo` baut und dies installiert, dann wird weiterhin die System `echo` genutzt.
Will man trotzdem das NPM package ausführen, sollte man dies manuell über `./node_modules/.bin/echo` ausführen.
Die Alternative wäre, den Pfad an den Anfang von `$PATH` zu stellen, dabei aber zu riskieren, dass Commands plötzlich etwas völlig anderes tun.

Ich weiß nicht, wie sich potenziell global installierte NPM packages verhalten, die außerdem noch lokal installiert sind.
Tendenziell wird weiterhin zuerst die global installierte Variante ausgeführt.
Ich persönlich vermeide allerdings global installierte NPM packages, werde es also so schnell auch nicht herausfinden.
Für mich sollte alles im jeweiligen Repository sein, es soll in sich vollständig sein und ohne großartig äußere Abhängigkeiten laufen, die nicht als dependencies gelistet sind.

Mit der Anpassung der `$PATH` Variable gibt es einen Weg, ohne `npx` oder viele Scripte in der `package.json` mit demselben Key und Value.
Und der Weg ist aus meiner Sicht auch noch simpler.

Was mich jedoch wundert:
Hat dieser Weg noch einen weiteren Nachteil, den ich nicht sehe?
Ansonsten würde dieser doch häufiger erwähnt werden?

# Edit 30.12.2020: Self Made 2.0

Beispielsweise `find` mit `-execdir` ist nicht begeistert über `$PATH` mit relativem Pfad.

Als Ersatz habe ich mir in der `.bashrc` (`.zshrc`, …) eine Funktion dafür gebaut (und die Anpassung aus der `$PATH` variable heraus geworfen):

```bash
function npx() {
  echo edjopato fixed npx
  seek=$1
  shift 1
  eval "./node_modules/.bin/$seek $@"
}
```

Wenn man nun `npx xo --fix` ausführt, so wird die eigens definierte Funktion ausgerufen.
Als Erstes wird das echo ausgeführt.
Dadurch sehe ich, dass das ganze auch wirklich noch funktioniert und nicht wieder auf das `npx` von `npm` leitet.
Danach wird das erste Argument (`xo`) als Variable `seek` gespeichert und alle darauf folgenden Argumente um 1 nach vorn geschoben (`shift`).
Am Schluss wird die Binary mit dem Namen von `seek` in besagtem `node_modules` Ordner versucht auszuführen.
Als Argumente dienen dazu die Argumente von unserer `npx` Funktion, abgesehen vom ersten (`xo`) welches ja bereits mit `shift` herausgeschoben wurde.

Diese Funktion ist ein guter Ersatz, welche seinen Job in 4 Zeilen Bash erfüllt, ganz ohne viele Dependencies.

# Edit 4.11.2021: Self Made 3.0

Mittlerweile bin ich wieder bei einer neuen Variante, da so etwas wie `npx nyc ava` nicht funktionierte.
Sowohl `ava` als auch `nyc` sind Executables aus dem `node_modules` Ordner und damit kommt man wohl nicht um eine Art der `$PATH` Benutzung herum.

```bash
alias npx='echo edjopato fixed npx again && PATH=$(pwd)/node_modules/.bin:$PATH'
```
