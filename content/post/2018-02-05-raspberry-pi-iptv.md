---
background:
  color: '#3c3c5c'
  is-dark: true
  name: HAW Hamburg Brücke zwischen BT5 und BT7
  style: url(/assets/backgrounds/haw-bridge-snow.jpg)
date: 2018-02-05T16:30:00+01:00
lastmod: 2018-08-07T20:30:00+02:00
title: Raspberry Pi IPTV
tags:
  - ard
  - daserste
  - dvb-t
  - iptv
  - kodi
  - libreelec
  - raspberry-pi
---
Seit vom vorläufigen DVB-T2 auf das "richtige" DVB-T2 umgestellt wurde, empfangen wir nur noch NDR.
Im Folgenden beschreibe ich meinen Weg, öffentliche Fernsehsender mit dem Pi auf den Fernseher zu bringen.
<!--more-->
Das ganze soll dabei auch für nicht Informatiker benutzbar sein.
Das ganze Einrichten mache aber ich ;)

# Raspberry Pi Image

Als Image für den Raspberry Pi fiel wieder ein XMBC Image ein.
Gibt's nicht mehr, XMBC heißt schon länger Kodi und als Image ist in [NOOBS](https://www.raspberrypi.org/downloads/noobs/) ist [LibreELEC](https://libreelec.tv/) enthalten.
Ich habe das Image direkt herunter geladen und auf eine SD Karte [gespielt]({{< relref "2017-08-20-etcher.md" >}}) anstatt über NOOBS zu gehen.

SD Karte einstecken, HDMI Kabel an den Fernseher, Strom dran, läuft.
Die Installation verläuft recht simpel, Namen festlegen, WLAN Daten eingeben und Kodi ist einsatzbereit.

Als zusätzliche Schritte, liegt aber am Fernseher, habe ich noch den Force HDMI Output aktiviert, damit Kodi immer HDMI nutzt, auch wenn kein Fernseher am gegenüberliegenden Ende erkannt wird.
Dazu muss in `/boot/` oder wenn man die SD Karte in den Computer steckt, einem der beiden "Laufwerke" die `config.txt` der Eintrag `hdmi_force_hotplug` auskommentiert werden und dann so aussehen:
```
# uncomment if hdmi display is not detected and composite is being output
hdmi_force_hotplug=1
```
Als Folge dessen muss noch in den Systemeinstellungen -> Ausgabe die Auflösung manuell auf die des Fernsehers (vermutlich 1920x1080) eingestellt werden, damit nicht automatisch etwas sehr kleines gewählt wird.

# Live Streams erhalten

Um die Live Streams zu erhalten habe ich Firefox (Version 58) benutzt.
Zuerst muss die Webseite des Streams geöffnet werden (Am Beispiel von "Das Erste" ist dies [daserste.de/live](https://daserste.de/live)).
Im Menü oben rechts kann nun unter Web Developer -> Network (Ctrl + Shift + E) der Netzwerk Tab geöffnet werden und danach muss die Seite neu geladen werden.
Im Netzwerk Tab sollte man zur Übersicht auf XHR schalten.

![ARD Livestream in den Firefox Developer Tools](/assets/2018/02/ard-live.png)

Danach muss man die Quelle des Streams finden, welche sehr Wahrscheinlich eine \*.m3u8 Datei ist.
In diesem Fall ist die erste geladene \*.m3u8 Datei die master.m3u8.
Wenn man auf diese klickt und sich bei Preview den Inhalt dieser anzeigen lässt, sieht man die weiteren URLs, die im weiteren Verlauf im Netzwerk Tab geladen werden.

Die so gefundene master.m3u8 URL (Rechtsklick -> Copy -> Copy URL) wird später gebraucht.
So kann für jeden Livestream von Interesse die URL gefunden werden.

Tipp: über diesen Weg kann man auch Livestreams in VLC schauen, in dem man diesen Link in VLC pasted.

# Live Streams mit dem Raspberry Pi abspielen

Der erste Gedanke war eine \*.strm Datei auf den Raspberry zu legen, die nur den Link zum Stream enthält, wie im folgenden Beispiel der (aktuelle) "Das Erste" Stream:
```
https://daserstehdde-lh.akamaihd.net/i/daserstehd_de@629196/master.m3u8
```
Funktioniert, aber man muss immer die jeweilige Datei aus dem Ordner öffnen, in die man die Dateien gelegt hat.

Der verbesserte Ansatz ist über das Kodi Add-on [IPTV Simple Client](https://kodi.wiki/view/Add-on:IPTV_Simple_Client).
Mit diesem Add-on können Internet Streams von einer entfernt liegenden Quelle importiert werden und über das TV Menü abgespielt werden.

Das Add-on wird im Add-on Menü unter PVR installiert und danach konfiguriert.
Dabei wird die URL einer \*.m3u Datei, die in meinem Fall auf meinem Web Hoster liegt, angegeben (für alle die Interesse haben, diese URL verwende ich: [https://edjopato.de/tv.m3u](https://edjopato.de/tv.m3u)).
(Tipp: Es hat ein bisschen gedauert, bis ich gemerkt habe, dass man das http bzw. https wirklich angeben muss, sonst geht da nichts.)
Außerdem kann man das Caching dieser Datei deaktivieren um sofort nach dem Neustart Änderungen dieser geladen zu haben.

Tipp: Die m3u Datei kann auch in VLC geöffnet werden oder der Link in VLC gepasted werden. So kann man auch mit VLC alle Livestreams der Liste schauen.

Wenn das Aufbauen der Verbindung zum WLAN länger braucht als Kodi zum Starten benötigt, kann es vorkommen, dass das Add-on keine Channel laden konnte und so das Fernsehen schauen nicht funktioniert.
Als Abhilfe kann in den Einstellungen von Kodi eine Option aktiviert werden, um Kodi erst zu starten, sobald eine Netzwerkverbindung besteht.

# Internet Verbindung

Wer eine begrenzte Internet Anbindung hat (wir haben hier 16 MBit/s), sollte während dem Fernsehen gucken wenig parallele Downloads laufen lassen.
Normale TCP Downloads verhalten sich fair gegenüber anderen Netzwerk Teilnehmern, aber andere Live Streams (Torrent, UDP) sind nicht mehr ganz so fair und sorgen für nicht wirklich schönes Fernsehen gucken.

Die meisten Download Manager bieten Möglichkeiten zur Drosselung (zu bestimmten Zeiten) an.
So kann Sonntag Abend, während der Tatort läuft, der Download auch mal langsamer laufen.
Auch hilft es die Anzahl der gleichzeitigen Downloads zu senken.

# Fazit

Eine entspannte Lösung, da bei Änderungen der Stream URLs nichts auf dem Pi angepasst werden muss, sondern nur die \*.m3u Datei auf dem Server angepasst wird.
Auch weitere Sender hinzufügen funktioniert so sehr simpel.

Und meine Mutter kann weiter Tatort gucken, alle glücklich ;)
