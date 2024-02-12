---
title: Strömekraft - Power Delivery in Netzteilen und portablen USB Akkus
date: 2021-06-20T19:14:00+02:00
tags:
  - battery
  - power-delivery
  - usb
aliases:
  - /post/2021/06/19-powerdelivery/
---

Wenn man Geräte laden will, dann braucht man Netzteile und mobile USB Akkus.
Diese verwenden häufig USB Power Delivery und mit der Zeit habe ich einiges darüber gelernt.
Wenn ich mir Geräte mit USB-C und Power Delivery anschaue, achte ich auf einige Details und möchte hier etwas auf die Hintergründe eingehen.

<!--more-->

# Was ist Power Delivery?

USB Power Delivery oder USB PD ist ein USB Standard, welcher Teil der für den USB-C Stecker vorgesehen Features ist.
Power Delivery funktioniert nicht für die "alten" USB-A oder USB-B Stecker.
Dabei wird, im Gegensatz zum altbekanntem 5V USB, eine Spannung ausgehandelt.
Das angesteckte Gerät kann nach einer bestimmten Spannung / Strom Konstellation fragen und wenn das liefernde Gerät diese bietet, bekommt es diese.
Die Idee hierbei ist, eine höhere Leistung (Watt) zu übertragen, ohne große Ströme (Ampere) zu haben.
USB PD 2.0 sieht als Spannungsprofile 5V, 9V und 15V bei maximal 3A und 20V bei bis zu 5A, wenn die Kabel dies erlauben (100W), vor.
USB PD 3.0 bringt als Neuerung das Feature PPS (Programmable Power Supply) mit.
Anfordernde Geräte können die Spannung auf 0.02V genau anfordern.

Power Delivery sieht hier auch das Drosseln der Datenübertragungsgeschwindigkeit vor.
Ist ein Kabel zu schlecht abgeschirmt und der Strom zu groß, wird automatisch von USB 3.0 Übertragungsgeschwindigkeiten auf USB 2.0 reduziert, um die Datenverluste zu minimieren.
Da Hersteller gerne billige Kabel mitliefern und die meisten Leute ihre Handys eh nur laden und keine Daten übertragen, werden in Handys meist nur USB 2.0 Controller verbaut.
Die schlechten Kabel würden eh auf USB 2.0 drosseln, USB 3.0 macht hier also wenig Sinn.

Kürzlich wurde EPR (Extended Power Range) als Spezifikation vorgestellt.
Hierbei können, bei passenden Kabeln, bis zu 50V 5A (240W) ausgehandelt werden.
Die Differenz von 50V · 5A = 250W zu den 240W sind vermutlich Übertragungsverluste.
Diese Spezifikation ist aber noch sehr neu und noch nicht verbreitet.

Ein weiterer Aspekt ist die Aushandlung.
Gehen wir mal von Netzteil und Laptop aus.
Steckt man den Laptop an das Netzteil, beginnt die Verbindung bei 5V 500mA.
Der Laptop fragt nun das Netzteil "kannst du Power Delivery 3.0?" welches das Netzteil beispielsweise verneint.
Daraufhin fragt der Laptop nach dem, aus der Sicht des Laptops, interessantesten Spannungsprofil.
Beispielsweise "kannst du 20V 5A" (100W)?
Wenn das Netzteil nein sagt, wird das nächste Spannungsprofil erfragt, bis das Netzteil das Angeforderte bieten kann.
Haben wir hier ein kleines Handy Netzteil mit 18W, so ist vermutlich das erste funktionierende Profil 9V 2A.

Mit diesem Wissen können wir jetzt auch verstehen, warum das Magnetische Qi Charging Pad von Apple mit 20W am Anfang bei so wenig Netzteilen funktionierte.
Netzteile mit haben für USB PD 2.0 fest einprogrammierte Spannungsprofile, welche meistens aufgedruckt sind.
Beispielsweise hat ein 60W Netzteil, welches ich besitze, folgende Spannungsprofile aufgedruckt: 5V 3A, 9V 3A, 12V 3A, 15V 3A, 20V 3A.
Vermutlich wird das Netzteil auch noch weitere Spannungsprofile haben, wie zum Beispiel 9V 2A, damit 18W Geräte funktionieren.
Apples MagSafe Charger benötigt allerdings 20W.
Bei den Spannungen 9V (12V) 15V und 20V sind 20W allerdings ziemlich krumm.
Apple verwendet hier das Spannungsprofil 9V 2.22A.
Selbst Apples eigenes 60W MacBook Netzteil antwortet auf die Frage "kannst du 9V 2.22A" sinngemäß mit "was hast du dir denn da für ne krumme Zahl ausgedacht?".
Scheinbar unterstützt der MagSafe Charger auch kein USB PD 3.0 und handelt damit auch nicht dynamisch aus, sondern muss die vorgegebenen Profile von PD 2.0 verwenden.
Damit funktioniert der MagSafe Charger bei quasi keinem Charger mit voller Leistung, der vorher hergestellt wurde, weil niemand mit solch einer krummen Zahl rechnen konnte und diese erst explizit einbauen muss.

Anmerkung nebenbei: Der MagSafe Charger kann durch seine gute Ausrichtung der Spulen sogar mit 20W Versorgung 15W Ladeleistung an das Handy bringen.
Das sind für Qi Charger vergleichsweise sehr gute 25 % Verlust.
Andere Qi Charger haben tendenziell 50 % Verlust.
Rechnet man das mal auf die Smartphones hoch, die allein die Deutschen besitzen, kommt man auf eine gewaltige Energieverschwendung nur durch Qi Charging Verluste.
Qi Charging ist für mich deswegen immer noch nichts.
Es ist eine Ressourcenverwendung.
Ich persönlich würde ja auch keinen Kuchen backen, bei dem die Hälfte des Kuchens der Abwärme des Backofens zum Opfer fällt…
Da backe ich den Kuchen dann lieber so, dass ich hinterher mehr davon habe. ;)
Und ein Kabel einstecken finde ich wirklich nicht so kompliziert.

# Galium Nitride (GaN)

Die Fertigung von Netzteilen mit Galium Nitride (GaN) statt Silizium bietet den Vorteil der höheren Effizienz bei größeren Strömen.
Die höhere Effizienz hat die Folge der geringeren Wärmeabstrahlung.
Weniger Wärme bedeutet weniger benötigte Kühlkörper und weniger Kühlkörper bedeutet kleinere und leichtere Netzteile.
Persönlich würde ich also immer versuchen, die effizienteren GaN Netzteile zu kaufen.

Galium Nitride hat vor allem Vorteile in Netzteilen, da diese größere Ströme leiten als beispielsweise andere Computerchips / Boards.
Das Gute an der Fertigung mit Galium Nitride sind die gleichen Maschinen, welche auch für die Fertigung mit Silizium benötigt werden.
Galium Nitride ist lediglich neuerer und damit unbekannter Rohstoff.
Es fehlt also vor allem an Erfahrung im Umgang damit, welches für siliziumbasierte Komponenten seit Jahrzehnten besteht.
Aber immer mehr Hersteller setzen so langsam auf GaN.

# Mehrere Anschlüsse

Netzteile und Powerbanks haben meistens mehrere Anschlüsse.
Die bekannten USB-A Ports mit 5V sind dabei relativ einfach herzustellen.
Man verwendet ein größeres Netzteil mit 5V 9A und baut 3 Ports parallel an.
Diese ziehen dann jeweils 5V und den benötigten Strom.

Mit Power Delivery und USB-C ist das nicht mehr ganz so einfach, da man unterschiedliche Spannungen nicht mehr durch das Parallelschalten der Ports erreichen kann.
Hier müssen also mehrere Netzteile in einem Gehäuse verbaut werden.
Häufig zu finden ist ein USB-C Port mit PD und mehrere USB-A Ports mit bekanntem parallel schalten der Ports.

Bei mehreren USB-C Ports wird es spannend.
Beispielsweise habe ich hier ein Netzteil, welches zwei USB-C Ports hat.
Dies kann auf einem Port 60W oder auf zwei Ports 45W + 18W.
Hierbei nutzt der Hersteller einen Trick.
Wenn nur der Haupt Port benutzt wird, dann werden beide Netzteile im Inneren zusammen geschaltet und liefern zusammen die 60W.
Werden beide Ports verwendet, laufen die beiden Netzteile im Inneren getrennt auf ihren eigenen Spannungen der jeweiligen Geräte.
Dieses Zusammenschalten der Netzteile im Inneren ist relativ komplex und ich habe dies bisher nur mit 2 USB-C Ports gesehen.
Meistens ist dabei auch ein Port als der Haupt-Port gekennzeichnet und nur dieser ist in der Lage, die große Leistung auszugeben.

Hier muss man bedenken, dass das Netzteil erkennen und darauf reagieren muss, sobald man ein zweites Gerät ansteckt.
Die Zusammenschaltung muss gestoppt werden und vor allem muss dafür gesorgt werden, dass das neue Gerät keine 20V ab bekommt, die es möglicherweise gar nicht abkann. (Magic smoke)
Der Ladestrom wird also kurz unterbrochen und beide Geräte handeln ihre Spannung mit dem jeweiligen Netzteil im Inneren aus.
Gleiches passiert, wenn das zweite Gerät wieder getrennt wird.

Ich würde mir Desktop Charger wünschen, die mehr als nur 2 USB-C Ports bieten.
Im Idealfall sollte es egal sein, welchen Port ich für eine hohe Leistung verwende und welche nicht.
Tendenziell kann es aber auch gerne kleine ≤ 30 W Ports und einen oder zwei mit mehr Leistung geben.
Geräte wie Handys oder eine Uhr haben eh nicht die Leistungsaufnahme, ein Laptop möglicherweise aber schon.
Und damit kommen wir auch zum nächsten Thema.

# Lithium-Ionen-Akkus

Warum können einige Geräte mit 18W, andere mit 60W und noch wieder andere mit 100W geladen werden?
Dafür müssen wir ein wenig auf die Grenzen von Lithium-Ionen-Akkus schauen.
Ein Akku ist verhältnismäßig klein und kann nur eine bestimmte Menge Energie zur Zeit aufnehmen oder abgeben.
Wird zu schnell zu viel Energie aufgenommen oder abgegeben, erhitzt sich dieser und wir bekommen einen Brand.
Da die Akkus mit 3.7V funktionieren und wir die Leistung begrenzen müssen, müssen wir also den Strom begrenzen, der in oder aus dem Akku fließt.

Schalten wir zwei Akkus parallel, können wir weiterhin jeden der beiden Akkus mit dem gleichen Strom laden.
Zusammen haben wir damit den doppelten Ladestrom.
Es hilft also für Ladegeschwindigkeiten mehr parallele Akku Zellen zu verwenden.

Ein weiterer Aspekt ist die Alterung der Akkus.
Laden oder entladen wir Lithium-Ionen-Akkus mit größeren Strömen, so altern diese schneller.
Wir wollen also tendenziell eher langsam laden/entladen.
Verwenden wir denselben Ladestrom, diesmal aber mit zwei statt einer Akkuzelle, wird jede der beiden Zellen mit dem halben Strom, also Akku schonender geladen.

Die Kapazität spielt hier ebenfalls eine Rolle.
Verwenden wir für unsere Aufgabe 5 Wh an Energie und beziehen diese aus einem 5 Wh Akku, so ist dieser hinterher 100 % entladen.
Ein großer 20 Wh Akku hat hinterher jedoch nur 25 % seiner Ladung verloren.
100 % Ladungsverlust (in Summe, man kann zwischendurch laden) ist ein Ladezyklus.
Man sagt, Lithium-Ionen-Akkus haben, je nach Bauweise und Größe, 500 - 1000 Ladezyklen, bis sie nur noch 80 % ihrer ursprünglichen Kapazität erreicht haben.
(Dabei muss man sagen, das 80 % immer noch nicht wenig ist. Meistens sind jedoch die 100 % schon knapp bemessen.)
Wenn wir also größere Akkus für die gleichen Aufgaben verwenden, sparen wir Ladezyklen.
Und da wir schon wissen, dass mehrere parallele Akkus sich auch schneller laden lassen, ist dies ein zusätzlicher Vorteil großer Akkus.
(Teslas SuperCharger funktionieren nur bei Teslas, weil alle Anderen zu kleine Akku Kapazitäten verbauen und damit mit den großen Ladeströmen nicht klarkommen.)

Umgekehrt bedeutet das aber auch: Kleinere Akkus laden langsamer oder altern schneller bei gleichem Verbrauch.
Da ein Handyakku deutlich kleiner ist als ein 13″ Laptop und dieser Akku kleiner ist als der von einem 15″ Laptop, kann man sich hier erklären, warum diese mit 18W, 60W oder 100W geladen werden.
Auch wird damit klar, warum Apple Handys mit weniger Strom geladen werden als Android Handys, da letztere meist deutlich größere Akkus haben.

Ein letzter Aspekt ist die Alterung durch extreme Ladezustände.
Neben der schnelleren Alterung durch hohe Ladeströme, altern Akkus auch schneller, wenn sie auf extremen Ladezuständen sind.
Als Extreme bezeichne ich hier den Abstand zu 50 %.
Ist der Akku halbvoll, ist der chemische Prozess in den Akkus relativ ausgeglichen und nicht so stark reaktiv.
Ist der Akku besonders leer oder besonders voll, sind die chemischen Bestandteile besonders instabil.
Macht ja auch Sinn, ein voller Akku hat ja schließlich Energie abzugeben und ein leerer Akku nimmt deutlich leichter Ladestrom auf.
Zum einen sollte man Akkus also immer bei etwa 50 % lagern.
Zum Anderen sollte man Akkus nicht unnötig lange besonders leer oder besonders voll laden.

Tesla beispielsweise fährt mit tausenden Lithium-Ionen-Akkus durch die Gegend.
Normalerweise werden diese nur bis 80 geladen.
Will man jedoch weiter fahren, stellt man am Abend zuvor auf 100 % und den Abreisezeitpunkt ein.
Das Fahrzeug wird dann bis 80 % geladen und pausiert dann.
Rechtzeitig vor Abreise wird das Laden auf 100 % begonnen.
Apple Geräte und Linux Betriebssysteme (mit kompatibler Hardware) können dies ebenfalls und beschränken das Laden beispielsweise auf 80 % bis kurz vor dem Aufwachen.
Dadurch wird die Zeit, die die Akkus auf 100 % verbringen, minimiert.

## Größenangaben von Akkus

Powerbanks haben meistens Angaben wie 10000 mAh oder 26800 mAh.
Diese Werte beziehen sich immer auf die Akkuspannung von 3,7V statt den 5V, die wir erwarten würden.
Bei 3.7V sind die Zahlen größer und wirken mehr.
Genauso könnte man 10 Ah statt 10000 mAh sagen, machen die Hersteller aber auch nicht.

Die 26.8 Ah Akkus sind noch spannend.
Woher genau kommt diese krumme Zahl?
In Flugzeugen ist das Mitführen von 100 Wh Akkus erlaubt.
100 Wh / 3.7 V = 27 Ah.
Ein wenig Fehlertoleranz in der Fertigung dazu und 26.8 Ah Akkus werden in Flugzeugen zugelassen sein.

# Was würde ich kaufen

Alles schön und gut, aber worauf würde ich achten, wenn ich ein Netzteil oder Akku kaufen will?

## Netzteil

Bei Netzteilen ist der Zweck vermutlich das Wichtigste.
Will ich das Netzteil mitnehmen, dann sollte es klein und leicht sein.
Vermutlich ist das wichtiger als die Anzahl der Ports.
GaN sollte also definitiv sein.
Will ich meinen Laptop beispielsweise mitnehmen und über Nacht laden, brauche ich vermutlich kein 60W Netzteil.
30W lädt beispielsweise mein MacBook über Nacht locker auf.
Auf einer Reise kann das reichen.
Auch sind die Ports möglicherweise nicht so wichtig.
Mein Handy kann ich auch über ein Kabel vom Laptop aus laden.
Sprich, der Laptop wird vom Netzteil und das Handy vom Laptop aus geladen.
Das spart ein größeres Netzteil mit mehr Ports.

Bin ich jedoch zu Hause kann es komfortabel sein, mehrere Geräte gleichzeitig laden zu können.
Meine Bluetooth-Kopfhörer, ein USB Akku, Handy, Smartwatch, Tablet, Laptop, …
Leider gibt es nicht wirklich Multi USB PD Netzteile, die dem gerecht werden würden.
Aktuell verwende ich ein 4 Port USB-A und 1 30W USB-C Netzteil.
Handy und Co laden auch über die 5V 3A von USB-A relativ schnell.
Kleine Geräte wie Bluetooth Kopfhörer oder Smartwatch haben viel zu kleine Akkus um viel Ladestrom aufnehmen zu können.
Bleiben also eigentlich nur Tablet, USB Akku und Laptop, welche mehr Ladestrom vertragen könnten.
Aber über Nacht ist so ziemlich alles auch mit 5V 3A voll.

Mobil habe ich aktuell ein 2 Port 60W oder 45W + 18W Netzteil, als auch ein kleines 30W Netzteil, beides mit GaN.
Netzteile unter 30W würde ich gar nicht erst kaufen.
Gerade mit GaN sind 30W+ Netzteile auch klein und dann kann man solch ein Netzteil auch mal gut für ein etwas größeres Gerät nutzen.
18W ist dann doch wenig, auch wenn es für das jeweilige Gerät, für das man aktuell kauft, reichen würde.

Wenn man für seinen Laptop ein Netzteil kauft:
Einige Laptops (ähm Dell) laden gar nicht erst, wenn das Netzteil weniger als 60W bereitstellt.
Das ist etwas unpraktisch und sollte beim Kaufen berücksichtigt werden.
(Es ist schon cool, dass ich mein MacBook selbst mit 5V 3A = 15W laden kann und es morgens voll ist.)

Falls man noch einen Laptop ohne USB-C hat: Es gibt Adapter von USB-C auf Laptop Stecker, wie beispielsweise für Thinkpads, welche passenderweise genau 20V benötigen, welche auch von USB PD 2.0 bereitgestellt werden können.
Diese fragen dann explizit nach 20V Profilen und akzeptieren nichts anderes.
So laden diese Adapter dann einen älteren Laptop über USB-C.

## Akkus

Auch bei Akkus kommt es stark darauf an, was man damit vorhat.
Soll es klein und portabel sein?
Dann würde ich zu einem 10000 mAh Akku greifen.
Dieser sollte über USB PD geladen werden können und sowohl USB-A als auch USB-C als Ausgang bieten.
Micro-USB würde ich nicht mehr kaufen.
Damit kann man dann sowohl ältere Geräte mit USB-A als auch neue Geräte mit USB-C zu USB-C laden.
18W USB PD Output sind hier gar nicht so unüblich.

Kommt es nicht auf die physikalische Größe bzw. das Gewicht an, dann halten größere Akkus einfach länger.
Durch das Mehr an Kapazität / Zellen ist auch der Entladestrom dieser größer.
Hier würde ich darauf achten, dass der Akku 30W USB PD kann.
Beispielsweise kann mein 26800 mAh Akku meinen Laptop mit 30W laden, was schon praktisch ist.
Diese Akkus sind aber tendenziell relativ schwer und teuer.

Schnickschnack wie LCD Akkustand Anzeigen auf 1 % genau halte ich für eher überflüssig.
Tendenziell reichen 4 LED Punkte oder wie im Falle meines großen Akkus auch 10 LED Punkte.
Genauer ist der Ladecontroller in dem Akku eh nicht, als das ich dem dann auch vertrauen würde.

# Fazit

Es gibt eine ganze Menge an Hintergrundwissen, welches man bei Power Delivery haben kann und ich hoffe, hier ein wenig mehr Einblick geben zu können.
Aber auch ich weiß hier nicht alles.
Aus diesem Grund ist auch dieser Blogpost entstanden: ein Gespräch über USB Akkus und Netzteile.
Vielleicht hast auch du noch Tipps für mich, also gerne her damit!
