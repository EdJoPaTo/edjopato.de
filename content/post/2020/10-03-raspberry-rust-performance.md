---
background:
  name: Oktober Blumen im Luhepark
  style: url(/assets/2020/10/flower-red.jpg)
date: 2020-10-03T04:05:00+02:00
lastmod: 2020-10-03T04:40:00+02:00
title: Performance unterschiedlicher Raspberry Pis
tags:
  - intel-nuc
  - linux
  - macbook
  - netcup
  - raspberry-pi
  - rust
---
Ich hab mich gefragt, wie die unterschiedlichen Raspberries etwa vergleichbar sind in Performance.
Der Pi 2 und Pi 4 sind beides 4 Kerner, das sollte nicht soo viel Unterschied machen, oder?
Da ich aktuell mehr mit Rust mache, habe ich einfach mal eines meiner Rust Tools auf unterschiedlichen Geräten gebaut.
<!--more-->

Als Repo habe ich mein [Meeting Countdown](https://github.com/EdJoPaTo/meeting-countdown) Tool genutzt.
Das Projekt selbst ist vermutlich relativ egal, solange es auf allen Geräten das selbe ist.
In diesem Fall hat es 15 Dependencies und das Paket selber macht 16 teilweise parallelisierbare Kompilationen.

Um die Dauer des Bauens ohne Downloads zu ermitteln habe ich immer erst einmal `cargo build` laufen lassen, sodass alles herunter geladen ist.

Für den Release Build habe ich zwei Mal `cargo clean && cargo build --release` laufen lassen und das Ergebnis gemittelt.
Dabei unterschied sich das Ergebnis der Durchläufe erstaunlich wenig.
Selbst beim Raspberry Pi 1B war die Zeit nur 10 Sekunden auseinander.
Als Zeit habe ich die Zeit, die cargo selbst ausgibt verwendet.

Für den Dev Build habe ich erst `cargo build` ausgeführt, um das Projekt gebaut zu haben.
Danach habe ich mehrfach `touch src/main.rs && cargo build` ausgeführt und die Ergebnisse gemittelt.
Der Gedanke hierbei ist, dass man beim Entwickeln nur die Sourcen neu bauen muss, nicht alle Dependencies.
Sprich, wie lange es dauert, bis seine Änderung den Compiler Fehler aufzeigt.
Bei einem Release Build muss man nicht daneben sitzen, da ist einem die Zeit egal.
Beim Entwickeln interessiert die Zeit jedoch schon.

Man muss jedoch bedenken das dieses Projekt relativ klein ist, sowohl was das Projekt selbst als auch die Menge an Dependencies angeht.
Je mehr Dependencies ein Projekt hat, desto mehr Vorteile haben Multi Core CPUs.
Wird das Projekt selbst größer und hat mehr Source Code, hat eine gute Single Core Leistung Vorteile.

# Randbedinungen

Repo: `git clone https://github.com/EdJoPaTo/meeting-countdown`
(Commit: `32e6619e8080e21447b3bf4952a5862149b510ec`)

Release Build:
```sh
cargo build
cargo clean && cargo build --release
cargo clean && cargo build --release
```

Dev Build:
```sh
cargo build
touch src/main.rs && cargo build
touch src/main.rs && cargo build
```

Angaben zu der CPU ist immer mittels `lscpu` ermittelt.
Außname ist das MacBook.

Verwendet wurden folgende Versionen:
```
$ rustc --version
rustc 1.46.0 (04488afe3 2020-08-24)
$ cargo --version
cargo 1.46.0 (149022b1d 2020-07-17)
```

Die verwendeten Geräte sind mehr oder weniger zufällig gewählt.
Entweder sind die Geräte in meinem Besitz oder zum Zeitpunkt des Testens für Hochschulprojekte mir zugänglich.

# Vergleich

| Gerät | CPU Model Name | Kerne | Threads (Summe) | CPU max | Release Build | Dev Build |
| --- | --- | --- | --- | --- | --- | --- |
| Raspberry Pi 1B | ARM1176 | 1 | 1 | 700 MHz | 41m 13s | 21.35s |
| Raspberry Pi 2 | Cortex-A7 | 4 | 4 | 900 MHz | 3m 52s | 9.51s |
| Pine Phone 1.2b | Cortex-A53 | 4 | 4 | 1152 MHz | 2m 23s | 5.29s |
| Netcup RS G? (2014) | KVM | 1 | 1 | 2493 MHz | 2m 15s | 3.17s |
| Raspberry Pi 3 | Cortex-A53 | 4 | 4 | 1200 MHz | 2m 07s | 5.80s |
| Raspberry Pi 4 | Cortex-A72 | 4 | 4 | 1500 MHz | 1m 09s | 3.20s |
| Rock Pi 4B | Cortex-A53 | 2*3 | 6 | 1800 MHz | 1m 03s | 2.11s |
| Netcup VPS G8 | KVM | 2 | 2 | 2400 MHz | 52s | 0.84s |
| NUC5 | i3-5010U | 2 | 4 | 2000 GHz | 35s | 0.80s |
| Zenbook UX-31A | i7-3517U | 2 | 4 | 3000 MHz | 28s | 0.61s |
| Netcup RS G8 | KVM | 4 | 4 | 2095 MHz | 16s | 0.65s |
| NUC7 | i7-7567 | 2 | 4 | 4000 MHz | 14s | 0.40s |
| Macbook Pro 2018 | i7 | 4 | 8 | 2.7 GHz | 12s | 0.58s |
| Random Uni Server | i9-9980XE | 2*18 | 36 | 4500 MHz | 7s | 0.75s |

# Fazit

Der älteste Raspi 1B ist erwarteterweise der Langsamste, da dieser auch nur 1 Kern hat.
Spannend fand ich persönlich dass der Unterschied zwischen Raspberry Pi 2, 3 und 4 doch so groß ist.
Pi 2 benötigt, verglichen mit dem Pi 4, fast 4 mal so lange und der Pi 4 hat nur eine etwa 60% höhere Frequenz, weit ab von dem vierfachen.
Auch der Unterschied zwischen 2 und 3 bzw. 3 und 4 ist jeweils recht groß.
Für mich war der 3er beispielsweise bisher nur ein "etwas schneller und WLAN" Upgrade, keine fast Verdoppelung.
Leserkommentar: Auch der Sprung von Pi 1 zu 2 ist gewaltig: 4 fach Kerne aber 10 fache Release Build Dauer.

Interessanterweise waren Rock Pi und Raspberry Pi 4 beim Release nahezu gleich schnell, obwohl der Rock Pi sowohl eine höhere Frequenz als auch mehr Threads hat.
Beim Dev Build macht sich aber die höhere Frequenz bemerkbar.

Mein Hauptgerät, der NUC5i3 ist nicht der schnellste, beim Dev Build aber ganz passabel dabei.
Vielleicht würde es sich für das Entwickeln jedoch anbieten, auf mein MacBook zu wechseln.

Zwischenzeitlich war eine Idee, das [Bauen auf einem der Server zu machen]({{< relref "../2020/09-17-remote-debug.md" >}}), allerdings sieht man hier schon relativ gut, dass der Dev Build nicht wirklich schneller (oder sogar langsamer) ist.
Vielleicht bringt G(eneration) 9 der Server hier noch mal einen Benefit, ich habe aber aktuell keinen davon im Einsatz um diesen zum Testen zu nutzen.

Der 36 Threads Server an der Hochschule war interessanterweise sogar langsamer im Dev Build als andere Geräte, hat beim Release Build einfach durch die Menge an Threads schnell bauen können.
Hier hat auch das MacBook mit 8 Threads einiges Wett machen können.

Wenn ich auf einem ARM Gerät entwickeln wollen würde, würde ich zum Raspberry Pi 4 tendieren, da dieser auch generell viel Support bietet und nicht all zu teuer ist.
2 GB würden mir tendenziell reichen.
Hier bin ich noch gespannt, wie sich das PinePhone schlägt und wie gut man sogar auf den PinePhone Rust entwickeln kann.
Edit: Selbe CPU wie der Raspberry Pi 3 und etwas langsamerer CPU Takt: Vergleichbar mit dem Raspberry Pi 3.

Für ein x86_64 Gerät bieten sich wohl immer Geräte mit mehr Kernen an.
Im Dev Build ist die Single Core Performance wichtig, aber selbst das 8 Jahre alte Zenbook war hier gut dabei.
