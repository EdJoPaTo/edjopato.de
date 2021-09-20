---
license:
  name: CC BY-ND 4.0
  url: https://creativecommons.org/licenses/by-nd/4.0/
date: 2021-09-20T12:34:00+02:00
lastmod: 2021-09-20T12:34:00+02:00
title: ISOs booten mit Ventoy
categories:
  - open-source
tags:
  - dd
  - etcher
  - unetbootin
  - usb-drive
---
Ventoy ist quasi ein Ersatz für das Beschreiben von USB-Sticks mit ISO Dateien [mittels Etcher und Co]({{< relref "../2017/08-20-etcher.md" >}}).
Das benutze ich schon seit einer ganzen Weile, immer dann, wenn man mal mit einem ISO an einen Rechner will.

Erstmal das warum, also wann brauche ich überhaupt ISOs auf einem USB-Stick?
ISOs sind CD-Images von denen man Booten kann (welche auch von einem USB-Stick aus funktionieren).
Mit diesen kann man dann ein Betriebssystem installieren (Windows, Linux, …), die Hardware testen oder auch mal Dinge retten oder seinen Bootloader fixen.
Das kommt immer mal wieder vor, aber definitiv nicht täglich.
Ich persönlich will dafür also eine relativ simple Lösung, bei der ich mir nicht jedes Mal wieder überlegen muss, wie genau das noch mal ging.

Wenn ich sonst eine ISO auf einen PC spielen wollte, dann habe ich den USB-Stick mit der ISO platt gemacht und hatte danach genau diese ISO darauf.
Das funktioniert zwar, ist aber nervig.
Tools wie Etcher oder [popsicle](https://github.com/pop-os/popsicle) vereinfachen das, es bleibt aber trotzdem immer ein „meh“.

[Ventoy](https://www.ventoy.net/) verfolgt dabei einen anderen Ansatz.
Ventoy wird einmal auf einen USB-Stick gepackt und dabei entstehen dann zwei Partitionen.
Eine große Leere und eine Kleine, in der Ventoy selbst liegt.
Die Kleine ist normalerweise versteckt und man sieht sie nicht.
Von ihr wird gebootet.
Das spannende ist nun die große Partition, welche man in unterschiedlichen Dateisystemen formatieren und seine ISOs einfach reinwerfen kann.
Unterordner und andere Dateien gehen auch.

Wenn man nun den USB-Stick mit Ventoy in einen PC steckt und davon bootet, gibt es eine Auswahl, welche ISO man booten will.
Das funktioniert zum Installieren oder zum Testen von Live Systemen vor der Installation.
Auch sein Arch Linux kann man mittels der Arch ISO wieder fixen, wenn man mal etwas viel ausprobiert hat.
Sogar Windows ISOs mit ihren Boot Eigenheiten werden unterstützt.
Es gibt wohl auch noch eine Erweiterung, um persistenten Speicher zu haben.

Das macht das Ganze sehr bequem.
Einmal installieren und dann vergessen.
ISOs einfach auf die Partition kopieren, wie mit normalen USB-Sticks auch und alle halbe Jahr gibts mal ein Update für die Ventoy Partition.

Für meine USB-Sticks verwende ich aktuell nur noch Ventoy und [ALMA](https://github.com/r-darwish/alma).
Für ein von einer externen Festplatte bootbares Windows (dieser Spielelauncher) verwende ich [Rufus](https://rufus.ie/).
Und halt das seltene FAT32 um irgendein BIOS zu aktualisieren.
Alles an Dateitransfers läuft über Netzwerk, da sind mir USB-Sticks zu nervig.
