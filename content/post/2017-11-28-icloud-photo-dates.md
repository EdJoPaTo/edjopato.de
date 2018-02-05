---
background:
  color: '#535652'
  is-dark: true
  name: Schmetterling in Bad Harzburg
  style: url(/assets/backgrounds/schmetterling.jpg)
date: 2017-11-28T23:32:00+01:00
lastmod: 2017-11-28T23:45:00+01:00
title: Alte Bilder korrekt in die iCloud Photos importieren
subtitle: Exif Datum berücksichtigen
tags:
  - apple
  - exif
  - icloud
  - ios
  - photos
---
Ich habe meine Fotos früher aus dem iCloud Photo Stream in die Dropbox und später auf meinen NAS gepackt, da ich nur 5 GB iCloud Speicherplatz hatte und diesen nicht erweitern wollte.
Mittlerweile habe ich diesen Schritt gemacht und wollte die alten Bilder wieder importieren.
Jedoch waren diese dann an völlig falschen Zeitpunkten im Photo Stream, obwohl das Exif Datum stimmte.
<!--more-->

# Datum im Photo Stream korrekt importieren

Der Sache auf den Grund gegangen, habe ich festgestellt, dass beim Import zwar die Exif Daten mit geladen werden, jedoch das Änderungsdatum der Datei ausschlaggebend für den Zeitpunkt im Photo Stream ist.
Kurz gesucht, ob es ein kleines Script für Linux (auf dem ich hauptsächlich arbeite) gibt und wurde [fündig](https://photo.stackexchange.com/questions/27245/is-there-a-free-program-to-batch-change-photo-files-date-to-match-exif):
Mit dem Befehl `jhead -ft *.jpg` lässt sich das Exif Datum auf die FileTime schreiben.
Diese Bilder dann importiert, landen an der richtigen Stelle im Photo Stream.


# Mein Import-Vorgang

- Bilder auf meinem Linux System in einem Ordner sammeln
- Mit dem oberen Befehl alle Dateiänderungsdaten auf das jeweilige Exif Datum setzen
- Mit [Transmit](https://itunes.apple.com/de/app/transmit/id917432930) die Bilder vom Linux Rechner (über SFTP) in die Photo Library laden
- Fertig
