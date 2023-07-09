---
title: FFmpeg unter arm64 im Alpine Container schneller als unter Debian
date: 2023-07-09T17:15:00+02:00
categories:
  - open-source
tags:
  - command-line
  - container
  - linux
  - server
---

Mal eine kleine Erinnerung, dass es sich immer lohnt, Benchmarks zu machen, wo ich gerade selbst über etwas Unerwartetes gestoßen bin.
In diesem Falle wurde ich davon überrascht, das für FFmpeg Alpine Container scheinbar bessere Leistung auf arm64 Servern zu haben scheinen.

Die anfängliche Theorie war, das neuere FFmpeg Versionen schneller laufen könnten.
Aus Interesse, wie viel besser das so wird, habe ich das auf amd64 und auf arm64 laufen lassen.
Heraus kam, dass die neuen Versionen wenig bis gar nichts ändern, außer auf Alpine und arm64.
<!--more-->

Debian 12 Bookworm und Alpine 3.17 haben FFmpeg 5.1.3.
Debian Experimental und Alpine 3.18 nutzen FFmpeg 6.0.
lassen.
Debian 11 Bullseye hat hyperfine noch nicht in den Repos und wurde deswegen nicht in den Containern betrachtet.

Die gewählten Container Versionen wurden anhand der [FFmpeg Versionen in den Distros aus Repology](https://repology.org/project/ffmpeg/versions) gewählt.
[hyperfine](https://github.com/sharkdp/hyperfine) wurde zum Ausführen der Benchmarks benutzt.
Die Commands sind seit meinem [letzten arm64 Blogpost]({{< relref "/content/post/2023/04/12-hetzner-arm64/index.md" >}}) gleich geblieben.

## Benchmarks

Die meisten Unterschiede lassen sich als Messungenauigkeiten abtun, Alpine unter arm64 ist signifikant.

### System 1: Netcup RS G9 4 Cores, amd64

| | FFmpeg | h264 | h265 |
| -- | -- | -- | -- |
| OS: Debian 11 Bullseye | 4.3.6 | 1.153 s ±  0.030 s | 2.991 s ±  0.069 s |
| debian:bookworm | 5.1.3 | 1.232 s ±  0.052 s | 2.914 s ±  0.127 s |
| debian:experimental | 6.0 | 1.228 s ±  0.043 s | 2.890 s ±  0.067 s |
| alpine:3.17 | 5.1.3 | 1.122 s ±  0.032 s | 2.881 s ±  0.086 s |
| alpine:3.18 | 6.0 | 1.180 s ±  0.022 s | 2.982 s ±  0.132 s |

### System 2: Netcup VPS G8 2 Cores, amd64

| | FFmpeg | h264 | h265 |
| -- | -- | -- | -- |
| OS: Arch Linux | 6.0 | 3.735 s ±  0.096 s | 9.062 s ±  0.080 s |
| debian:bookworm | 5.1.3 | 3.818 s ±  0.114 s | 9.343 s ±  0.143 s |
| debian:experimental | 6.0 | 3.796 s ±  0.059 s | 9.194 s ±  0.092 s |
| alpine:3.17 | 5.1.3 | 3.687 s ±  0.056 s | 9.241 s ±  0.144 s |
| alpine:3.18 | 6.0 | 3.816 s ±  0.037 s | 9.307 s ±  0.099 s |

### System 3: Hetzner CAX31 8 Cores, **arm64**

| | FFmpeg | h264 | h265 |
| -- | -- | -- | -- |
| OS: Debian 12 Bookworm | 5.1.3 | 1.225 s ±  0.065 s | 10.834 s ±  0.298 s |
| debian:bookworm | 5.1.3 | 1.209 s ±  0.036 s | 10.481 s ±  0.180 s |
| debian:experimental | 6.0 | 1.112 s ±  0.017 s | 10.699 s ±  0.369 s |
| alpine:3.17 | 5.1.3 | 1.005 s ±  0.040 s | 8.251 s ±  0.200 s |
| alpine:3.18 | 6.0 | 987.6 ms ±  19.9 ms | 6.306 s ±  0.236 s |

## Fazit

Immer einmal mehr prüfen, wie das eigene System in der gewünschten Umgebung klarkommt und was optimiert werden kann.
Manchmal sind es nicht die erwarteten Dinge.

Rust compilieren dauert unter Alpine im Vergleich zu Debian beispielsweise etwa doppelt so lange.
Wie von der daraus resultierenden musl Executable die Laufzeit Performance ist, habe ich nicht ausprobiert.
Kommt sehr wahrscheinlich auf den Anwendungsfall und die Anforderungen an.
Mehr Benchmarks!
