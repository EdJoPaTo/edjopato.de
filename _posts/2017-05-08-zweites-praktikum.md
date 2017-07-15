---
layout: post
title: Ein Prototyp und das zweite Praktikum
date: '2017-05-08 17:20:00 +0200'
categories: tti
tags: bpaas-angebot praktikum meeting
---
Ein paar Wochen seit dem letzten Post zum BPaaS Angebot sind mittlerweile vergangen.
Der anvisierte Prototyp existiert mittlerweile im Großen und Ganzen.

# Prototyp

Eine grundsätzliche Website existiert, eine BPInstance kann mit einer, aktuell im Quellcode hinterlegten Config Services ansprechen. Die Services können Daten von der BPInstance anfordern und Ergebnisse zurück geben.

Die API wurde grundlegend begonnen, nachdem sich viel zu spät damit auseinander gesetzt wurde, was der Controller eigentlich machen soll. Bei dieser Diskussion wurde der Controller für "nicht benötigt" empfunden, da er nur Nachrichten von der API 1:1 an den BPExecutor weiter geleitet hätte. Aus diesem Grund wurde der Controller entfernt.

![Komponenten](/assets/2017/05/08-komponenten.svg)

Mit diesem ersten Prototyp war zwar kein kompletter Ablauf von Website bis zu den Services durchgehend möglich, sein eigentliches Ziel, Risiken und offene Punkte aufzudecken, hat der Prototyp jedoch erfüllt. So hätte früher die Verbindung von Website bis BPExecutor angegangen werden müssen.

Allerdings war in meinem Team eine etwas pessimistischere Stimmung zu unserem Fortschritt, der Prototyp würde ja nicht laufen.

# Das zweite Praktikum

Da einige Personen deutlich weniger als Andere mitgewirkt haben oder teilweise arbeiten wiederholt haben, die bereits geschehen sind, sich dafür aber nicht informiert haben oder mal gefragt haben, wie der Stand ist, wollten sich wohl mehrere Andere in meinem Team mal im Praktikum Luft machen. So jedenfalls kündigte unsere Professorin das zweite Praktikum an. Allerdings sollten wir doch zuerst mal erzählen, was wir seit dem letzten Praktikum geschafft haben und was die einzelnen so gemacht haben (Stand up Meeting im wahrsten Sinne des Wortes, jeder stellt mal kurz vor, was er gemacht hat). Dies ist ein gutes Mittel, das aufgestaute "Luft machen" erst mal zu verdrängt, damit es später nicht mehr so aufgestaut emotional ist.
Zu dem besagten "Luft machen" kam es danach, sogar auf Nachfrage hin, nicht mehr. Das "verdrängen" hat also deutlich besser funktioniert, als ich es zu Anfang erwartete.

Das Vorstellen der einzelnen Komponenten im Prototyp war etwas ausführlicher als meine Zusammenfassung (siehe oben).

Als weiterer Tagespunkt folge eine Retrospektive. Kritikpunkte an unserem bisherigen Vorgehen waren beispielsweise der die Unterschätzung des Arbeitsaufwandes oder die fehlende Kommunikation im Team (Was genau muss ich tun / was braucht der jeweils andere eigentlich an Schnittstelle zu mir? und was tun die anderen eigentlich generell so?).

Ich persönlich denke, das es nicht an Unterschätzung des Arbeitsaufwandes sondern an fehlender genutzter Zeit liegt. Für TTI gibt es 7 CP. 1 CP entspricht 30 h Arbeit (`7 * 30 h = 210 h`). Davon fallen 12 Vorlesungen und 4 Praktika mit jeweils 3h weg. `210h - 16 * 3 h = 162 h`. Unter der Annahme das 42 h für die Vor und Nachbereitung der Vorlesung sowie zum Anfertigen des ePortfolios genutzt werden, bleiben `162 h - 42 h = 120 h`. Da vor dem Ersten von 4 Praktika fast nichts außerhalb der Vorlesung passierte, nehme ich an, das die Arbeit zwischen den 4 Praktika gleich verteilt sein sollte: `120 h / 3 = 40 h`. 40 h entsprechen damit einer 8 h Arbeitswoche. Ich persönlich habe zwischen dem ersten und zweiten Praktikum vielleicht die Hälfte der Zeit genutzt und meine Aufgaben, aus meiner Sicht, gut lösen können. Ich hätte aber auch durchaus mehr Zeit gehabt um weitere Aufgaben zu erledigen. Wenn ich annehme, dass die investierte Zeit meiner Team Mitglieder ähnlich groß war, wäre noch deutlich mehr Potenzial an vorhandener Arbeitszeit vorhanden. (Außerdem gehe ich nicht bei allen davon aus, die Zeit genutzt zu haben.)

Als weiteres Problem wurde aufgezählt, das es an Kommunikation mangelte. Wir haben ein Slack Channel für unser Team, in dem (im Vergleich zu anderen Teams) sogar alle Team Mitglieder frühzeitig waren. Wenn jemand nicht weiß, wie es mit etwas aussieht, kann jederzeit die Frage in die Gruppe (oder an die bekannte, zuständige Person) gestellt werden. Außerdem könnten die jeweiligen Personen einer Komponente Anforderungen an andere Komponenten formulieren, die sie benötigen (Beispiel: Website benutzt API, was braucht die API damit ich arbeiten kann?). So wurde lange nicht bemerkt, das der Controller (der später durch die API übernommen wurde) herrenlos ist und Arbeit benötigt, weil niemand die Frage in den Raum gestellt hat (bzw. erst sehr spät) und besonders wichtig, für dessen Beantwortung gesorgt hat. Meiner Meinung nach funktioniert die Kommunikation in einem Team wie unserem nur auf Request Response Basis. Darauf warten, das jemand mit einem kommuniziert, was zu tun ist, wird nicht funktionieren. (Vor allem nicht, weil wir uns im Master befinden und eigentlich selbst denken können (?), anstatt uns sagen zu lassen, was wir tun sollen.)

Das Praktikum wurde damit fortgesetzt, Aufgaben für die einzelnen Personen zu erstellen (und später daraus Issues zu erstellen). Diese Aufgaben sollen bis zum 2. Mai mindestens vom Konzept her klar sein.

# Meeting 2. Mai

Das Meeting wurde begonnen mit einer Runde, was passiert ist und wie es mit den einzelnen Komponenten aussieht. Danach wurde relativ schnell nur noch in Untergruppen diskutiert oder einzeln an Komponenten weiter entwickelt.

Unter anderem wurde definiert, das der Data Center nur noch die Configs für BPs und Services speichern soll. (Wo ist der Aufwand, ein einfachen File Store aufzusetzen, der schreiben und lesen kann, gesteuert durch RabbitMQ, REST oder whatever?)

# Fazit

Aktuell wirkt es auf mich, als wäre wenig Arbeit auf viele Leute verteilt worden, sodass viele quasi arbeitslos sind. Nur Website und API benötigen noch wirklich Arbeitsaufwand. Data Center und BPExecutor sind relativ kleine Komponenten mit vermutlich sehr wenig Aufwand.
