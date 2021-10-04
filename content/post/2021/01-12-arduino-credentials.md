---
title: Arduino/PlatformIO WLAN Zugangsdaten ablegen
date: 2021-01-12T10:20:00+01:00
background:
  name: Seltener Schnee
  style: url(/assets/2021/01/snowy-logs.jpg)
categories:
  - open-source
tags:
  - c
  - linux
  - microcontroller
  - secrets
  - wlan
---
Wenn man mit den ESP8266 oder ESP32 arbeitet, dann meistens, weil man das WLAN dieser Chips nutzen will.
Allerdings will man seine WLAN Zugangsdaten eigentlich nicht im Quellcode stehen sehen, der mal in öffentlichen Git Repos landet.
Auch nicht aus Versehen.

<!--more-->

Ein [Video von Andreas Spiess](https://www.youtube.com/watch?v=1pwqS_NUG7Q) brachte mich letztens auf die Idee, diese Daten einfach in einer Library zu hinterlegen.
Diese Library bleibt nur auf meinem Rechner und wird in die Projekte eingebunden, die solche Zugangsdaten benötigen. Damit bleibt der Quellcode komplett frei von Zugangsdaten und man committed diese nicht aus Versehen.

In meinem Fall hinterlege ich hier WiFi SSID und Passwort, sowie den Hostnamen von meinem MQTT Server.
Damit kann jeder die für sich benötigten Werte einbinden ohne meinen Code großartig anzupassen.

```h
#pragma once

#define WIFI_SSID "something"
#define WIFI_PASSWORD "different"

#define MQTT_SERVER "some-raspberrypi"
```

Damit die Arduino IDE diese Datei findet, habe ich sie unter `~/Arduino/libraries/Credentials/credentials.h` abgelegt.
Für PlatformIO war das nicht ganz so leicht zu finden, da die Libraries normalerweise abhängig vom Projekt sind und im Projekt liegen.
Hier kann der Pfad `~/.platformio/lib/Credentials/credentials.h` genutzt werden.
Ich persönlich habe einen Symlink erstellt:

```sh
ln -srf ~/Arduino/libraries/Credentials ~/.platformio/lib
```

Im jeweiligen Arduino / PlatformIO Projekt muss man jetzt nur noch diese einbinden und danach sind alle definierten defines verfügbar.

```c
#include <credentials.h>
```
