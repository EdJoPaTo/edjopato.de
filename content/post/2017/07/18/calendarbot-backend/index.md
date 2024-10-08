---
title: Das neue HAW HH Kalenderbot Backend
date: 2017-07-18T00:50:00+02:00
resources:
  - name: cover
    title: Blick aus dem HAW Fenster
    src: haw-raindrops1.jpg
categories:
  - open-source
tags:
  - calendarbot
  - container
  - haw-hamburg
  - server
  - telegram
---

Der HAW HH Kalenderbot [@HAWHHCalendarBot](https://t.me/HAWHHCalendarBot), ein von einer nicht unerheblichen Zahl von HAW Studenten genutzter Telegram Bot zur Erstellung eines personalisierten, abonnierbaren Kalenders, hat ein neues Backend.
Wie vielleicht einige mitbekommen haben, war das alte Backend vom Quellcode… nicht vorzeigbar.
Das hat sich nun mit einem neuen Backend geändert.

Begonnen wurde das alte Backend im ersten Semester als Tool zum Download von Unterlagen zu Vorlesungen unterschiedlicher Profs in einen gemeinsamen, geteilten Dropbox Ordner.
In dieses Tool wurde dann das Parsen von den Vorlesungsplan PDFs integriert.
So entstand ein Monolith an Funktionalitäten auf C# Basis.
![Vorlesungsplan PDF](veranstaltungsplan.png)

Jedoch hat sich in der Zwischenzeit einiges gewandelt:
Es gibt andere Wege um an die Veranstaltungskalender der HAW zu kommen, mein Hauptsystem und damit regelmäßiger Ausführort des Tools wurde von einem Windows System zu einem Linux System ([mono](https://www.mono-project.com/) hat gute Dienste geleistet) und die [HAW ownCloud](https://owncloud.informatik.haw-hamburg.de) hat das Downloaden der Vorlesungsinhalte überflüssig gemacht.
Außerdem störte mich das Erstellen der Kalender maximal 1 mal in der Stunde.
Ein etwas zeitgemäßeres, eventbasiertes Erstellen auf dem Server, auf dem auch die Kalender Dateien liegen, wäre angebracht.

Anfangs dachte ich über eine neue Implementierung des Backends mittels [Node.js](https://nodejs.org/) nach, womit auch der Telegram Bot selbst entwickelt wurde.
Jedoch finde ich für mich die Sprache C# komfortabler als Node.js und da seit noch nicht allzu langer Zeit mittels [.NET Core](https://dotnet.github.io/) auch C# auf Linux und macOS läuft, bot sich dies an.
Da die Container in der für [TTI]({{< relref "/post/2017/07/31/tti-fazit" >}}) genutzten Docker Swarm Umgebung gut liefen, wurde die Entscheidung gefällt, auch hierfür werden Docker Container genutzt.
Damit ist der Host vServer auch unabhängig von der genutzten Programmiersprache und kann leichter geupdatet werden, wenn nur die Container migriert werden müssen.
(Meine alte [EVE Seite](https://eve.3t0.de) lebt schon seit Jahren auf PHP, nicht gerade migrierfreundlich, aber nicht Tod zu kriegen… Definitely learned from that. Edit: It's dead, Jim)

Um von dem bisherigen Monolithen weg zu kommen, wurde die Architektur dreigeteilt: Der Telegram Bot wie bisher, der Downloader und der Parser.
Der Downloader lädt regelmäßig die aktuellen Kalender von den HAW Servern und stellt diese intern bereit.
Der Telegram Bot behandelt weiterhin die User Anfragen und erstellt daraus Config Dateien für die jeweiligen Nutzer.
Aus diesen UserConfigs werden dann vom Parser neue Kalender generiert.
Und das, sobald sich eine UserConfig oder ein Veranstaltungsplan ändert.
Der neue Kalender steht also innerhalb von wenigen Sekunden statt bis zu einer Stunde später.

Mehr Infos zum Bot findest du auf der [Website des Kalenderbots](https://hawhh.de/calendarbot/).
Interesse am Quellcode des neuen Backends? Im Gegensatz zum alten Backend ist dieses nun betrachtungswürdig und auf [GitHub](https://github.com/HAWHHCalendarBot/backend) bereitgestellt.
Noch ist das neue Backend nicht im Einsatz, zum neuen Semester wird dies aber passieren.

Ideen, Vorschläge oder Bugs? Melde dich in den Issues des zugehörigen Projekts in der [GitHub Organisation für den Kalender Bot](https://github.com/HAWHHCalendarBot) oder schreib mich bei Telegram an: [@EdJoPaTo](https://t.me/EdJoPaTo).
