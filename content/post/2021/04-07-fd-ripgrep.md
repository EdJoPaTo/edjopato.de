---
background:
  name: Kekse in Werkzeugformen
  style: url(/assets/2021/04/cookie-tools.jpg)
date: 2021-04-07T20:30:00+02:00
lastmod: 2021-04-13T18:11:00+02:00
title: Schnelle Suche in und nach Dateien in *nix Systemen
tags:
  - arch-linux
  - bash
  - command-line
  - debian
  - linux
  - macos
  - raspberry-pi
  - terminal
  - zsh
---
Wenn man mal eben etwas sucht… "Ich hab doch mal, wo war das noch?".
Für genau diesen Fall gibt es schnelle Command Line Tools die mir schon manchmal "mal eben" geholfen haben.
<!--more-->

Hierfür benutze ich `fd` und `ripgrep`, welche ihrerseits jeweils `find` und `grep` neu gedacht und verbessert haben.

# Gemeinsamkeiten beider Tools

Beide Tools arbeiten ganz ähnlich.
So nutzt man beide beispielsweise in ihrer einfachsten Form mit `<tool> <regulärer Ausdruck>`.
Die regulären Ausdrücke haben den Vorteil, mal eben auch die Features von diesen Nutzen zu können.
Allerdings muss man auch Dinge wie Klammern, wie man es in regulären Ausdrücken nunmal muss, escapen.

Eine andere Gemeinsamkeit ist das Beachten von versteckten und ignorierten Dateien.
Dies kann eine Suche ungemein beschleunigen.
Wenn ich Beispielsweise in einem Node.js Projekt etwas suche, dann suche ich für gewöhnlich in meinen Dateien und nicht in dem riesigen `node_modules` Ordner mit allen Abhängigkeiten, welcher mittels der `.gitignore` ignoriert wird.
Will man dies nicht, so kann man zusätzlich z. B. `--hidden` angeben, um diese doch zu durchsuchen.

Beide Tools arbeiten außerdem (wenn nicht anders per Argument übergeben) aus dem aktuellen Verzeichnis und dessen Unterordnern.
Will man den Ordner eingrenzen, so wechselt man einfach in diesen Ordner und führt den Befehl von dort aus.

# fd

[`fd`](https://github.com/sharkdp/fd), in Debian basierten Distros auch unter `fdfind` zu finden, hilft dabei Dateien anhand von Namen zu finden.
(Unter Debian basierten Distros habe ich mir einen alias angelegt: `alias fd=fdfind`.)

Suche ich beispielsweise Markdown Dateien und benutze `fd md`, so werde ich alle möglichen Markdown Dateien in Unterordnern aufgelistet bekommen.
Allerdings auch solche, die einfach nur md beinhalten, wie zum Beispiel `formdata.ts`.
Hier ist wieder der reguläre Ausdruck relevant.
`fd \.md$` führt hier an das gewünschte Ziel.

# ripgrep

[`rg`](https://github.com/BurntSushi/ripgrep) durchsucht Dateiinhalte auf den gesuchten regulären Ausdruck.

Steht man beispielsweise vor der Frage, wie genau der Befehl zum Hinzufügen von Paketen in alpine basierten Containern war, dann kann man `rg "RUN apk"` benutzen und wird alle Treffer finden.
Diese sind farbig hervorgehoben, nach Dateien sortiert und mit Zeilennummern versehen.

Vor einer derartigen Suche, beispielsweise mit der Suche oben rechts im Windows Explorer, graust es mir.
Auch macOS mit Bordmitteln setzt hierfür auf das Indexieren von Dateien, damit die Suche selbst schnell funktioniert.
`fd` arbeitet komplett ohne einen Index und durchsucht so beispielsweise alle Dateien in meinem gesamten Quellcode Ordner in 0,8 Sekunden. (Auf einer 5 Jahre alten SATA3 SSD, also keine übertriebene Hardware.)

Hier merkt man definitiv, dass das Ignorieren von versteckten und ignorierten Dateien Geschwindigkeit bringt.
Allerdings war bisher in mehreren Monaten Nutzung (`history`) auch nur das Suchen von Dateiinhalten im `.github` Ordner ein Grund, `--hidden` wirklich zu benutzen.
Ansonsten ist dieser Default wirklich nützlich für eine schnelle Suche.

# Fazit

Zwei schnelle Tools mit denen man wirklich "mal eben" Dinge finden kann, wenn man nicht genau weiß, wo diese sind.

In einigen Fällen sind die Basis Tools `find` und `grep` noch relevant, wie zum Beispiel `find` mit `-exec`, aber für das "mal eben" sind `fd` und `ripgrep` wirklich schnelle Helferlein.
