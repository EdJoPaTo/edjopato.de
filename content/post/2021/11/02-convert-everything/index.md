---
title: Von alles nach alles konvertieren
date: 2021-11-02T17:28:00+01:00
resources:
  - name: cover
    src: skyline.jpg
    title: Abendlicher Himmel
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - photos
---
Manchmal braucht man Dateien in anderen Formaten.
Und dafür gibts ein paar mächtige Tools, die einem dabei helfen, von allen möglichen Formaten in alle möglichen Formate umzuwandeln.
Auf ein paar solcher Tools, die man immer mal wieder benutzt, will ich hier eingehen.

Es gibt dafür auch ganz viele Webseiten, wo man irgendwas hochladen könnte, aber so etwas will ich explizit vermeiden.
Meine Daten sollen schon noch bei mir bleiben.
Alle Tools, die ich anspreche, sind Command-Line-Tools welche in den gängigen Linux Distributionen und unter macOS mittels Homebrew verfügbar sind.
Wenn man beispielsweise 20 Dateien konvertieren will, baut man sich ein kleines Script mit den passenden Argumenten für den aktuellen Anwendungsfall und es läuft.

# Bilder mit ImageMagick

[ImageMagick](https://www.imagemagick.org/) wird an den meisten vielleicht schon mal als `convert` vorbeigekommen sein.
`jpg` nach `png` konvertieren ist dabei quasi noch der fast langweiligste Anwendungsfall den ImageMagick kann:

```bash
convert input.jpg output.png
```

Man kann (mit aktuellen Versionen) auch ausgefallenere Formate, wie das relativ neue Foto Format `heic` in das ebenfalls recht neue Format `webp` umwandeln:

```bash
convert input.heic output.png
```

In diesem Blogpost geht es zwar nur um das Umwandeln zwischen unterschiedlichen Formaten, aber ich will auch kurz auf weitere Features von ImageMagick eingehen, welche ich noch gern benutze.
So kann man beispielsweise die Größe eines Bildes verkleinern, damit man auf seiner Webseite nicht die volle Kamera Bildgröße hochladen muss (`-resize '2000x1000>'`).
Auch kann man die Metadaten wie der Ort des Bildes mal eben entfernen (`-strip`).
Die Argumente lassen sich natürlich kombinieren.
Das Zuschneiden oder Strecken, Wasserzeichen und noch viele weitere Dinge sind ebenfalls möglich.
Im Grunde kann `convert` vieles was ein Tool wie Gimp auch kann, nur eben automatisierbar auf der Command-Line.

Das Skript, welches ich aktuell für meine Fotos auf der Webseite verwende, sieht so aus:

```bash
convert input.jpg \
  -background black -alpha remove \
  -sampling-factor 4:2:0 \
  -strip \
  -resize '2000x1000>' \
  -quality 85 \
  output.jpg
```

# Bewegtbild und Ton mit FFmpeg

[FFmpeg](https://ffmpeg.org/) wandelt viele Medien um.
So kann man beispielsweise den Ton aus einem Video ziehen oder von einem Format in das andere umwandeln.
Ich habe darüber auch schon mal in einem [eigenen Post]({{< relref "/post/2021/04/07-ffmpeg-aliases.md" >}}) berichtet.

```bash
# Video
ffmpeg -v error -stats -i input.mp4 output.webm
ffmpeg -v error -stats -i input.avi output.mp4

# Video to Audio
ffmpeg -v error -stats -i input.mp4 output.mp3

# Audio
ffmpeg -v error -stats -i input.wav output.mp3
ffmpeg -v error -stats -i input.ogg output.mp3
```

Man kann auch zum Beispiel den Ton aus einem Video entfernen, um ein quasi `gif` zu erzeugen.
Das Argument `-an` steht dafür für "Audio none".

```bash
ffmpeg -v error -stats -an -i input.mp4 output.mp4
```

Zuschneiden oder Ausschneiden von Abschnitten aus einer Datei sind ebenfalls mit FFmpeg möglich.

# Textdokumente mit Pandoc

Das Erste, was mir bei [Pandoc](https://pandoc.org/) einfällt, ist das Diagramm auf deren Webseite, welches man sieht, sobald man ein wenig herunter scrollt.
Viele Formate in viele Formate.

LaTeX zu PDF oder Markdown zu HTML sind die langweiligsten Umwandlungen, die Pandoc kann.
`docx` zu Markdown, Markdown zu EPUB, EPUB zu HTML, HTML zu Open Document Text Format (`odt`), `odt` zu DokuWiki, DokuWiki zu MediaWiki, MediaWiki zu LaTeX, …
Was man halt gerade so braucht.

```bash
pandoc -o output.html input.docx
```

# SVG zu PNG oder PDF mit Inkscape

Vielleicht nicht mehr ganz so relevant, aber dennoch immer mal benötigt.
Ich arbeite ganz gern mit SVG, wenn es möglich ist.
Einfach, weil es kleinere Dateien und bessere Ergebnisse auf allen Auflösungen erzielt.
Manchmal braucht man jedoch altmodische Pixelgrafiken und LaTeX kann von Haus aus leider auch kein SVG.
Hier kommt [Inkscape](https://inkscape.org/) zu Hilfe, welches alle möglichen SVG Eigenheiten kennt und damit klarkommt.

```bash
inkscape input.svg -o output.png
inkscape input.svg -o output.pdf
```

# Und jetzt komme ich

Nachdem ich immer mal so etwas brauche wie "diese Bilder als jpg" und nicht immer eine kleine Bash Schleife bauen wollte, habe ich mir kleine Commands gebaut.
Diese waren jedoch nicht allzu gut konfigurierbar.
Daher habe ich mal irgendwann, ich wollte ja ein wenig mehr Rust lernen, eine [kleine Rust binary geschrieben](https://github.com/EdJoPaTo/EdC), die dies für mich abstrahiert.
Ich kann einfach `edc jpg --<tab>` eingeben und dann aus den Möglichkeiten auswählen, die ich gerade jetzt brauche.
Resize oder Strip beispielsweise.
Und dann eben die Inputs.
Die Outputs werden dann automatisch im neuen Unterorder `converted` erzeugt, welches Überschreibungen verhindert.

Natürlich fehlen dort immer Dinge.
Gerade wenn ich so diesen Blogpost schreibe, fällt dies besonders auf.
Aber das war ja auch der Zweck:
Immer mal ein Grund etwas mit Rust zu machen.

# Fazit

Vermutlich fehlen in dieser Liste noch ein paar coole Tools, um Dinge zu konvertieren.
Vielleicht fällt dir ja eines ein, dann bin ich neugierig, was bisher an mir vorbeigegangen ist und nehme diese gern hier mit auf!
