---
title: Die ersten Vorlesungen
date: 2017-04-17T07:07:00+02:00
categories:
  - tti
tags:
  - haw-hamburg
---

Neben der Praktikumsaufgabe zur Erstellung eines BPaaS Angebots findet auch eine Vorlesung im generelleren Bereich der "Technik und Technologie verteilter Informationssysteme" (TTI) statt.
In dieser werden Grundlagen aus den unterschiedlichen Bereichen vermittelt und in Gruppenarbeiten Themen selbst angeeignet oder ausarbeitet.
Dazu gibt es im folgenden Post, sowie späteren Posts Zusammenfassungen zu den einzelnen Vorlesungsterminen.
Insgesamt sind 12 Vorlesungen angesetzt.

# Die erste Vorlesung am 21. März

Wie für die erste Vorlesung gewohnt, beginnt diese mit dem Organisatorischen: Wer steht da eigentlich vorne, was macht das Praktikum, wie sieht die Prüfungsleistung aus und so weiter.
So hat sich unsere Professorin [Ulrike Steffens](//users.informatik.haw-hamburg.de/~steffens/) vorgestellt, uns die Praktikumsaufgabe des BPaaS Angebots vorgestellt und uns die Prüfungsform des ePortfolios erläutert.
Mehr dazu im [ersten Post]({{< relref "/content/post/2017/03-30-tti.md" >}}) zum Thema [TTI](/blog/tti).

Danach wurde recht zeitig mit dem Vorlesungsstoff begonnen.
Dabei begann es mit der Definition des Cloud Computings und dessen gewünschte Eigenschaften:

1. **Resource Pooling** Gemeinsame, oft globale Nutzung physischer Ressourcen
2. **Rapid Elasticity** Unverzügliche Anpassbarkeit an aktuellen Ressourcenbedarf
3. **On-Demand Self-Service** Selbstbedienung nach Bedarf
4. **Broad-Network Access** Umfassender Netzwerkzugriff
5. **Measured Service** Messung der Servicenutzung

Außerdem ging es um die Geschichte des Cloud Computings, wie es sich aus Verlagerung rechen-aufwendiger Aufgaben auf Mainframe Computer über grundlegende Virtualisierung zu Cloud Diensten entwickelte.
Mittlerweile ist es eines der Ziele, das Cloud Computing ähnlich wie Strom oder Wasser immer Verfügbar ist und nach Bedarf verwendet, sowie abgerechnet werden kann.

![Cloud](/assets/2017/03/cloud.svg)

Bild Quelle: Ulrike Steffens

Dem folgte die Modularisierung der Komponenten zum einen in die unterschiedlichen Schichten wie Infrastruktur (IaaS), Plattformen (PaaS) und Software (SaaS), sowie die Auftrennung in Services, die leichter wiederverwendet werden können, als größere, monolithisch aufgebaute Systeme.

Die Vorlesung endete mit einer Gruppenarbeit und der Vorstellung dessen Ergebnisse, welche Vor- und Nachteile der Umstieg auf Cloud Systeme für kleine bis mittelständische Unternehmen bietet, sowie welche Risiken für diese Firmen bestehen und wie diese minimiert werden können.

# Die zweite Vorlesung am 28. März

Als grundlegendes Thema der Vorlesung wurde die Infrastruktur Schicht betrachtet.
Dabei stellt die Virtualisierung und damit Abstrahierung unterer Schichten ein essentielles Thema da.

![Virtualisierung im Software Stack](/assets/2017/04/vm.svg)

Bild Quelle: Ulrike Steffens mit Vorlage von Sieh, V., Universität Erlangen-Nürnberg: Vorlesung Virtuelle Maschinen, Wintersemester 2016 / 17. [Online Version](https://www4.cs.fau.de/Lehre/WS16/V_VM/Vorlesung/einleitung.pdf) Folie 7

Dafür wurde auf Schnittstellen zum Betriebssystem eingegangen und auf Eigenschaften der Virtualisierung, wie Partitionierung (verschiedene Anwendungen laufen auf einer physischen Maschine), Isolation (VMs bekommen voneinander gegenseitig nichts mit) sowie der Kapselung (Zustände lassen sich Hardware unabhängig ablegen).
Es ging danach um Hypervisor und Container wie Docker.

In einer Gruppenarbeit wurde sich dann mit [Pattern für Cloud Systeme](//cloudpatterns.org) befasst und anschließend exemplarisch vorgestellt.

Zum Ende des Praktikums wurden die 3 Stakeholder des BPaaS Angebots nochmal genauer betrachtet und in jeweils einer Gruppe für einen Stakeholder die Requirements genauer ausgearbeitet.
In meiner Gruppe wurde der Prozessanbieter genauer betrachtet.
Grobes Ergebnis der Gruppenarbeit war, das es Systeme gibt, die Dinge können, die wir in unserem BPaaS Angebot benötigen.
Welche Anforderungen wir wirklich haben und ob besagte Systeme diese Anforderungen erfüllen können, war in der Gruppe offensichtlich nicht von Relevanz.
Darauf basierend ist der [Post zu den Requirements]({{< relref "/content/post/2017/04-03-requirements-stakeholder.md" >}}) entstanden.

# 3. Vorlesung am 04. April

Die Vorlesung begann mit einer Interessen- bzw. Wissensabfrage, welche Themen in der Vorlesung besonders stark behandelt werden sollten.
Fortgesetzt wurde mit OpenStack und dessen Komponenten.
Das Thema hätte für mich persönlich kürzer gefasst werden können, da ich in näherer Zeit nicht mit OpenStack arbeiten werden.
Alternativ hätte das Thema auch mehr auf die generellen Konzepte verlagert werden können, als im Detail über den OpenStack spezifischen Aufbau zu sprechen.

Danach wurde kurz auf die größten IaaS Anbieter Amazon Web Services, Microsoft Azure, die Google Cloud Platform und IBM Softlayer, sowie zu generellen Kriterien zur Entscheidung der Auswahl eines IaaS Providers, gesprochen.
Als Gruppenaufgaben wurden dann die eben genannten IaaS Anbieter, sowie einige deutsche Angebote recherchiert und vorgestellt.
Generell lässt sich festhalten, das die Angebote der Anbieter eher für Leute gedacht sind, die bereits wissen, was sie wollen.
Meistens ist schlecht bis gar nicht erklärt, was die einzelnen Angebote machen oder wo sie vor oder Nachteile gegenüber anderen Services des selben Anbieters haben.

Leider sind die Recherchen der einzelnen Gruppen teilweise nur lose Link Sammlungen, sodass eine Recherche erneut vorgenommen werden muss, da besagte lose Link Sammlungen keinen Überblick über das Angebot bieten.

Vervollständigt wurde die Vorlesung dann mit einem kurzen Überblick über Platform as a Service (PaaS) Grundideen.

# 4. Vorlesung am 11. April

Begonnen wurde die Vorlesung mit einem Vortrag von Tobias Schwab von [PhraseApp](//phraseapp.com).
Dieser erzählte uns vom Konzept von Kubernetes und dem Einsatz dessen in seiner Firma.

![Lastverteilung über die Woche bei PhraseApp](/assets/2017/04/last-phraseapp.png)


Bild Quelle: Tobias Schwab, PhraseApp; Farben angepasst, sprechender gemacht

Spannend war dabei, das er einen groben Einblick zu Kubernetes geben konnte und uns vor allem beispielhaft die laufende Services für PhraseApp, gesteuert mit Kubernetes, gezeigt hat und man so sehen konnte, was Kubernetes produktiv leistet.
Er hatte einen hohen Demo Anteil, in dem er einen kleinen Service erstellt hat und diesen auch mit Lastverteilung deployed hat.
Dies funktionierte auch deswegen als Live Demo gut, weil er sehr gut und schnell mit dem Kubernetes CLI umgehen konnte.
Ich hätte mir dennoch etwas mehr visuelles "was habe ich jetzt vor" gewünscht, um zu sehen worauf er eigentlich gerade hin arbeitet.

Fortgesetzt wurde die Vorlesung von unserer Professorin mit der Mandantenfähigkeit von Cloud Services.
Grundlegend wurde dieser Abschnitt bereits zwei Vorlesungen früher als Isolation für IaaS erklärt.
Dieser Part stellte also eher nur eine detailliertere Wiederholung auf Basis für PaaS und SaaS da.

Im letzten Teil der Vorlesung wurde sich dann mit grundlegenden Standards für Webservices befasst:

- XML
- HTTP
- SOAP, welches aber nicht mehr wirklich verwendet wird
  - WSDL
  - UDDI
- REST/ RESTful

Ich als technischer Informatiker hatte diese Standards bereits alle in der Bachelorvorlesung Verteilte Systeme.
Studenten anderer Studiengänge hatten diese Themen aber noch nicht.
