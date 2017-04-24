---
layout: post
title: Bildkomprimierung für das Web
date: '2017-04-24 17:00:00 +0200'
tags: kompression bilder svg png jpg gif
header: large
background:
  style: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0)),url(/assets/backgrounds/wl-hagel.jpg)
  color: '#999'
  is-dark: true
  name: 'Aprilwetter Winsen'
---
Um ein möglichst rundes Blog Angebot zu erstellen, versuche ich die Seitenladezeit so gering wie möglich zu halten.
Dazu vermeide ich zum Beispiel JavaScript und erstelle die Seiten vorher mit Hilfe von Jekyll.
Diese so erstellten, statisch Seiten lade ich dann hoch.
Ein Problem stellen große Bilder dar, da diese schnell relativ groß werden.
Um entgegen zu wirken, habe ich mir einige Dinge angewöhnt, um die Bilder auf meiner Website zu komprimieren.

(Ja, mich stört aktuell noch die das benutzte CSS Framework [Bulma](//bulma.io), da ich es aktuell komplett einbinde. Bulma bietet aber den Vorteil, nur Teile des Frameworks einbinden zu können. Muss ich in Zukunft mal machen.)

# SVG

Durch die abstrakte Darstellung von Formen anstatt der Speicherung mit Pixeln, lassen sich SVGs wesentlich kleiner speichern, als die meisten Bilder das können.
Voraussetzung dafür ist, dass sich die Bilder als abstrakte Formen darstellen lassen.
Mit den meisten Logos oder schematischen Darstellungen funktioniert dies.

Ein weiterer Vorteil ist, das die abstrakte Darstellung skalierbar ist.
So ist es egal, ob ein Oval auf einem kleinen Handydisplay oder auf einem 4K Monitor dargestellt wird, da das SVG zur Laufzeit auf die entsprechenden Pixel gerendert wird.

![Waves and Circles](/assets/backgrounds/waves-and-circles.svg)

"Waves and Circles" Quelle: [FreeVector](http://www.freevector.com/waves-and-circles)

Ein gutes Beispiel ist das aktuelle Hintergrundbild "Waves and Circles" der [Blog Übersichtsseite](/blog): Es besteht nur aus abstrakten Formen, wie Kurven, Kreisen oder Farbverläufen. Das SVG ist 44 kB groß. Als 800x600 PNG gespeichert benötigt es 176 kB (1300x1000 PNG benötigt 313 kB). Und man wird im SVG nie Pixel erkennen können.


## Von Rasterbild zu SVG

Wenn mir ein Logo als Rasterbild wie PNG/ JPG oder ähnliches vorliegt, dann nutze ich das [Inkscape](//inkscape.org) `Path -> Trace Bitmap…` Feature.
Inkscape versucht dabei, die Kanten aus dem zu Grunde liegenden Bild als Pfade zu erkennen.
Dies funktioniert besser, je höher die Auflösung des Bildes ist.
Danach kann das Original Bild aus der SVG entfernt werden.

Zur Optimierung kann man den Pfad teilweise noch mit `Path -> Simplify` vereinfachen oder mit `Path -> Break Apart` Pfade trennen, um einzelne, nicht benötigte Objekte zu entfernen.
`Edit -> Resize Page to Selection` passt dann die Bildgröße des SVGs an die noch vorhandenen Objekte an.

Dann speichere ich das SVG als "optimized SVG" und fahre mit SVGO (siehe weiter unten) fort.

## SVGs aus PDFs

Wenn ich beispielsweise Bilder aus den Vorlesungsfolien nutzen will, versuche ich die jeweilige Seiten der PDF als PDF zu drucken (quasi ausschneiden der jeweiligen Seite) und mit Inkscape zu öffnen.

Wenn die Objekte auf der Folie mit Formen aus PowerPoint oder LibreOffice Impress erzeugt wurden, dann sind diese auch in der PDF als einzelne, vektorisierte Objekte vorhanden und können direkt für die SVG benutzt werden.
Sind sie als Bilder in der PDF gespeichert, können diese, wie andere Rasterbilder auch, mit dem "Trace Bitmap" Feature konvertiert werden (siehe oben).

## Kompression von SVG Dateien

[SVGO](//github.com/svg/svgo) ist ein Tool zum Optimieren von SVGs. Da dies ein CLI Tool mit vielen Konfigurationsmöglichkeiten ist, die nicht auf jedes SVG gleich angewandt werden können, wurde das [SVGOMG](//github.com/jakearchibald/svgomg) (SVGO Missing GUI) Projekt ins Leben gerufen.
SVGOMG ist [hier](//jakearchibald.github.io/svgomg/) gehostet und kann direkt im Browser benutzt werden.
Alle Interaktionen passieren danach lokal im Browser.

Als Faustregel gilt, je mehr Optionen aktiviert sind und je kleiner die Genauigkeit der Nachkommastellen eingestellt ist, desto kleiner die Ausgabedatei.
Man muss allerdings darauf achten, das keine Elemente verschwunden sind oder falsch/ verzerrt dargestellt werden.
Dann muss die entsprechende Option gefunden werden, die das auslöst und deaktiviert werden.

SVGO sorgt gerne mal für über 50% Reduktion der Dateigröße.

## SVG Fazit

![Käsebild Avatar](/apple-touch-icon.png)

180x180 PNG Vorschaubild dieser Website

Als Beispiel kann ich mein Käsebild auf der Titelseite nutzen: Das SVG ist 731 Bytes groß.
Das favicon.ico oben in der Browser Tab Leiste dieser Seite ist 15,1 kB groß.
Die Vorschau PNG Bilder für Android/ Apple Geräte (180x180 3,5 kB; 192x192 3,5 kB und 512x512 8,5 kB) benötigen jeweils ein vielfaches des SVG Bildes an Speicherplatz.

Hinzu kommt, dass das SVG unabhängig der Bildschirmgröße scharf dargestellt wird.

# PNG/ JPG

Bei Rasterbildern kommt es darauf an, was das Bild darstellt. Ist es ein simples Bild mit wenigen, gleichen Farben, wie Schaugrafiken, dann bietet sich die Umwandlung in SVG oder das Speichern als PNG an.
Bilder mit vielen unterschiedlichen Farben, wie Fotos, sind eigentlich immer mit JPG kleiner speicherbar.

Generell achte ich darauf, die Bilder nicht mit zu großen Dimensionen zu Speichern. 2000x1000 Pixel hoch/ breit reicht für Hintergrundbilder völlig aus.
PNGs speichere ich mit [GIMP](//gimp.org) mit einer minimalen Farbpalette (`Image -> Mode -> Indexed…`).
Dazu sucht GIMP die n meist genutzten Farben und speichert das Bild komplett mit diesen Farben.
16 oder 32 Farben reichen für die meisten Schaugrafiken aus.
JPGs versuche ich mit niedriger Qualität zu speichern.
Dabei bewahre ich das Original auf, um bei möglichen Anpassungen das erneute Speichern von qualitätsreduzierten Bildern zu vermeiden.

Normalerweise benutze ich dafür immer ein Script, das mit Hilfe von [ImageMagick](//imagemagick.org) arbeitet: `convert "$filename" -resize '2000x1000' -enhance +dither -colors 256 -quality 90 "$target"`.
Mit diesem Skript wurde aus dem Aprilwetter Hintergrundbild (3,2 MB Originalgröße) ein 417 kB Bild (nur noch 13% des Speicherverbrauchs).

# GIF

Da GIFs eine Ansammlung aus Bildern darstellt, sind diese besonders groß. Da ich diese aber sehr selten verwende, habe ich damit noch nicht so viele Erfahrungen gesammelt.
Wenn benötigt, nutze ich [ezGIF](//ezgif.com/) und erreiche damit schon relativ große Erfolge.
Aber es geht sicherlich noch besser.

# Nautilus Scripts

Zum Bearbeiten von Bildern unter Linux mit Nautilus benutze ich [Nautilus Scripte](//github.com/EdJoPaTo/LinuxScripts/tree/master/Applications/NautilusScripts).
Hinweis: Funktioniert aktuell nur mit Dateien ohne Leerzeichen im Namen.
Bei Verbesserungsvorschlägen, fühl dich frei, einen Pull Request zu erstellen.

# Fazit

Mit Hilfe dieser kleinen Tricks kann ich den Speicherverbrauch um mehrere MB senken.
Zum aktuellen Zeitpunkt ist die Website 3,1 MB groß.
Davon sind 2,8 MB Bilder.
Zum Vergleich: Die Originalgröße des Hintergrundbildes dieser Seite beträgt 3,2 MB.

Ich hoffe, diese Tipps können dir helfen, ebenfalls schneller ladende Webseiten zu erstellen.
