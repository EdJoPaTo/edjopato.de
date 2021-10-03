---
background:
  name: Hamburger Landungsbrücken
  style: url(/assets/2018/08/hh-landingbridges.jpg)
date: 2018-08-08T23:40:00+02:00
title: Der Musik spielende Raspberry Pi
tags:
  - mpd
  - internet-radio
  - shairport-sync
  - raspberry-pi
---

Ich habe seit Ewigkeiten unter meinem Bett einen Raspberry Pi liegen, der Internet Radio abspielt und als Wecker dient.

Dies habe ich mit Volumio gemacht.
Eine kleine Distribution, nur dafür gemacht, Musik abzuspielen und bietet ein Web GUI um Musik auszuwählen und zu steuern.
Für mich war das aber viel zu viel, ich wollte mein eines Internet Radio abspielen und es vielleicht noch als AirPlay Target nutzen.

Außerdem wollte ich den Pi nutzen, um meine LEDs in meinem Zimmer zu steuern.
Dinge zusätzlich unter Volumio zum Laufen zu bringen ist spätestens bei Updates von Volumio problematisch, hat aber auch teilweise vorher schon zu Problemen geführt.
Unter anderem deaktiviert Volumio Dinge wie zum Beispiel cron um Energie zu sparen.
Diese muss man mühsam herausfinden und umstellen, um seine eigenen Dinge laufen lassen zu können.

Ein weiteres Problem ist der MPD, den Volumio nutzt, der bei einem Trennen der Internet Verbindung aufhört, Internet Radio zu spielen. (Fritz!Box macht das nachts automatisch)
Man muss das Abspielen stoppen und neu starten, damit er weiter spielt.
Da ich schon festgestellt hatte, das zusätzliche Dinge auf Volumio nicht grade entspannt sind, habe ich einen anderen, eh schon laufenden Pi genommen, der sich per SSH aufschaltet und neu startet.
Nicht grade schön, hat aber funktioniert.

# Meine neue Lösung

Um das ganze auf einem Pi laufen zu lassen, habe ich Raspbian installiert und wieder den MPD (und MPC) installiert.
Dieser verwendet eine Musik Datenbank in der Musikdateien und Playlisten sein können.
Für das Internet Radio habe ich eine Playlist im MPD Format erstellt und im richtigen Ordner (Command) abgelegt.
Nachdem man MPD die Datenbasis Einlesen lassen hat (Command), kann man die Playlist starten und das Internet Radio läuft.

## Internet Radio neu starten

Den Neustart des Internet Radios habe ich über einen systemd Service und Timer gemacht.
Der Service als oneshot startet den ersten Eintrag in der Wiedergabeliste, welches das Internetradio ist.
Der Timer führt den Service immer kurz nach 6 aus, da die Fritz!Box zwischen 5 und 6 Uhr das Internet neu verbindet.

Sollte das Internet anderweitig ausfallen, hört das Internetradio auf zu spielen und wird erst am nächsten morgen neu gestartet.
Das muss noch optimiert werden.
Für Vorschläge dafür gerne ein Pull Request im [Repo auf GitHub](https://github.com/EdJoPaTo/mpdPi).

## AirPlay Empfänger

Um von Apple Geräten Musik zu streamen, wird AirPlay verwendet.
Als Empfänger kann Shairport-Sync installiert werden.
Nach der Installation ist der Pi als AirPlay Empfänger direkt sichtbar.

Das Problem dabei ist jedoch, dass ohne weitere Einstellungen Internet Radio und AirPlay Stream gleichzeitig abspielen.
Dafür kann in der Shairport-Sync Config (Command) ein Command eingestellt werden, der ausgeführt werden soll, sobald ein Stream startet und ein Command, sobald ein Stream endet.
Verwendet man hier `mpc play` bzw `mpc stop`, spielt das Internet Radio nur noch, wenn kein AirPlay Stream aktiv ist.

## Lautstärke

Wenn man `mpc volume X` verwendet, wird die Lautstärke des Alsa Ausgabegerät verändert.
Dies sorgt dafür, das die AirPlay Lautstärke ebenfalls verändert wird.
Umgekehrt funktioniert dies nicht: die von AirPlay übertragene Lautstärke ändert nichts an der Alsa Ausgabegerät Lautstärke.

Die Lautstärke des Internet Radios will man normalerweise nicht aus der Ferne steuern, das läuft einfach.
Für AirPlay ist dies jedoch interessant.
Mein Ziel ist eine fixe Lautstärke für das Internet Radio und eine ähnliche Lautstärke bei 50% AirPlay Lautstärke.
Damit kann man über AirPlay lauter und leiser machen, ohne dies an den Lautsprechern / Musikanlage machen zu müssen.
Ohne weitere Einstellungen kommt dies jedoch nicht hin, das Internet Radio ist mit 100% lauter als AirPlay bei 50%.

Dies kann mit den Shairport-Sync Start und end Commands angepasst werden.
Neben dem Starten / Pausieren des Internet Radios kann hier noch die Lautstärke angepasst werden.

## Quellcode auf GitHub

Um das Ganze zu installieren habe ich ein [Repo auf GitHub](https://github.com/EdJoPaTo/mpdPi) mit install script erstellt.
Bei Verbesserungsvorschlägen gerne ein Isssue oder Pull Request stellen. :)

# Fazit

Die eigene Lösung kann auf einem bestehenden Pi installiert werden und bedingt keine spezielle Installation.
Andere Dinge können nebenher laufen, auch wenn man beachten muss, das das abspielen von Musik konstant Ressourcen benötigt.
So funktioniert meine Licht Steuerung auf dem selben Pi ohne Probleme.
