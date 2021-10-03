---
background:
  name: Neue Hamburger U-Bahn Station Elbbrücken
  style: url(/assets/2018/12/hh-elbbruecken.jpg)
date: 2018-12-23T02:35:00+01:00
title: iPhone Battery Health
tags:
  - apple
  - iPhone
  - battery
  - lithium-ion
---
Apple hat mit seiner Akku Drossel eine Menge negative Presse bekommen und das Battery Health Feature eingeführt.
Daraufhin habe ich einfach mal ein paar Freunde gefragt, "wie sieht es denn bei dir aus", und dies geplottet.
Das mache ich jetzt seit 8 Monaten und habe so schon ein paar interessante Verläufe zu sehen.
<!--more-->

# Der Plot

Auf der X Achse wird dabei das Alter des Akkus (nicht des Gerätes) in Monaten geplottet.
Auf der Y Achse wird die von iOS ausgegebene Battery Health in Prozent geplottet.
Die jeweilige Linie ist mit dem Alters des Akkus, der Art des Gerätes und dem Namen des Besitzers, irgendwie muss man ja auch den Überblick behalten, gekennzeichnet.

Da bis Ende 2018 der Akku Tausch noch deutlich günstiger ist, haben einige ihren Akku getauscht und sind so nun wieder "vorne" dabei.
Dabei ist ihr Name auch mehrfach vorhanden.

![Battery Age](/assets/2018/12/battery-age.svg)

# Beobachtungen

Man sollte das, was man hier sieht, mit Vorsicht genießen.
Es ist nur eine kleine Menge an Geräten / Akkus betrachtet worden, weswegen man nicht auf die Allgemeinheit schließen sollte.
Spannend ist es jedoch trotzdem.

Eine interessante Feststellung ist die Trichterform.
So benutzen Björn oder Christian S ihr Handy deutlich weniger und haben so deutlich weniger Ladezyklen als Fabian oder Wiebke.
Ganz extrem ist das mit den beiden iPhone 6 von Alma und Christian B zu sehen.
Christian B hat zudem das einzige iPhone, welches von Apple gedrosselt wird.

Was noch aufgefallen ist: Miro hat einen Sprung nach oben und wieder zurück gemacht.
Bug oder Feature? Unklar.

# Herangehensweise

Die Datensammlung und die Logik zum Generieren von Plots liegt in einem [GitHub Repo](https://github.com/EdJoPaTo/iPhoneBatteryHealth).

Die Daten werden in einer CSV Datei gesammelt.
Soll ein neuer Plot erstellt werden, wird mit Hilfe von NodeJS die CSV Datei eingelesen und passend für Gnuplot in temporäre CSV Dateien geschrieben.
Letztere liest dann das durch NodeJS gestartete Gnuplot und erstellt die Plots als PNG, SVG und PDF.

Wenn ich noch mal Langeweile habe, könnte man die Datenhaltung von CSV auf ein JSON Format ändern.
Damit ließen sich zum Beispiel genauere Zeitstempel als monatlich realisieren.
Aktuell können keine "Zwischenberichte" aufgeführt werden und zeitliche Verschiebungen werden auf den Monatsrhythmus "gedrückt".
Zusätzlich erschwert das CSV das Verfolgen eines Gerätes bzw. den Wechsel auf ein neues Gerät, da dies eine neue, unabhängige Zeile wird.
Dann wäre es auch einfacher, weitere Personen hinzuzufügen.

Auch ist das Erstellen von Plots über Gnuplot, angesteuert durch JavaScript, nicht so richtig optimal.

Schön wäre vielleicht auch noch das Setzen von Farben, basierend auf dem jeweiligen Gerät.
Zum Beispiel alle iPhone 7 in grün.

Aber da denke ich dann noch mal drüber nach, wenn ich mal wieder Zeit hab…
