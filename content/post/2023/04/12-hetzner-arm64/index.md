---
title: Performancevergleich von Hetzners neuen arm64 Cloud Servern
date: 2023-04-12T18:39:00+02:00
categories:
  - open-source
tags:
  - linux
  - raspberry-pi
  - rust
  - server
---
Hetzner hat heute neue arm64 Cloud Server vorgestellt.
Fand ich spannend, gleich mal geklickt und ein wenig Performance verglichen.

<!--more-->

Das ganze basiert auf alten Vergleichen, hauptsächlich auf [meinem Vergleich von Cloud Servern]({{< relref "/post/2021/05/28-cloud-performance/index.md" >}}) und [Rust auf Raspberry Pis]({{< relref "/post/2020/10/03-raspberry-rust-performance/index.md" >}})

Ich dachte mir am Anfang, IPv6 only wär schon cooler und spart 60 Cent, also hab ich mir den kleinsten ohne IPv4 geklickt.
Ich bin dann über mehrere IPv6 Problemchen gestolpert, was hier aber nicht das Hauptthema werden soll (zum Beispiel ist der Rust crates.io Index GitHub und damit IPv4 only. Ich habe dann `sparse-registry` benutzt, welches _manchmal_ IPv6 kann, daher habe ich Rust nightly verwendet.)

# Genutze Systeme

Ich habe ein paar Systeme genommen, welche gerade zur Hand waren.
Zum Beispiel habe ich gerade einen Pi 3 herumfliegen aber keinen 4er.

| Gerät | Architektur | CPU Model Name | Kerne | Threads |
| --- | --- | --- | --- | --- |
| Raspberry Pi 3 | aarch64 | Cortex-A53 | 4 | 4 |
| Hetzner CAX11 | aarch64 | Neoverse-N1 | 2 | 2 |
| Netcup VPS G8 | x86_64 | QEMU Virtual CPU version 2.5+ | 2 | 2 |
| Netcup RS G9 | x86_64 | AMD EPYC 7702P 64-Core Processor | 4 | 4 |
| NUC5i3 | x86_64 | Intel(R) Core(TM) i3-5010U CPU @ 2.10GHz | 2 | 4 |
| NUC7i7 | x86_64 | Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz | 2 | 4 |

# Rust compilieren

Damals im [Blogpost]({{< relref "/post/2020/10/03-raspberry-rust-performance/index.md" >}}) habe ich Raspberry Pis verglichen in dem ich Rust compiliert habe.
Dafür habe ich sowohl den Release Build (Multicore) und den "Sources haben sich geändert" Dev Build (Single Core) verglichen.

Lest gern den alten Blogpost noch mal, aber tldr:

```bash
git clone https://github.com/EdJoPaTo/meeting-countdown
cd meeting-countdown
git checkout 32e6619e8080e21447b3bf4952a5862149b510ec

# Anders als damals!
rustup override set nightly-2023-04-11

cargo build

# Dev
hyperfine 'touch src/main.rs && cargo build'

# Release
hyperfine 'cargo clean && cargo build --release'
```

| Gerät | Threads | Release Build | Dev Build |
| --- | --- | --- | --- |
| Raspberry Pi 3 | 4 | 114.792 s ±  0.506 s | 5.178 s ±  0.014 s |
| Hetzner CAX11 | 2 | 20.212 s ±  1.225 s | 785.7 ms ±  60.0 ms |
| Netcup VPS G8 | 2 | 29.997 s ±  0.790 s | 1.060 s ±  0.079 s |
| Netcup RS G9 | 4 | 11.981 s ±  0.474 s | 641.5 ms ±  60.3 ms |
| NUC5i3 | 4 | 18.032 s ±  0.117 s | 788.8 ms ±   7.4 ms |
| NUC7i7 | 4 | 9.340 s ±  0.318 s | 485.1 ms ±   3.0 ms |

# FFmpeg

Im anderen, anfangs erwähnten [Blogpost]({{< relref "/post/2021/05/28-cloud-performance/index.md" >}}) habe ich Cloud Server mittels FFmpeg Performance verglichen.
tldr:

```bash
wget -O /tmp/in.webm https://cdn.media.ccc.de/congress/2017/webm-sd/34c3-8710-deu-eng-Relativitaetstheorie_fuer_blutige_Anfaenger_webm-sd.webm

# Anders als damals: kürze Zeit und mehr /tmp und /dev/null um nicht Speicherabhängig zu sein
ffmpeg -y -v error -i /tmp/in.webm -c copy -codec:v libx265 -t 0:15 -f mp4 /dev/null'
```

| Gerät | Threads | libx264 | libx265 |
| --- | --- | --- | --- |
| Raspberry Pi 3 | 4 | 13.059 s ±  0.066 s | 190.486 s ±  0.400 s |
| Hetzner CAX11 | 2 | 2.611 s ±  0.056 s | 20.893 s ±  0.233 s |
| Netcup VPS G8 | 2 | 4.671 s ±  0.101 s | 11.099 s ±  0.186 s |
| Netcup RS G9 | 4 | 1.133 s ±  0.018 s | 2.860 s ±  0.055 s |
| NUC5i3 | 4 | 2.507 s ±  0.012 s | 5.950 s ±  0.031 s |
| NUC7i7 | 4 | 1.329 s ±  0.010 s | 3.003 s ±  0.026 s |

# Fazit

Für einen schnellen Vergleich ganz spannend, vermutlich sind die neueren netcup Generationen auch schneller als mein VPS G8, also vergleichbar?
Leider ist die h265 Encoding Leistung schlechter als bei x64 Servern, ansonsten lässt sich das aber definitiv sehen, vor allem wenn der Preis mit einbezogen wird.
Ganz zu schweigen von der Effizienz, die ich zwar selbst nicht direkt sehen kann, aber auch [deutlich besser](https://chaos.social/@manawyrm/110185490282227472) ist.

Eins muss sich aber auch definitiv bewusst sein, das arm64 nicht für alles funktionieren wird.
Rust oder Node.js sind beispielsweise ziemlich problemfrei, Deno ist schon nicht mehr ganz so entspannt und zum Beispiel ein Teamspeak Server wird nicht auf arm64 laufen.

Eigentlich will ich gern mehr Dinge auf arm64 Servern laufen lassen, mal schauen wie viel daraus wird.
Vermutlich wenn dann leider noch mit IPv4, auch wenn nicht alles davon von außen erreichbar sein müsste…
