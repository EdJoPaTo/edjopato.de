---
title: Raspberry Pi Activity Leds abstellen
date: 2023-10-29T22:54:00+01:00
categories:
  - open-source
tags:
  - linux
  - raspberry-pi
---

Wenn ein Raspberry Pi unter meinem Bett liegt und als Musik Anlage dient, dann stört das Blinken der Status LEDs nachts.
Die LEDs lassen sich abstellen, das habe ich mal vor Jahren gemacht, aber nicht weiter dokumentiert.
Da ich nun gerade alle Raspberry Pis mit Debian 12 Bookworm neu aufgesetzt habe, ist auch mal an der Zeit, das zu dokumentieren.

Bei den Raspberry Pi außer den ersten A und B lässt sich das Verhalten der LEDs konfigurieren.
Das hat sich im Laufe der Jahre gewandelt und es gibt teilweise unterschiedliche Informationen dazu, was genau funktioniert.
Zusammenfassend aus den Internetfunden und der README ließ sich für mich eine ziemlich simple Lösung für die aktuellen Raspberry Pi OS Bullseye Images finden.

In der `/boot/config.txt` wird das Verhalten der LED Trigger umgestellt:

```plaintext
dtparam=act_led_trigger=panic
dtparam=pwr_led_trigger=panic
```

Die meisten Internetfunde stellen die LED Trigger auf `off`, invertieren LEDs oder ein Gemisch davon.
Scheinbar funktionieren die teilweise auch und scheinbar brauchten alte Versionen das auch, je nach Raspberry Pi Generation.
Mit aktuellen Images braucht es aber, soweit ich das mit unterschiedlichen Raspberry Pi jetzt getestet hatte, nur noch die Trigger Einstellungen.
Mit `off` passiert das erwartete.
In der mitgelieferten `/boot/overlays/README` steht ein wenig mehr, welche Trigger es gibt.
Der Abschnitt zu den `act_led` Einstellungen weiß wenig, weiter unten ist aber das `gpio-led` Overlay genauer beschrieben, welches wohl auch für die Activity LEDs gilt:

```plaintext
trigger  Set the led-trigger to connect to this LED.
         default 'none' (LED is user-controlled).
         Some possible triggers:
           cpu - CPU load (all CPUs)
           cpu0 - CPU load of first CPU.
           mmc - disk activity (all disks)
           panic - turn on on kernel panic
           heartbeat - indicate system health
```

Da mein Ziel in erster Linie "aus" war, wäre `off` naheliegend.
Die Beschreibung von `panic` klang aber noch sinnvoller als komplett aus, wurde gewählt und funktioniert.
Nicht das ich jemals eine Kernel-Panik auf einem meiner produktiv genutzten Raspberry Pi gesehen hätte.
