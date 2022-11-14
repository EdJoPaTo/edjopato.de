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

- `thumb`: `-resize '450x300^' -gravity Center -extent '450x300'` (es kommt immer ein 450x300 Bild heraus, egal welches Seitenverhältnis das Bild vorher hatte)
- `big`: `-resize '2000x1500>'`
- `download`: ohne Auflösungsverkleinerung

# Auswahl der Qualität des jeweiligen Bildformats

Je nach Dateiformat haben sich einige Argumente für ImageMagick als gut für Qualität und Größe erwiesen.

- [AVIF](https://en.wikipedia.org/wiki/AVIF): keine (scheint standardmäßig `-quality 50` zu nutzen)
- [JPEG](https://en.wikipedia.org/wiki/JPEG): `-quality 85 -sampling-factor 4:2:0` (download `-quality 95 -sampling-factor 4:2:0`)
- [JPEG XL](https://en.wikipedia.org/wiki/JPEG_XL): `-quality 85` (download `-quality 95`; habe ich unter macOS nicht zum Laufen bekommen, nutzt immer JPEG)
- [WebP](https://en.wikipedia.org/wiki/WebP): `-quality 85` (download `-quality 95`)

[`-quality`](https://imagemagick.org/script/command-line-options.php#quality) bestimmt die Qualität des Ausgabebildes.
Die Zahlenwerte für dieses Argument sind zwar immer zwischen 0 und 100, ihr Wert ist jedoch abhängig vom jeweiligen Bildformat.
Daher sind diese Werte nicht zwischen den Formaten vergleichbar.
Hier muss auch auf die optische Qualität des Bildes geachtet werden, ob einem das Bild im jeweiligen Bildformat bei gewählter Qualität noch gefällt.
Für die rain-brainz.de Download Bilder verwende ich JPEG mit `-quality 95` und habe das für die Tests hier übernommen, außer bei AVIF.

Vor meinem Wechsel habe ich WebP mit den Standardeinstellungen von `-quality` verwendet, also nicht explizit spezifiziert.
Dies scheint auf macOS 75 und auf Arch Linux 92 zu sein.
Die mangelnde Qualität der WebP Bilder war damals mein Hauptgrund mich nach alternativen Formaten umzusehen.
Da ich die Webseite rain-brainz.de normalerweise unter macOS erstellt habe, scheine ich `-quality 75` verwendet zu haben.
Hier in den Tests mit 85 oder 95 sind die Bilder definitiv besser als mit 75.

AVIF scheint standardmäßig eine `-quality` von 50 zu verwenden.
Für wenige Bilder scheint AVIF hier etwas unvorteilhaft zu sein, im Großen und Ganzen lassen sich die Ergebnisse aber definitiv sehen.

Das [Argument `-sampling-factor`](https://imagemagick.org/script/command-line-options.php#sampling-factor) benutzt das [Chroma Subsampling](https://en.wikipedia.org/wiki/Chroma_subsampling) (deutsch: [Farbunterabtastung](https://de.wikipedia.org/wiki/Farbunterabtastung)).
Dabei wird sich die Farbwahrnehmung des menschlichen Auges zunutze gemacht, welches weniger Unterschiede in Farben als in Helligkeiten unterscheiden kann.
Dies hat jedoch nur auf JPEG einen Effekt.
(Wenn es einen Effekt bei JPEG XL zu haben scheint, dann nutzt dein ImageMagick vermutlich JPEG statt JPEG XL)

Ein weiterer Unterschied ist die Unterstützung der Farbräume.
JPEG und WebP unterstützen nur 8-Bit Bilder, AVIF und JPEG XL unterstützen auch HDR und mehr als 8-Bit.

Die Argumente sind in einem Skript hinterlegt, welches auch für die folgenden Tests genutzt wurde, gerne [nachmachen](nachmachen.sh)!

# Speichergröße

Die 198 Ausgangsbilder sind aus meinen iCloud Fotos exportierte JPEG in maximal möglicher Qualität.
Ich habe sowohl als HEIF, JPG, TIFF und PNG exportiert, die Ergebnisse sind vernachlässigbar ähnlich in der Qualität und Dateigröße, am kleinsten waren jedoch die aus TIFF erstellten Bilder.

Abgesehen von einigen wenigen Spiegelreflexkamerabildern sind die meisten Bilder mit iPhones gemacht (6, 8, 11 Pro, 14 Pro, letzteres teilweise in 48 MP).
Daher sind auch die Ausgangsbilder schon durch unterschiedliche Algorithmen gelaufen.

## Summe aller Bilder nach Typ / Format

Hierfür habe ich jeweils die Speichergrößen der Bilder eines Typs (zum Beispiel `big`) eines Formates (zum Beispiel `avif`) summiert.
So lassen sich die Typen untereinander vergleichen.
Zum Beispiel können sich Algorithmen unterschiedlich verhalten, wenn die Bilder besonders groß oder klein sind.

Insgesamt sind hier 198 Bilder betrachtet worden.

```plaintext
 34M big.avif
108M big.jpg
 72M big.jxl
 85M big.webp
117M download.avif
748M download.jpg
506M download.jxl
600M download.webp
2.8M thumb.avif
7.0M thumb.jpg
5.3M thumb.jxl
6.0M thumb.webp
```

## Einzelne Bilder im Detail

Ein paar zufällig gewählte Bilder.
<https://rain-brainz.de/#57>
<https://rain-brainz.de/#173>

```plaintext
144k 57_big.avif
554k 57_big.jpg
369k 57_big.jxl
399k 57_big.webp
500k 57_download.avif
4.2M 57_download.jpg
3.0M 57_download.jxl
3.5M 57_download.webp
 14k 57_thumb.avif
 37k 57_thumb.jpg
 28k 57_thumb.jxl
 31k 57_thumb.webp
150k 173_big.avif
607k 173_big.jpg
380k 173_big.jxl
432k 173_big.webp
505k 173_download.avif
4.2M 173_download.jpg
2.6M 173_download.jxl
3.5M 173_download.webp
 13k 173_thumb.avif
 38k 173_thumb.jpg
 27k 173_thumb.jxl
 31k 173_thumb.webp
```

Ein Bild fast ausschließlich blau und das kleinste `big` Bild in der Sammlung.
<https://rain-brainz.de/#145>

```plaintext
4.7k 145_big.avif
 44k 145_big.jpg
 26k 145_big.jxl
 21k 145_big.webp
 14k 145_download.avif
409k 145_download.jpg
248k 145_download.jxl
170k 145_download.webp
1.1k 145_thumb.avif
6.0k 145_thumb.jpg
3.7k 145_thumb.jxl
2.8k 145_thumb.webp
```

Mein bisher größtes HEIF Bild (21.1 MB), welches in 48 MP mit dem iPhone 14 Pro aufgenommen wurde.
Da es sehr viel Kontrast mit den Ästen und dem Himmel dahinter hat, ist es auch nachvollziehbar, das Bildkompressionsverfahren damit Probleme haben.
<https://rain-brainz.de/#197>

```plaintext
600k 197_big.avif
1.2M 197_big.jpg
854k 197_big.jxl
1.0M 197_big.webp
5.1M 197_download.avif
 22M 197_download.jpg
 15M 197_download.jxl
 18M 197_download.webp
 32k 197_thumb.avif
 59k 197_thumb.jpg
 44k 197_thumb.jxl
 57k 197_thumb.webp
```

Ein frostiges Bild und das größte `big` Bild der Sammlung.
<https://rain-brainz.de/#114>

```plaintext
829k 114_big.avif
1.5M 114_big.jpg
1.0M 114_big.jxl
1.5M 114_big.webp
3.3M 114_download.avif
8.9M 114_download.jpg
6.6M 114_download.jxl
8.4M 114_download.webp
 25k 114_thumb.avif
 51k 114_thumb.jpg
 40k 114_thumb.jxl
 50k 114_thumb.webp
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
