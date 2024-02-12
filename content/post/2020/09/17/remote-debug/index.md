---
title: Commands auf einem entfernten Gerät ausführen
date: 2020-09-17T14:37:00+02:00
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - nodejs
  - rsync
  - rust
  - server
  - typescript
---

Manchmal hat man den Bedarf, einen Befehl auf einem entfernen Gerät auszuführen.
SSH der Freund und Helfer.
Wenn ich jetzt zum Beispiel in einem Rust oder Node.js Projekt etwas testen will, sofür ich mehr Leistung brauche oder die bessere Netzwerk Anbindung, dann will ich dies auf dem Server ausführen und ausprobieren.
Allerdings liegt mein Quellcode noch lokal, muss also erstmal rüberkopiert werden.

<!--more-->

Mit einer Kombination aus rsync und SSH lässt sich das ganze relativ einfach realisieren.
Zuerst das lokale Projekt mit rsync auf den Remote schieben und dann den command über ssh ausführen und zuschauen, was passiert.

Der große Vorteil von rsync gegenüber zum Beispiel scp ist, dass man nur Dinge kopiert, die auf dem Remote noch nicht existieren.
Man kopiert also nicht immer alles.
Zusätzlich kann man die .gitignore und Git Dateien ignorieren, sodass nur die Sourcen übertragen werden.
Dann baut man auf dem remote und führt aus (`cargo run` mit Rust oder `npm start` mit Node.js).

Der folgende Code kann in die `.bashrc` oder ähnliches kopiert werden, dorthin wo auch deine alias Definitionen sind.

```bash
remotedebug() {
  # usage: remotedebug server command which should be executed
  # usage: remotedebug my.server.tld cargo build
  server=$1
  shift 1

  folder=${PWD##*/}
  remotefolder="tmp/remotedebug/$folder/"

  rsync --archive --cvs-exclude --exclude-from=.gitignore --verbose --checksum --rsync-path="mkdir -p $remotefolder && rsync" --delete-delay . $server:$remotefolder
  ssh -t $server "cd $remotefolder && bash -cl '$@'"
}
```

Hierbei wird der lokale Quellcode in einen gleichnamigen Ordner auf dem Remote kopiert und dort ausgeführt.
Wenn man also dependencies baut, kann man gleichzeitig mehrere Projekte haben, ohne das sich die Dependencies gegenseitig wieder löschen.

Vergleichbar dazu gibt es zum Beispiel auch [outrun](https://github.com/Overv/outrun) (weshalb ich auf die Idee kam, mal über meinen Ansatz zu schreiben).
Allerdings hat outrun den Nachteil, das es auf dem Remote installiert werden muss und Root Rechte braucht, um Dinge zu installieren.
Man kann zwar `outrun ffmpeg …` nutzen und FFmpeg wird direkt installiert, allerdings ist dies auch gleichzeitig ein Sicherheitsrisiko.
Meine Lösung funktioniert komplett ohne Root Rechte, solange die benutzten Tools alle installiert sind (SSH, rsync und die Eigenen, wie Cargo, Node.js, …).

Ein Vorteil von outrun gegenüber meiner Lösung ist allerdings, dass erzeugte Dateien danach automatisch auf den lokalen Rechner kopiert werden.
Benutzt man dies also zum Beispiel um ein Video neu zu encodieren, dann wird das Ergebnis direkt kopiert.
Meine Lösung hat so etwas nicht, hat aber auch einen leicht anderen Anwendungsfall.

Bedenken muss man über die Zeit auch, dass der `tmp/remotedebug` Ordner auf dem remote nicht automatisch aufgeräumt wird.
Man muss also von Zeit zu Zeit mal aufräumen.

Alle meine aliases findet man [hier auf GitHub](https://github.com/EdJoPaTo/LinuxScripts/blob/master/Applications/zsh/aliases.zsh).
