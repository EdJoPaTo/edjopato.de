---
title: Mal eben Videos und Sound bearbeiten
date: 2021-04-07T21:28:00+02:00
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - music
  - raspberry-pi
---
Ein Video welches man ohne Ton braucht?
Oder nur das Audio aus dem Video?
`ffmpeg` ist ein mächtiges Tool, was genau das kann, aber manchmal doch ein wenig kompliziert ist.
Um dies "mal eben" benutzen zu können, habe ich mir ein paar aliases definiert.
<!--more-->

Aliases sind Abkürzungen, welche man zum Beispiel in der `~/.bashrc` oder `~/zshrc` definieren kann.
Danach kann man diese Benutzen und die Shell wird den Alias austauschen gegen den vollen Command.
Man spart sich also Tipparbeit, oder wie in meinem Fall, ich muss mir nicht den gesamten Befehl merken.

[`ffmpeg`](https://ffmpeg.org/) ist ein Tool, welches so ziemlich jeden Video- (und Audio-) Codec in einen Anderen umwandeln kann, Videos verkleinern, kürzen, zuschneiden usw.
All dies passiert von der Command Line aus, was zum automatisieren von immer gleichen Abläufen super ist.
Für "immer mal wieder" Aufgaben ist FFmpeg jedoch sehr unübersichtlich.

Also habe ich mir hier aliases definiert, die ich einfach benutzen kann.

```bash
alias ffmpegGif='nice ffmpeg -v error -stats -an'
alias ffmpegSound='nice ffmpeg -v error -stats -vn'
alias ffmpegVideo='nice ffmpeg -v error -stats'
```

Dabei ist Gif im Sinne von "Video ohne Ton" gemeint, wird hier aber für zum Beispiel mp4 genutzt.

Diese kann man in seine `.bashrc` hinzufügen und dann wie folgt benutzen:

```bash
ffmpegGif -i "video.mp4" "out.mp4"
ffmpegSound -i "video.mp4" "out.mp3"
ffmpegVideo -i "video.mp4" "out.mp4"
```

Dabei ist das `-i` Argument der Input und am Ende steht der Output Pfad.

# Argumente erklärt

Soweit so gut, aber was genau tun diese Aliases?
Dazu kann man die man pages befragen.

`nice`: Das nice vor dem `ffmpeg` sorgt dafür, dass FFmpeg mit einer niceness von 10 gestartet wird.
Dies sorgt, in Kurzfassung, dafür das andere Prozesse eine höhere Priorität bekommen, als dieser "nette" Prozess.
Der Prozess teilt also gerne seine benötigte Rechenzeit, was grade auf schwächerer Hardware dafür sorgt, dass andere Prozesse weiterhin flüssig laufen, während `ffmpeg` arbeitet.

`ffmpeg`: Das Tool selbst

`-v error`: Der verbose Parameter wird auf 'nur Error' gesetzt, es wird also deutlich weniger auf die Ausgabe gepackt, was man meistens eh nicht sehen will.

`-stats`: Zeige während dem umwandeln an, wie weit der Prozess ist, wie schnell dieser ist und wie lange das Ganze etwa noch dauert.

Nun folgt die Unterscheidung der 3 Aliases.
`-an`, `-vn` oder weder noch.
Die bedeutet quasi "Video none" oder "Audio none", welches das Audio/Video aus dem Stream heraus nimmt und den Output ohne diesen speichert.
Der alias `ffmpegVideo` löscht also weder Audio noch Video.

# Input Internet

`ffmpeg` kann außerdem das Internet als Input verwenden.
Beispielsweise die m3u8 Streams, welche im Hintergrund für die meisten Streams im Internet genutzt werden, können von ffmpeg gelesen und als eine Video/Audio Datei gespeichert werden.

In [Raspberry Pi IPTV]({{< relref "/post/2018/02/05-raspberry-pi-iptv" >}}) gehe ich ein wenig darauf ein, wie man an so einen m3u8 Stream kommt.
Häufig ist aber [youtube-dl](https://ytdl-org.github.io/youtube-dl/) eine einfachere Hilfe.

# Fazit

`ffmpeg` ist zwar manchmal ein wenig komplex, aber mit den aliasen doch relativ entspannt benutzbar.
