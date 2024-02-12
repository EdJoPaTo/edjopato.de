---
title: rain-brainz.de mit JPEG, kein AVIF, WebP oder JPEG-XL
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

[rain-brainz.de](https://rain-brainz.de) nutzte einige Zeit AVIF und JPEG statt dem [vorher verwendeten WebP]({{< relref "/post/2021/12/31/rain-brainz" >}}).
Mittlerweile nutze ich nur noch JPEG und bin sowohl von WebP als auch von AVIF weg.
Bisher schrieb dieser Blogpost, wie gut AVIF ist, mittlerweile bin ich aber anderer Meinung.
Dafür habe ich ein wenig die Dateigrößen und Unterstützung dieser verglichen und bin so bei meiner Entscheidung angekommen.
Da das Thema immer mal wieder aufkommt, welches Bildformat wie gut ist, habe ich meine Bildsammlung ausführlicher getestet und die Ergebnisse mal als Blogpost niedergeschrieben, damit alle etwas davon haben.

<!-- more -->

Edit 2023-01-30: Dieser Blogpost war Pro-AVIF und ist nun Pro-JPEG umgeschrieben worden.

# Welche Arten von Bildern

Das Hauptziel von [rain-brainz.de](https://rain-brainz.de) ist das Zeigen von großen, qualitativ gut aussehenden Bildern in einer web-tauglichen Form (`big`).
Auf der Übersicht sind kleine Vorschaubilder (`thumb`) zu sehen.
Außerdem gab es schon häufiger die Frage, die Bilder als Hintergrundbild oder so zu verwenden ([CC-BY-ND](https://creativecommons.org/licenses/by-nd/4.0/) oder mich fragen), also soll es auch eine Variante mit hoher Qualität als `download` geben.

Dafür habe ich die folgenden [ImageMagick](https://imagemagick.org/) Auflösungsreduzierungen verwendet:

- `thumb`: `-resize '450x400>'` (es kommt immer ein Bild heraus, welches in 450x400 passt und behält das Seitenverhältnis bei)
- `big`: `-resize '2000x2000>'`
- `download`: ohne Auflösungsverkleinerung

# Auswahl der Qualität des jeweiligen Bildformats

Je nach Zweck des Bildes haben sich einige Argumente für ImageMagick als gut für Qualität und Größe erwiesen.

Für die 4 Formate ([AVIF](https://en.wikipedia.org/wiki/AVIF), [JPEG](https://en.wikipedia.org/wiki/JPEG), [JPEG XL](https://en.wikipedia.org/wiki/JPEG_XL), [WebP](https://en.wikipedia.org/wiki/WebP)) habe ich versucht, nahezu die gleichen Parameter zu verwenden.
Allerdings werden einige Parameter je nach Format unterschiedlich interpretiert, was zu unterschiedlichen Ergebnissen führt.
Für den stumpfen Vergleich der Speichergrößen nehme ich erstmal die gleichen Parameter an.

## Quality

- `thumb`: `-quality 85`
- `big`: `-quality 85`
- `download`: `-quality 95`

[`-quality`](https://imagemagick.org/script/command-line-options.php#quality) bestimmt die Qualität des Ausgabebildes.
Die Zahlenwerte für dieses Argument sind zwar immer zwischen 0 und 100, ihr Wert ist jedoch abhängig vom jeweiligen Bildformat.
Daher sind diese Werte nicht unbedingt zwischen den Formaten vergleichbar.
Hier muss auch auf die optische Qualität des Bildes geachtet werden, ob einem das Bild im jeweiligen Bildformat bei gewählter Qualität noch gefällt.
WebP braucht beispielsweise eine höhere `-quality` als JPEG um ähnliche Bildqualität zu erhalten.

Vor meinem Wechsel habe ich WebP mit den Standardeinstellungen von `-quality` verwendet, also nicht explizit spezifiziert.
Dies scheint auf macOS 75 und auf Arch Linux 92 zu sein.
Die mangelnde Qualität der WebP Bilder war damals mein Hauptgrund mich nach alternativen Formaten umzusehen.
Da ich die Webseite rain-brainz.de normalerweise unter macOS erstellt habe, scheine ich `-quality 75` verwendet zu haben.
Hier in den Tests mit 85 oder 95 sind die Bilder definitiv besser als mit 75.
Allerdings ist ein WebP Bild mit 95 teilweise schlechter als ein JPEG Bild mit 85.

AVIF scheint standardmäßig eine `-quality` von 50 zu verwenden.
Für die meisten Bilder reicht hier auch 70 aus, teilweise lohnt sich aber eine Qualität von 85 schon.
Bei einigen Bildern ist weiterhin ein JPEG mit 85 qualitativ besser als ein AVIF mit 85.

## Subsampling

Bei JPEG habe ich zusätzlich das [Argument `-sampling-factor`](https://imagemagick.org/script/command-line-options.php#sampling-factor) verwendet ([Chroma Subsampling](https://en.wikipedia.org/wiki/Chroma_subsampling), deutsch: [Farbunterabtastung](https://de.wikipedia.org/wiki/Farbunterabtastung)).
Dabei wird sich die Farbwahrnehmung des menschlichen Auges zunutze gemacht, welches weniger Unterschiede in Farben als in Helligkeiten unterscheiden kann.
Hierfür nutze ich `-sampling-factor 4:2:0`.
Dies hat jedoch nur bei JPEG einen Effekt.
(Wenn es einen Effekt bei JPEG XL zu haben scheint, dann nutzt dein ImageMagick vermutlich JPEG statt JPEG XL)

## Weitere kleine Details zwischen den Formaten

Ein weiterer Unterschied ist die Unterstützung der Farbräume.
JPEG und WebP unterstützen nur 8-Bit Bilder, AVIF und JPEG XL unterstützen auch HDR und mehr als 8-Bit.

Die Argumente sind in einem Skript hinterlegt, welches auch für die folgenden Tests genutzt wurde, gerne [nachmachen](nachmachen.sh)!

JPEG XL war für mich unter macOS nicht zum Laufen zu bekommen, hier wurde immer JPEG benutzt.

# Speichergröße

Die 51 Ausgangsbilder sind aus meinen iCloud Fotos in maximal möglicher Qualität exportiert.
Ich habe sowohl als HEIF, JPG, TIFF und PNG exportiert, die Ergebnisse sind vernachlässigbar ähnlich in der Qualität und Dateigröße, minimal am kleinsten waren jedoch die aus TIFF erstellten Bilder.

Abgesehen von einigen wenigen Spiegelreflexkamerabildern sind die meisten Bilder mit iPhones gemacht (6, 8, 11 Pro, 14 Pro, letzteres teilweise in 48 MP).
Daher sind auch die Ausgangsbilder schon durch unterschiedliche Algorithmen gelaufen.

## Summe aller Bilder nach Typ / Format

Hierfür habe ich jeweils die Speichergrößen der Bilder eines Typs (zum Beispiel `big`) eines Formates (zum Beispiel `avif`) summiert.
So lassen sich die Typen untereinander vergleichen.
Zum Beispiel können sich Algorithmen unterschiedlich verhalten, wenn die Bilder besonders groß oder klein sind.

Insgesamt sind hier 51 Bilder betrachtet worden.

```plaintext
2,2M thumb.avif
2,0M thumb.jpg
4,5M thumb.jxl
1,7M thumb.webp
 29M big.avif
 27M big.jpg
 73M big.jxl
 21M big.webp
177M download.avif
210M download.jpg
336M download.jxl
161M download.webp
```

# Browser / Betriebssystem Unterstützung

Eine andere Betrachtung der Bildformate ist die Unterstützung dieser.
Dabei will ich aktuelle Browser auf halbwegs aktuellen Geräten unterstützen.
Wenn ich meine Bilder teile, sollen diese ja auch betrachtet werden können.

- [AVIF](https://caniuse.com/avif) ist vergleichsweise neu, wird aber von aktuellen Chromium, Firefox und Safari Browsern unterstützt.
  Safari unterstützt dies leider erst auf Geräten, die diesen Herbst ein OS Update gemacht haben (macOS 13 Ventura / iOS 16).
  Außerdem kann Safari noch kein [`image-set type()`](https://caniuse.com/css-image-set), um zu verstehen, dass AVIF genutzt werden könnte.
- JPEG steht außer Frage, das geht quasi schon immer und überall.
- [JPEG-XL](https://caniuse.com/jpegxl) ist sofort raus und wird von keinem Browser unterstützt. Es sieht auch nicht danach aus, als würde es demnächst unterstützt werden.
- [WebP](https://caniuse.com/webp) existiert schon etwas länger und wird damit überall gut unterstützt.

# Qualitätsparameter der Formate

Bei allen Formaten geht der `-quality` Parameter von 0-100, aber 80 ist nicht gleich 80.
So sieht beispielsweise ein WebP mit 90 weniger scharf aus als ein JPEG mit 80.
Wenn also 80 mit 80 verglichen wird, fehlt der Aspekt der Bildqualität komplett.

Ein weiteres Problem ist die jeweilige Kompression des Formats.
Bei vielen Bildern reicht beispielsweise eine AVIF Qualität von 75 um ähnlich gut wie ein JPEG mit 85 auszusehen.
Allerdings gibts auch die Ausreißer, die mit AVIF 85 immer noch nicht so gut aussehen, wie ein JPEG mit 85.
Die Entscheidung, welches `-quality` Level genutzt wird, ist also abhängig von den Bildern.
Will ich für den großteil oder für alle Bilder gute Qualität haben?
Reicht also 75 meistens oder gehe ich doch auf 85 bei allen Bildern?

# Fazit

WebP sieht am stärksten weichgezeichnet aus.
Es resultiert zwar hier in den kleinsten Dateien, erreicht dies aber auf Kosten der Qualität.
Wenn `-quality 95` benutzt wird, sehen die Bilder immer noch nicht so gut aus, sind aber größer als die JPEG mit 85.
WebP lohnt sich für mich also weder für Qualität, noch für Speichergröße.

AVIF ist vergleichbar mit JPEG in Größe und Qualität, tendenziell ein bisschen schlechter als JPEG in der Qualität.
AVIF kann für die meisten Bilder aber auch mit niedrigerer `-quality` benutzt werden, ist nur für meinen Anwendungsfall nicht so gut.
Im Vergleich zu WebP ist die Qualität aber besser bei leicht schlechterem Speicherverbrauch.,
Ich würde also AVIF über WebP bevorzugen, sobald AVIF weiter verbreitet und unterstützt wird.
Für meinen Anwendungsfall ist JPEG jedoch qualitativ besser bei gleichem Speicherverbrauch.

JPEG XL ist, da es eh nicht unterstützt wird, eher nur der Vollständigkeit halber dabei.
Die Konvertierung dauert am längsten, die Bilder werden am Größten, generell nicht das Format, welches mich weiter bringt.

Die anderen Formate neben JPEG (AVIF, WebP, JPEG-XL) haben alle auch noch den Nachteil der Unterstützung.
Im Idealfall kann der Browser bereits ein modernes Format wie AVIF, dann brauche ich nur für den Fall der Inkompatibilität ein anderes Format.
JPEG wird wirklich überall mit allem unterstützt, ist also das ideale Format für diesen Fall.

Da AVIF bei gleichem Speicherbedarf weniger gut aussieht, bevorzuge ich aktuell JPEG.
Würde ich weniger qualitativ hochwertige Bilder haben wollen, würde ich vermutlich zu AVIF tendieren, wenn alle Clients diese unterstützen.

Einziger Nachteil bisher für mich von JPEG: Ich verliere die HDR Bildqualität der iPhone 14 Pro Bilder.
Aber dafür funktionieren die Bilder überall mit einer guten Qualität.

HDR Randnotiz: Jeglicher iCloud Export, abgesehen von TIFF, scheint HDR auf 8-Bit Farbtiefe zu reduzieren.
Exportiere ich meine knapp 200 Bilder als TIFF habe ich hinterher 18 GB.
Die kann ich dann zwar in kleine AVIF und JPEG wandeln, wirkt aber trotzdem nicht nach dem richtigen Weg.
Von daher bin ich aktuell eher dabei, nur 8-Bit Farbtiefe zu nutzen.
