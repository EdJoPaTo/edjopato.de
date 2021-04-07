---
background:
  name: Zweiter Schneeschauer bei einem Aprilspaziergang
  style: url(/assets/2021/04/april-weather.jpg)
date: 2021-04-07T22:23:00+02:00
lastmod: 2021-04-07T22:23:00+02:00
title: Raspberry Pi 4 als Hauptgerät
tags:
  - debian
  - desktop
  - linux
  - raspberry-pi
  - ubuntu
---
Ein Arbeitskollege hat alte Hardware entrümpelt und ich habe mir mal angeschaut, was man damit anfangen kann.
Einer davon war zwar noch 64bit, aber das war auch alles.
Da dachte ich, ein Raspberry ist doch besser als das.
<!--more-->

Ich habe den PC auch gleich mit meinem [Raspberry Pi Vergleich]({{< relref "../2020/10-03-raspberry-rust-performance.md" >}}) betrachtet und festgestellt, irgendwo zwischen Raspberry Pi 3 und 4.
Also ja, ein Raspberry Pi 4 ist besser als das.
Vor allem wenn man die Leistungsaufnahme von 160W im Idle von der alten Kiste mit betrachtet.

Den Raspberry Pi 1 hatte ich mal als Hauptgerät ausprobiert und wenn man wirklich nur einen Film (oder Staffel 1-4 Game of Thrones… ups?) schauen will, ging das (mit Kodi) erstaunlich gut, aber das war es eigentlich.
Darauf habe ich damals (vor ~5 Jahren) mir einen NUC5i3 zugelegt und benutze den seither als Hauptgerät.
Für Jitsi eignet sich der Pi 4 mit Raspbian nicht wirklich gut, kann man machen, aber Spaß macht das ganze nicht.
Jetzt gibt es aber schon ein wenig länger ein Ubuntu Image für den Raspberry Pi 4 und nach ein wenig benutzen zum Browsen dachte ich mir, läuft doch erstaunlich gut.

Meine Mutter wechselt aktuell zwischen einem Linux Desktop, einem älteren Linux Laptop und einem älteren Windows Laptop.
Sie ist also Kummer wechselnder Umgebungen gewohnt.
Nachdem ich sie gefragt hatte, habe ich sämtliche Kabel des Linux Desktops quasi in den Raspberry Pi 4 gesteckt.
DVI kann man mit einem Adapter auf HDMI und dann einem Adapter auf mini HDMI auch an den Raspberry Pi stecken und es funktioniert hinterher sogar.
(Nicht mit allen Monitoren, ein Monitor von denen, die ich getestet habe, funktionierte nicht. Allerdings funktionierte sogar die 2560x1440 Auflösung über DVI von meinen großen Monitoren.)
Und die Tastatur mit altem Tastatur Anschluss konnte man mit einem Adapter über USB anschließen.
Ein Glück hatte da ein gewisser Arbeitskollege grade entrümpelt und all solche Adapter waren plötzlich auch mein ;)

Wenn man den Strom der Steckdosenleiste nun an machte, gab es einen wesentlichen Unterschied:
Es blieb leise.
(Eigentlich alle Desktop Computer in diesem Haus schalten sich nach einem Power loss = Steckdosenleiste wieder einschalten automatisch an. Damit muss man nur die Steckdosenleiste an schalten und nicht noch am PC drücken.)
Der Raspberry Pi ist schließlich ohne Lüfter.
Beim Hochfahren sieht das ganze etwas anders aus, 4 Himbeeren hat der Desktop vorher schließlich nicht angezeigt. ;)
Auch dauert das mit dem Raspberry Pi definitiv länger.
Sobald das ganze erstmal läuft, geht alles zwar langsamer als mit dem Desktop, aber es geht relativ schnell.

Zwei Wochen später habe ich das ganze wieder zurück gebaut.
"Man kann sich zwar damit arrangieren, aber wenn man mit etwas schnellerem verwöhnt ist…"
Was ich im Grunde für eine spannende Feststellung halte.
Es gab nie irgendein Problem, dass ein Tool nicht auf ARM liefe.
Auch funktionierte das Ganze im Grunde auch.
Klar, meine Mutter macht auch nichts großartiges damit, Videokonferenzen, wie ich beispielsweise probiert hatte, braucht sie garnicht.

Alles in allem glaube ich, dass für wenig Bedarf so ein Raspberry Pi definitiv herhalten kann.
Für soetwas wie Videokonferenzen, wie sie aktuell ja an vielen Stellen genutzt werden, kann das Ganze zwar herhalten, aber Spaß macht das defintiv nicht.
Ich habe an der Stelle nicht probiert, was beispielweise mit Overclocking passiert.
Der [Raspberry Pi 400](https://www.raspberrypi.org/products/raspberry-pi-400/) arbeitet beispielsweise auch mit 1.8 GHz statt mit den 1.5 GHz des Pi 4.
Vielleicht reicht das ganze schon, sind schließlich 20% mehr.

Alles in allem bin ich mir aber fast sicher, dass ein kommender Raspberry Pi 5 an der Stelle eine brauchbare Desktop Alternative bieten kann.
Vor allem bei der Energieeffizenz.
