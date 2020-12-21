---
background:
  name: Volle Luhe im Regen
  style: url(/assets/2020/09/wl-luhe-rain.jpg)
date: 2020-09-08T23:50:00+02:00
lastmod: 2020-09-08T23:50:00+02:00
title: Das stecken bleibende Internetradio entrosten
tags:
  - internet-radio
  - mpd
  - music
  - rust
  - raspberry-pi
---
Unter meinem Bett liegt [immer noch]({{< relref "../2018/08-08-mpd-pi.md" >}}) ein Raspberry Pi, der Internet Radio spielt.
Und MPD bleibt immer noch stecken, wenn das Internet weg war.
Mit einem kleinen Rust Programm habe ich mir nun Abhilfe geschaffen.
<!--more-->

# Das Problem

Wenn das Internet weg ist, wie es zum Beispiel bei einem tägllichen neu Verbinden des Internets der Fall ist (oder wenn der Provider Probleme hat…), dann bleibt MPD stecken.
Das Internet Radio wird einfach nicht weiter abgespielt, obwohl MPD 'playing' ist.
Schaut man sich mit dem `mpc` Command Line Befehl die Sache an, so stellt man fest, dass die aktuelle Zeit im Lied (für Internetradios die Zeit seit Beginn des abspielens) stehen bleibt.

```plaintext
$ mpc
[playing] #1/3 106:15/0:00 (0%)
$ sleep 2
$ mpc
[playing] #1/3 106:15/0:00 (0%)
```

In dem Beispiel kann man sehen, das nach 2 Sekunden Wartezeit die aktuelle Zeit immer noch gleich ist.

# Die Lösung

Da ich in letzter Zeit etwas angefangen habe, mit Rust zu programmieren (wovon hier im Blog leider noch nicht viel zu sehen ist…), dachte ich mir, dass man das Problem doch bestimmt mit einem kleinen Rust Tool lösen könnte.
Erster Gedanke war Regex und `mpc` Output parsen.
Nach einem Blick auf die crates (nutzbare Pakete) bin ich auf ein [MPD crate](https://crates.io/crates/mpd) gestoßen.
Das macht das ganze sogar noch einfacher.

Die Logik des Programmes ist relativ einfach:
Immer mal wieder schauen, in welchem Zustand MPD gerade ist.
Wenn MPD 'playing' ist und kein Lieddauer hat (im Beispiel oben 0:00), dann wird aktuell ein Stream wiedergegeben.
Ist dies der Fall wird kurz gewartet und erneut der Status abgefragt.
Ist es immer noch ein Internet Radio und ist die aktuelle Zeit gleich, ist MPD stecken geblieben.
Einmal stoppen und wieder starten verhilft hier zum Ziel, das Internet Radio läuft wieder.

Nun ist der Raspberry Pi unter meinem Bett ein Raspberry Pi 1B.
Nettes Teil, verbraucht wenig Strom, ist aber auch nicht der Schnellste.
Für Internet Radio aber locker ausreichend.
Also das Rust Projekt auf den Pi und bauen.
20 Minuten später war das Bauen fertig und ich habe das Tool als Dienst gestartet.
Mit dem Internet neu verbinden blieb MPD wieder hängen und das Tool hat dies erfolgreich behoben.

Noch ein paar Anpassungen gemacht, deutlich weniger Ausgaben auf die Konsole zum Beispiel und neu gebaut.
Ohne die Dependencies, die ja schon gebaut waren, brauchte der Raspberry Pi 1B dann nur noch etwa 80 Sekunden.

# Ressourcenauslastung

Nun verbraucht das Tool etwa 1.5MB RAM (0.4% des Raspberry Pi 1B) und hat in ~15h Laufzeit 5 Sekunden die CPU beansprucht.
Im Vergleich dazu ein NodeJS Tool, welches auf dem selben Pi läuft und LEDs von MQTT Nachrichten steuert: 18MB RAM (4.1%) und 13 CPU Minuten nach ~50 Stunden Laufzeit.
MPD selbst nutzt 10.6MB RAM (2.4%) und 3 CPU Stunden nach ~50 Stunden Laufzeit.

Ziemlich effizient zu Laufzeit, ein Grund warum ich Rust spannend finde.
Allerdings weiß ich nicht, wie viel dies den Ressourcenverbrauch von MPD selbst erhöht.

Insgesamt sind auf dem Raspberry Pi so etwa 45MB / 432MB RAM belegt.
Selbst wenn die Tools nicht so effizient wären, reicht der Raspberry Pi 1B für seinen Zweck locker aus.
Schade nur, das ARMv6 nicht mehr all zu gut supported wird (kein offizieller NodeJS Support mehr, Rust Cross Compilen für ARMv6 lief nicht so 'mal eben', daher weiter manuell vor Ort gebaut, …).
Grade im Anbetracht des noch gar nicht so alten Raspberry Pi Zero (W), der ja doch ganz gerne von Einigen für Projekte genutzt wird.

# Fazit

Internetradio läuft.
Der [Quellcode ist auf Github](https://github.com/EdJoPaTo/mpd-internetradio-destuck) zu finden.

Ein wenig witzig dabei ist immer noch, dass das Bauen der Executable auf dem Raspberry Pi 1B mit 20 Minuten gefühlt fast länger gedauert hat, als das Schreiben des Programmes.
Da ich da aber nicht daneben sitzen muss und in Anbetracht der echt guten Laufzeit Werte, definitiv verkraftbar.
