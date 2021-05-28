---
background:
  name: Set me
  style: url(/assets/2021/04/water.jpg)
date: 2021-05-28T17:55:00+02:00
lastmod: 2021-05-28T17:55:00+02:00
title: Vergleich einiger Netcup und Hetzner Cloud Server
tags:
  - intel-nuc
  - linux
  - macbook
  - raspberry-pi
  - netcup
  - hetzner
---
Heute gab es ein Netcup Sonderangebot mit einem neuen Server, dem "Game Invader".
Geklickt und die Frage gestellt, wie schnell ist das Ding nun eigentlich im Verhältnis?
<!--more-->

Also hab ich mal ein paar Netcup / Hetzner Server herbeigezaubert, auf die ich Zugriff habe und einfach mal [hyperfine](https://github.com/sharkdp/hyperfine) mit FFmpeg angeworfen.
In einem bestehenden Projekt von mir nutze ich regelmäßig FFmpeg, welches eine weile alle Kerne auslastet, bis es fertig ist.
Klingt nach einem guten Vergleich, also los.
Den Command aus dem Tool genommen und als Input nun den Das Erste Livestream verwendet.
(Das besagte Tool integriert auch noch Untertitel in die mp4, daher die dafür relevanten FFmpeg Argumente.)

Die verwendeten Server sind in grob 3 Gruppen aufgeteilt:
- Die ersten 3 Server sind mit dedizierten Kernen (Netcup "Root Server", Hetzner "dedicated vCPU")
- die mittleren 3 Server sind mit virtualisierten, also geteilten Kernen (Netcup "vServer", Hetzner "default")
- den Abschluss bildet reale Hardware, welche auch nicht unbedingt Server sind, einfach um einen Vergleich zu haben.

```bash
$ hyperfine 'ffmpeg -y -v error -i https://mcdn.daserste.de/daserste/de/master.m3u8 -c copy -c:s mov_text -codec:v h264 -t 0:05 out.mp4'

Netcup RS G8 4C
  Time (mean ± σ):      6.041 s ±  0.426 s    [User: 14.640 s, System: 0.419 s]
  Range (min … max):    5.485 s …  6.931 s    10 runs
Netcup RS G9 2C
  Time (mean ± σ):      7.469 s ±  0.721 s    [User: 9.932 s, System: 0.230 s]
  Range (min … max):    6.442 s …  8.795 s    10 runs
Hetzner CCX22 4C
  Time (mean ± σ):      7.359 s ±  0.264 s    [User: 19.618 s, System: 0.254 s]
  Range (min … max):    6.858 s …  7.838 s    10 runs

Netcup VPS G8 2C
  Time (mean ± σ):     15.418 s ±  1.553 s    [User: 23.780 s, System: 0.597 s]
  Range (min … max):   12.597 s … 18.249 s    10 runs
Netcup VPS G9 4C (Game Invader)
  Time (mean ± σ):      9.734 s ±  1.822 s    [User: 26.365 s, System: 0.533 s]
  Range (min … max):    7.691 s … 14.373 s    10 runs
Hetzner CX21 2C
  Time (mean ± σ):     13.572 s ±  0.704 s    [User: 21.520 s, System: 0.391 s]
  Range (min … max):   12.757 s … 14.991 s    10 runs

i7-6700 @ 3.40 GHz 4C 8T (keine Grafikkarte)
  Time (mean ± σ):      5.181 s ±  0.162 s    [User: 13.842 s, System: 0.258 s]
  Range (min … max):    5.035 s …  5.567 s    10 runs
Macbook Pro 2018 i7 4C 8T
  Time (mean ± σ):      7.562 s ±  1.859 s    [User: 14.312 s, System: 0.411 s]
  Range (min … max):    6.418 s … 12.652 s    10 runs
NUC5i3 2C 4T (i3-5010U @ 2.1 GHz)
  Time (mean ± σ):     11.415 s ±  1.473 s    [User: 23.930 s, System: 0.419 s]
  Range (min … max):    9.728 s … 14.213 s    10 runs
Raspberry Pi 4 4GB (im offiziellen Case = schlecht belüftet)
  Time (mean ± σ):     21.215 s ±  1.786 s    [User: 50.074 s, System: 1.397 s]
  Range (min … max):   18.953 s … 24.324 s    10 runs
```

Und quasi dasselbe, nur dieses Mal mit 30 Sekunden Dauer der Aufnahme statt 5 Sekunden.

```bash
$ hyperfine 'ffmpeg -y -v error -i https://mcdn.daserste.de/daserste/de/master.m3u8 -c copy -c:s mov_text -codec:v h264 -t 0:30 out.mp4'

Netcup RS G8 4C
  Time (mean ± σ):     29.257 s ±  2.489 s    [User: 89.029 s, System: 1.037 s]
  Range (min … max):   27.169 s … 34.641 s    10 runs
Netcup RS G9 2C
  Time (mean ± σ):     31.770 s ±  2.253 s    [User: 55.040 s, System: 0.623 s]
  Range (min … max):   28.885 s … 36.770 s    10 runs
Hetzner CCX22 4C
  Time (mean ± σ):     29.559 s ±  2.529 s    [User: 98.406 s, System: 0.607 s]
  Range (min … max):   26.986 s … 35.653 s    10 runs

Netcup VPS G8 2C
  Time (mean ± σ):     76.538 s ±  3.193 s    [User: 138.797 s, System: 1.432 s]
  Range (min … max):   71.654 s … 82.101 s    10 runs
Netcup VPS G9 4C (Game Invader)
  Time (mean ± σ):     45.283 s ±  3.294 s    [User: 155.461 s, System: 1.155 s]
  Range (min … max):   39.674 s … 50.988 s    10 runs
Hetzner CX21 2C
  Time (mean ± σ):     63.456 s ±  7.088 s    [User: 112.916 s, System: 0.880 s]
  Range (min … max):   52.658 s … 76.674 s    10 runs

i7-6700 @ 3.40 GHz 4C 8T (keine Grafikkarte)
  Time (mean ± σ):     27.933 s ±  0.987 s    [User: 70.766 s, System: 0.642 s]
  Range (min … max):   26.877 s … 29.204 s    10 runs
Macbook Pro 2018 i7 4C 8T
  Time (mean ± σ):     29.143 s ±  0.788 s    [User: 73.290 s, System: 1.144 s]
  Range (min … max):   27.744 s … 30.538 s    10 runs
NUC5i3 2C 4T (i3-5010U @ 2.1 GHz)
  Time (mean ± σ):     58.247 s ± 10.745 s    [User: 184.409 s, System: 1.696 s]
  Range (min … max):   41.672 s … 71.966 s    10 runs
Raspberry Pi 4 4GB (im offiziellen Case = schlecht belüftet)
  Time (mean ± σ):     124.327 s ± 18.627 s    [User: 404.029 s, System: 3.463 s]
  Range (min … max):   81.476 s … 150.211 s    10 runs
```

Eine spannende Feststellung ist der Vergleich von Netcups G8 4C vs. G9 2C: eine Generation neuer und quasi die gleiche Zeit mit halb so vielen Kernen.
Hetzners 4C Server hat eine ähnliche Zeit, kostet aber ein vielfaches.

Bei den virtuellen Kernen war ich etwas überrascht, wie viel weniger Leistung sie im Vergleich zu den dedizierten Kernen haben.
Meine Annahme war, dass der jetzt neue 4 Kern vServer irgendwo zwischen dem G8 und G9 Root Server liegen müsste, er ist aber langsamer als Beide.

Der Hetzner CX21 mit 2 virtuellen Kernen soll ebenfalls AMD EPYC verwenden, wie die G9 von Netcup, scheint aber ebenfalls nicht so schnell.

Und um meine Eingangsfrage zu beantworten:
Von der CPU Leistung her kann der neue vServer den G8 4C Netcup Root Server nicht ablösen.
Aber deswegen ist er noch lange nicht schlecht.
Vor allem nicht für den Preis.

Und vielleicht muss ich mir mal ein kleines Skript bauen, um solche hyperfine Vergleiche mal eben auf einigen Raspberries und vServern ausführen zu können.
Der [Vergleich der Raspberry Pis]({{< relref "../2020/10-03-raspberry-rust-performance.md" >}})  war zumindest für mich ja auch recht eindrucksvoll, wie viel besser diese doch auch zwischen Pi 2 und Pi 4 geworden sind, obwohl alle 4 Kerne hatten.
