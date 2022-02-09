---
title: Eigenes CLI Tool - project-below
date: 2022-02-09T02:00:00+01:00
resources:
  - name: cover
    src: teddy.jpg
    title: Ein weggeworfener Teddy im Baum
categories:
  - open-source
tags:
  - command-line
  - csharp
  - desktop
  - git
  - linux
  - macos
  - microcontroller
  - nodejs
  - rust
---
Ich habe einen Haufen Projekte in vielen Git Repositorys.
Da kommt es regelmäßig vor, dass ich Befehle in mehreren davon ausführen will.
Zum Beispiel ein `git fetch` in allen Git Repos oder ein `cargo doc` in allen Rust Projekten, wenn eine neue Rust Version herauskam.
Das habe ich bisher mit [`fd`](https://github.com/sharkdp/fd) / `find` und lustigen Bash Funktionen / Aliase realisiert.
Aus meiner Sicht funktionierte aber nur so mäßig gut.
Dafür habe ich jetzt ein kleines CLI Tool gebaut, welches auch mehr meiner Bedürfnisse abdeckt und auch noch deutlich schneller ist.
<!--more-->

## Wie benutze ich es?

Angenommen ich will in allen Node.js Projekten in Unterordnern `npm test` aufrufen.
Dafür muss ich eine Eigenschaft von einem Ordner kennen, der ein Node.js Projekt beinhaltet.
Ich nehme dafür an, dass eine Datei namens `package.json` darin existiert.
Und das wäre dann der Befehl mit `project-below`:

```bash
project-below --file=package.json npm test
```

Wenn ich häufiger einen Befehl in Node.js Projekten ausführen will, kann ich mir den vorderen Teil in einen Alias packen und so verkürzen:

```bash
alias npmBelow='project-below --file=package.json npm'
npmBelow test
```

Mit diesem Alias kann ich auch andere Befehle wie `npm install` in allen Unterordnern ausführen:

```bash
npmBelow install
```

So kann ich ganz unterschiedliche Arten von Projekten realisieren, indem ich die passenden Optionen für diese nutze:

```bash
alias gitBelow='project-below --folder=.git git'
gitBelow fetch

alias cargoBelow='project-below --file=Cargo.toml cargo'
cargoBelow check

alias pioBelow='project-below --file=platformio.ini pio'
pioBelow run

alias dotnetBelow='project-below --file="*.sln" dotnet'
dotnetBelow test
```

Das coole dabei, damit funktioniert auch Autovervollständigung von Befehlen.
Ich kann `gitBelow stat<Tab>` benutzen und es wird automatisch in `gitBelow status` vervollständigt.
Etwas das mit meinen vorherigen Funktionen mittels `find` / `fd` nicht funktionierte.

## Was habe ich vorher benutzt?

Bevor ich mein eigenes Tool dafür gebaut habe, habe ich mir mit kleinen Bash (bzw. in meinem Fall Zsh) Funktionen beholfen.
Wie man generell schnell nach Dateien oder Dateiinhalten sucht, habe ich bereits [in diesem Post]({{< relref "/post/2021/04/07-fd-ripgrep/index.md" >}}) mal beschrieben.
`gitBelow` war beispielsweise über `find` realisiert:

```bash
gitBelow() {
  find . -name ".git" -type d -print -execdir git --no-pager $@ \;
}
```

Das funktionierte ganz passabel, bot aber keine Autovervollständigung.
`npmBelow` ist aber so (zumindest mir bekannt) nicht generell möglich.
Wenn man annimmt, das ein Unterordner mit einer `package.json` ein Ordner ist, in dem man einen Befehl ausführen will, dann findet `find` eine ganze Menge im `node_modules` Ordner, was nicht gerade weiterhilft.
`fd` beachtet ignore Dateien (wie `.gitignore`) und versteckte Ordner, findet hier also die `package.json` der Dependencies nicht.
Allerdings kann (und will) `fd` aber keine Befehle in einen Unterordner ausführen, sondern nur den Pfad zum Treffer übergeben.
Für Tools wie `git` welches ein `-C` mitbringt, um beliebige Ordner anzunehmen, kein Problem, kann aber zum Beispiel `npm` nicht.
Hier kann man dann zum Beispiel eine Bash starten, welche zuerst mit `cd` in den Ordner wechselt.
Was auch immer ich hier tue, die Lösung wird spezifischer und komplizierter zu bauen.
Das würde für Unübersichtlichkeit in meinen [Aliasen](https://github.com/EdJoPaTo/LinuxScripts/blob/main/configs/zsh/aliases.zsh) sorgen, die ich gar nicht erst haben will.
Und das Anpassen von einem Skript auf zum Beispiel eine andere Programmiersprache wäre nervig.

So kam es zu meinem eigenen, kleinen Tool, welches diese Anforderungen erfüllt.

## Fazit

Das Tool funktioniert für mich nun schon seit ein paar Tagen und verrichtet erfolgreich seinen Dienst.
Auch zeigt es mir noch mal mehr auf, wie langsam `find` im Vergleich zu `fd` ist (`project-below` verwendet intern denselben [Filewalker](https://crates.io/crates/ignore) wie [`fd` und `ripgrep`]({{< relref "/post/2021/04/07-fd-ripgrep/index.md" >}})).
Meine Bash Funktion mittels `find` hat für meine 100+ Git Repos (`gitBelow status` zum Beispiel) mehrere Sekunden gebraucht.
`project-below` mit demselben Befehl braucht keine 100 ms.

Der [Quellcode ist auf GitHub](https://github.com/EdJoPaTo/project-below) zu finden.
Dort kann man auch die [fertig kompilierten Executables](https://github.com/EdJoPaTo/project-below/releases) herunterladen.
Vermutlich werde ich das Tool demnächst auch im [AUR](https://aur.archlinux.org/) bereitstellen.

Hast du Projekte die mit dem Tool noch nicht (so einfach) umsetzbar sind?
Dann kontaktier mich gern dazu (über einen der Wege unten im Footer).
Ich bin auch neugierig, was für das Tool noch hilfreich wäre, um für mehr Fälle eingesetzt werden zu können.

Ansonsten hoffe ich, dass es nicht nur mir im Alltag weiter helfen kann.
Wenn du Beispiele hast, wofür es noch hilfreich ist, füg diese gern im [Readme](https://github.com/EdJoPaTo/project-below#readme) über einen Pull Request hinzu!
