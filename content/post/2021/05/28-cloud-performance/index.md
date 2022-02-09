---
title: Vergleich einiger Netcup und Hetzner Cloud Server
date: 2021-05-28T17:55:00+02:00
resources:
  - name: cover
    src: water.jpg
    title: Elbwasser
tags:
  - linux
  - macos
  - raspberry-pi
  - server
---
Heute gab es ein Netcup Sonderangebot mit einem neuen Server, dem "Game Invader".
Geklickt und die Frage gestellt, wie schnell ist das Ding eigentlich im Verhältnis?
<!--more-->

Also hab ich mal ein paar Netcup / Hetzner Server herbeigezaubert, auf die ich Zugriff habe und mal [hyperfine](https://github.com/sharkdp/hyperfine) mit FFmpeg angeworfen.
In einem bestehenden Projekt von mir nutze ich regelmäßig FFmpeg, welches eine Weile alle Kerne auslastet, bis es fertig ist.
Klingt nach einem guten Vergleich, also los.
Den Command aus dem Tool genommen ~~und als Input den Das Erste Livestream verwendet.~~
(Das besagte Tool integriert auch noch Untertitel in die mp4, daher die dafür relevanten FFmpeg Argumente.)

Alle Tests gemacht und dann festgestellt, warte mal, ein Livestream muss auf die Daten warten, sprich IO Bottleneck.
Um die CPU zu vergleichen, muss eine neue Quelle her.
Also [ein Video](https://media.ccc.de/v/34c3-8710-relativitatstheorie_fur_blutige_anfanger) herunterladen und dieses von der Platte einlesen.
Gewählt wurde hier die 576p WebM Variante, damit FFmpeg auch wirklich zu h264 transcodieren muss.

Die verwendeten Server sind in grob 3 Gruppen aufgeteilt:

- Die ersten 3 Server sind mit dedizierten Kernen (Netcup "Root Server", Hetzner "dedicated vCPU")
- Danach folgen 3 Server sind mit virtualisierten, also geteilten Kernen (Netcup "vServer", Hetzner "default")
- Gefolgt von Raspberry Pis
- Und den Abschluss bildet "große" Hardware, welche auch nicht unbedingt Server sind, um einen Vergleich zu haben.

```bash
wget -O in.webm https://cdn.media.ccc.de/congress/2017/webm-sd/34c3-8710-deu-eng-Relativitaetstheorie_fuer_blutige_Anfaenger_webm-sd.webm
hyperfine 'ffmpeg -y -v error -i in.webm -c copy -c:s mov_text -codec:v h264 -t 0:30 out.mp4'
```

```plaintext
Netcup RS G8 4C
  Time (mean ± σ):      4.083 s ±  0.190 s    [User: 13.887 s, System: 0.302 s]
  Range (min … max):    3.794 s …  4.427 s    10 runs
Netcup RS G9 2C
  Time (mean ± σ):      5.345 s ±  0.148 s    [User: 9.471 s, System: 0.145 s]
  Range (min … max):    5.182 s …  5.673 s    10 runs
Hetzner CCX22 4C
  Time (mean ± σ):      3.388 s ±  0.174 s    [User: 11.653 s, System: 0.154 s]
  Range (min … max):    3.308 s …  3.881 s    10 runs

Netcup VPS G8 2C
  Time (mean ± σ):     11.957 s ±  0.379 s    [User: 21.568 s, System: 0.345 s]
  Range (min … max):   11.654 s … 12.962 s    10 runs
Netcup VPS G9 4C (Game Invader)
  Time (mean ± σ):      7.590 s ±  0.352 s    [User: 22.981 s, System: 0.379 s]
  Range (min … max):    6.932 s …  7.939 s    10 runs
Hetzner CX21 2C
  Time (mean ± σ):      7.900 s ±  0.512 s    [User: 14.514 s, System: 0.226 s]
  Range (min … max):    7.301 s …  8.588 s    10 runs

Raspberry Pi 4 4GB
  Time (mean ± σ):     16.072 s ±  2.201 s    [User: 47.944 s, System: 0.692 s]
  Range (min … max):   15.188 s … 22.281 s    10 runs
Raspberry Pi 3
  Time (mean ± σ):     39.570 s ±  3.544 s    [User: 130.186 s, System: 0.983 s]
  Range (min … max):   33.786 s … 42.944 s    10 runs
PinePhone
  Time (mean ± σ):     39.573 s ±  1.369 s    [User: 122.825 s, System: 2.461 s]
  Range (min … max):   37.770 s … 41.681 s    10 runs
Raspberry Pi 2
  Time (mean ± σ):     87.167 s ±  3.428 s    [User: 213.934 s, System: 2.190 s]
  Range (min … max):   83.336 s … 95.592 s    10 runs

i7-6700 @ 3.40 GHz 4C 8T (keine Grafikkarte)
  Time (mean ± σ):      1.950 s ±  0.015 s    [User: 11.172 s, System: 0.170 s]
  Range (min … max):    1.936 s …  1.988 s    10 runs
Macbook Pro 2018 i7 4C 8T
  Time (mean ± σ):      2.090 s ±  0.155 s    [User: 12.817 s, System: 0.325 s]
  Range (min … max):    1.841 s …  2.255 s    10 runs
NUC5i3 2C 4T (i3-5010U @ 2.1 GHz)
  Time (mean ± σ):      7.709 s ±  0.178 s    [User: 25.621 s, System: 0.398 s]
  Range (min … max):    7.514 s …  8.108 s    10 runs
```

Eine spannende Feststellung ist der Vergleich von Netcups G8 4C vs. G9 2C: eine Generation neuer mit halb so vielen Kernen und nicht allzu viel langsamer.
Hetzners 4C Server ist einen ticken schneller, kostet aber ein vielfaches.

Bei den virtuellen Kernen war ich etwas überrascht, wie viel weniger Leistung sie im Vergleich zu den dedizierten Kernen haben.
Meine Annahme war, dass der jetzt neue 4 Kern vServer zwischen dem G8 und G9 Root Server liegen müsste, er ist aber langsamer als Beide.
Man sieht auch deutlich die größere Streuung in den Ergebnissen.

Und um meine Eingangsfrage zu beantworten:
Von der CPU Leistung her kann der neue vServer den G8 4C Netcup Root Server nicht ablösen.
Aber deswegen ist er noch lange nicht schlecht.
Vor allem nicht für den Preis.

Und vielleicht muss ich mir mal ein kleines Skript bauen, um solche hyperfine Vergleiche mal eben auf einigen Raspberries und vServern ausführen zu können.
Der [Vergleich der Raspberry Pis]({{< relref "/post/2020/10/03-raspberry-rust-performance" >}}) war zumindest für mich ja auch recht eindrucksvoll, wie viel besser diese doch auch zwischen Pi 2 und Pi 4 geworden sind, obwohl alle 4 Kerne hatten.
