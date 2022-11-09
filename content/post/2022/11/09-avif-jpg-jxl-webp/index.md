---
title: rain-brainz.de mit AVIF und JPEG, aber ohne WebP oder JPEG-XL
date: 2022-11-09T19:37:00+01:00
categories:
  - open-source
tags:
  - command-line
  - ios
  - linux
  - macos
  - photos
  - web
  - website
---

[rain-brainz.de](https://rain-brainz.de) nutzt seit einiger Zeit AVIF und JPEG statt dem [damals verwendeten WebP]({{< relref "/post/2021/12/31-rain-brainz/index.md" >}}).
Dafür habe ich ein wenig die Dateigrößen und Unterstützung dieser verglichen und bin so bei meiner Entscheidung von AVIF und JPEG angekommen.
Da das Thema noch mal aufkam, welches Bildformat wie gut ist, habe ich meine Bildsammlung ausführlicher getestet und die Ergebnisse mal als Blogpost niedergeschrieben, damit alle etwas davon haben.

<!-- more -->

# Welche Arten von Bildern

Das Hauptziel von [rain-brainz.de](https://rain-brainz.de) ist das Zeigen von großen, qualitativ gut aussehenden Bildern in einer web-tauglichen Form (`big`).
Auf der Übersicht sind kleine Vorschaubilder (`thumb`) zu sehen.
Außerdem gab es schon häufiger die Frage, die Bilder als Hintergrundbild oder so zu verwenden ([CC-BY-ND](https://creativecommons.org/licenses/by-nd/4.0/) oder mich fragen), also soll es auch eine Variante mit hoher Qualität als `download` geben.

Dafür habe ich die folgenden [ImageMagick](https://imagemagick.org/) Auflösungsreduzierungen verwendet:

- `thumb`: `-resize '450x300^' -gravity Center -extent '450x300'` (es kommt immer ein 450x300 Bild heraus, egal welches Verhältnis das Bild vorher hatte)
- `big`: `-resize '2000x1500>'`
- `download`: ohne Auflösungsverkleinerung

# Speichergrößen

Je nach Dateiformat haben sich einige Argumente für ImageMagick als gut für Qualität und Größe erwiesen:

- [AVIF](https://en.wikipedia.org/wiki/AVIF): keine
- [JPEG](https://en.wikipedia.org/wiki/JPEG): `-sampling-factor 4:2:0 -quality 85` (download hat `-quality 95`)
- [JPEG XL](https://en.wikipedia.org/wiki/JPEG_XL): `-sampling-factor 4:2:0 -quality 85` (download hat `-quality 95`)
- [WebP](https://en.wikipedia.org/wiki/WebP): `-sampling-factor 4:2:0 -quality 85` (download hat `-quality 95`)

Das Argument `-sampling-factor` benutzt das [Chroma Subsampling](https://en.wikipedia.org/wiki/Chroma_subsampling) (deutsch: [Farbunterabtastung](https://de.wikipedia.org/wiki/Farbunterabtastung)).

Die 198 Ausgangsbilder sind aus meinen iCloud Fotos exportierte JPEG in maximal möglicher Qualität.
Ich habe sowohl als HEIC, JPG, TIFF und PNG exportiert, die Ergebnisse sind vernachlässigbar ähnlich in der Dateigröße.

Abgesehen von einigen wenigen Spiegelreflexkamerabildern sind die meisten Bilder mit iPhones gemacht (6, 8, 11 Pro, 14 Pro, letzteres teilweise in 48 MP).

## Summe aller Bilder nach Typ / Format

Hierfür habe ich jeweils die Speichergrößen der Bilder eines Typs (zum Beispiel `big`) eines Formates (zum Beispiel `avif`) summiert.
So lassen sich die Typen untereinander vergleichen.
Zum Beispiel können sich Algorithmen unterschiedlich verhalten, wenn die Bilder besonders groß oder klein sind.

Insgesamt sind hier 198 Bilder betrachtet worden.

```plaintext
 46M big.avif
119M big.jpg
 81M big.jxl
 98M big.webp
136M download.avif
742M download.jpg
500M download.jxl
595M download.webp
3.7M thumb.avif
7.6M thumb.jpg
5.8M thumb.jxl
6.7M thumb.webp
```

## Einzelne Bilder im Detail

Wer diese Tests nachmachen will, gerne [nachmachen](nachmachen.sh)!

Ein paar zufällig gewählte Bilder.
<https://rain-brainz.de/#57>
<https://rain-brainz.de/#173>

```plaintext
203k 57_big.avif
612k 57_big.jpg
414k 57_big.jxl
466k 57_big.webp
614k 57_download.avif
4,2M 57_download.jpg
3,0M 57_download.jxl
3,5M 57_download.webp
 19k 57_thumb.avif
 41k 57_thumb.jpg
 31k 57_thumb.jxl
 34k 57_thumb.webp
209k 173_big.avif
671k 173_big.jpg
436k 173_big.jxl
529k 173_big.webp
616k 173_download.avif
4,2M 173_download.jpg
2,6M 173_download.jxl
3,5M 173_download.webp
 18k 173_thumb.avif
 42k 173_thumb.jpg
 30k 173_thumb.jxl
 35k 173_thumb.webp
```

Ein Bild fast ausschließlich blau und das kleinste `big` Bild in der Sammlung.
<https://rain-brainz.de/#145>

```plaintext
6,7k 145_big.avif
 46k 145_big.jpg
 28k 145_big.jxl
 22k 145_big.webp
 18k 145_download.avif
278k 145_download.jpg
172k 145_download.jxl
130k 145_download.webp
1,1k 145_thumb.avif
6,3k 145_thumb.jpg
3,9k 145_thumb.jxl
3,1k 145_thumb.webp
```

Mein bisher größtes HEIC Bild (21.1 MB), welches in 48 MP mit dem iPhone 14 Pro aufgenommen wurde.
Da es sehr viel Kontrast mit den Ästen und dem Himmel dahinter hat, ist es auch nachvollziehbar, das Bildkompressionsverfahren damit Probleme haben.
<https://rain-brainz.de/#197>

```plaintext
753k 197_big.avif
1,3M 197_big.jpg
952k 197_big.jxl
1,2M 197_big.webp
5,7M 197_download.avif
 22M 197_download.jpg
 15M 197_download.jxl
 18M 197_download.webp
 41k 197_thumb.avif
 66k 197_thumb.jpg
 50k 197_thumb.jxl
 64k 197_thumb.webp
```

Ein frostiges Bild und das größte `big` Bild der Sammlung.
<https://rain-brainz.de/#114>

```plaintext
1,1M 114_big.avif
1,6M 114_big.jpg
1,1M 114_big.jxl
1,6M 114_big.webp
3,6M 114_download.avif
8,8M 114_download.jpg
6,5M 114_download.jxl
8,4M 114_download.webp
 36k 114_thumb.avif
 59k 114_thumb.jpg
 45k 114_thumb.jxl
 57k 114_thumb.webp
```

# Browser / Betriebssystem Unterstützung

Eine andere Betrachtung der Bildformate ist die Unterstützung dieser.
Dabei will ich aktuelle Browser auf halbwegs aktuellen Geräten unterstützen.
Wenn ich meine Bilder teile, sollen diese ja auch betrachtet werden können.

- [AVIF](https://caniuse.com/avif) ist vergleichsweise neu, wird aber von aktuellen Chromium, Firefox und Safari Browsern unterstützt.
  Safari unterstützt dies leider erst auf Geräten, die diesen Herbst ein OS Update gemacht haben (macOS 13 Ventura / iOS 16).
- JPEG steht außer Frage, das geht quasi schon immer und überall.
- [JPEG-XL](https://caniuse.com/jpegxl) ist sofort raus und wird von keinem Browser unterstützt. Es sieht auch nicht danach aus, als würde es demnächst unterstützt werden.
- [WebP](https://caniuse.com/webp) existiert schon etwas länger und wird damit überall gut unterstützt.

# Fazit

AVIF ist mit Abstand am besten, was den Speicherbedarf angeht.
Daher habe ich entschieden, die `big.avif` Variante sogar in `3000x2500>` bereitzustellen.
Das ist immer noch kleiner als JPEG, aber mit deutlich besserer Auflösung.

Aktuelle Browser nutzen die AVIF Bilder und haben bekommen die kleinsten Bilder.
(Außer Safari, denn selbst wenn AVIF unterstützt wird, [kann es kein `image-set type()`](https://caniuse.com/css-image-set) um zu verstehen, dass AVIF genutzt werden könnte.)

WebP und JPEG-XL sind zwar (minimal) kleiner als JPEG, haben aber ihre Nachteile mit der Unterstützung.
Im Idealfall kann der Browser bereits AVIF, also brauche ich nur für den Fall der Inkompatibilität ein anderes Format.
Damit nutze ich JPEG, das wird wirklich überall mit allem unterstützt.

Für die Downloads verwende ich aktuell nur JPEG und kein AVIF.
Damit verliere ich zwar potenziell die HDR Bildqualität der iPhone 14 Pro Bilder, dafür kann aber wirklich jede diese für sich als Hintergrundbild oder so nutzen ([CC-BY-ND](https://creativecommons.org/licenses/by-nd/4.0/) oder mich fragen).

HDR Randnotiz: Jeglicher iCloud Export, abgesehen von TIFF, scheint HDR auf 8-Bit Farbtiefe zu reduzieren.
Exportiere ich meine knapp 200 Bilder als TIFF habe ich hinterher 18 GB.
Die kann ich dann zwar in kleine AVIF und JPEG wandeln, wirkt aber trotzdem nicht nach dem richtigen Weg.
Von daher bin ich aktuell eher dabei, nur 8-Bit Farbtiefe zu nutzen.
