---
title: Mehrere USB-C Netzteile an einem MacBook
date: 2020-01-17T14:10:00+01:00
resources:
  - name: cover
    title: USB-C Netzteile an der Hochschule. Mit bunten LEDs.
    src: usb-pd-charger.jpg
categories:
  - open-source
tags:
  - power-delivery
  - usb
---

Was passiert eigentlich, wenn man mehrere USB-C Netzteile an ein MacBook anschließt?
Wenn das in einem Gespräch aufkam, war die Antwort von allen bisher immer, mit meinem MacBook probier ich das nicht aus.
Da aber die Thunderbolt Displays, die Apple selbst empfiehlt, auch laden können und mehrere gleichzeitig benutzt werden können, muss es eine Lösung geben.

<!--more-->

Ich wollte immer noch nicht selbst ausprobieren, was passiert, habe mich also mal auf die Suche gemacht, ob es offizielle Informationen von Apple gibt.
Und diese gibt's auf deren Support Seite: [HT207097](https://support.apple.com/en-us/HT207097).
TLDR: Es wird immer nur ein Charger verwendet. Und zwar der mit der größten Leistung.

Ich im Gedanken, Notfalls geh ich gleich zum Apple Store, hab also mal losgelegt zu probieren.

# Verwendete Hardware

Um zu messen was wirklich passiert, habe ich das erstbeste Billig USB / USB-C Messgerät von AliExpress und ein TC66C benutzt.
Das TC66C wirkt zumindest deutlich genauer und zuverlässiger, das andere zeigt nicht so genaue Zahlen an (was aber nicht für die Genauigkeit sprechen muss).

Als Netzteile habe ich ein Aukey PA-D5 (63W 2 Port, 60W oder 45W + 18W) und ein Anker PowerPort Atom PD 1 (30W 1 Port) verwendet.
Die beiden verwendeten Kabel waren ein Anker PowerLine+ Kabel (rot, 90cm, USB-C 2.0, gemacht zum Laden) und ein Powerline II (schwarz, 90cm, USB-C 3.1, gemacht für Datenübertragung).
Mein MacBook ist ein 13" MacBook Pro von 2018, welches auf allen 4 USB-C Ports geladen werden kann.

Und aus jux noch ein no name USB-A 5V 2.1A Netzteil (11W) mit irgendeinem no name USB-A auf USB-C Kabel.

# Sidequest Innenwiderstände der Kabel

Da die beiden Kabel jeweils 90 cm lang sind, sollte der Innenwiderstand relativ ähnlich sein.
Das rote Kabel ist für Datenübertragung das schwarze zum Laden gemacht, von daher war meine Annahme, die Spannung am Ende des roten Kabels müsste höher sein → geringerer Innenwiderstand.
Um gleiche Messergebnisse zu haben, habe ich das Kabel angesteckt und kurz gewartet.
Damit ist die aufgenommene Leistung des MacBooks ähnlich und pendete sich auf etwa 15W ein (bei 20V).

Gemessen mit den beiden Messgeräten, jeweils am Anfang und am Ende war die Spannung am Anfang des Kabels etwa bei 20.23V.
Am Ende des schwarzen Datenkabels war die Spannung etwa bei 20.12V.
Am Ende des roten Ladekabels etwa bei 20.00V.

Größerer Spannungsabfall über dem Kabel bedeutet größerer Innenwiderstand.
Der Innenwiderstand des roten Ladekabels ist also entgegen der Erwartung höher / schlechter.

# Mehrere Charger am MacBook

Beide Kabel ans MacBook gesteckt, die Messgeräte jeweils am Netzteil Ende habe ich alle Kombinationen von Netzteil ausprobiert.

Das Macbook nimmt dabei immer das Netzteil, welches die größere Leistung hat.
Das jeweils kleinere Netzteil wird nicht mehr benutzt und wechselt auf 5V 0A.

Stecken grade 2 Kabel und man zieht eines heraus, wechselt das MacBook direkt auf das Andere ohne einen weiteren "wird geladen" Ton und ohne einen weiteren Hinweis in der Statusleise.
Der Wechsel passiert zuverlässig und "sofort", dabei wird nicht gemessen welche Leistung ein Netzteil tatsächlich bereit stellt, sondern wohl die Information, welches mittels Power Delivery Protokoll übertragen wird, benutzt.

Auch mit dem USB-A Netzteil und somit 3 möglichen Ladeströmen wird weiterhin immer das Größte verwendet, auch wenn dies kein Power Delivery Protokoll benutzt.
Es ist immer wieder witzig zu sehen, dass das MacBook auch mit den 5V "geladen" werden kann, sind in diesem Fall auch immerhin 11W.
(Verglichen mit den im Idle genutzten ~15W der PD Netzteile gar nicht so wenig)

# Fazit

Das MacBook verwendet die angeschlossenen, potenziell ladenden USB Verbindungen schlau und ein Besuch im Apple Store ist mir auch erspart geblieben, Laptop wurde nicht gegrillt.
Ich werd ab jetzt entspannter sein, was Ladegeräte am MacBook angeht.

Unabhängig davon ist Thunderbolt 3 weiterhin in der Lage alles bis hin zu PCIe zu tunneln, was zwar kein elektrisches, aber andere Sicherheitsbedenken rechtfertigt, was man da grade wirklich anschließen will.
