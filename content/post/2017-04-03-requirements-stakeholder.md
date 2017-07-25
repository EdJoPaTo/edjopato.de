---
categories:
- tti
date: 2017-04-03T16:08:00+02:00
lastmod: 2017-04-04T20:38:00+02:00
tags:
- bpaas-angebot
- vorbereitung
title: Requirements der Stakeholder - Analyse des Vorschlags
aliases:
- /blog/tti/2017/04/03/requirements-stakeholder.html
---

Zur Entwicklung des BPaaS Angebots müssen die Requirements der Stakeholder genauer betrachtet werden, um zu verstehen, was das BPaaS Angebot können muss. Möglicherweise kann dann bereits bestehende Software integriert werden, wenn sie den Anforderungen genügt.

# Was wollen die Stakeholder im System machen?

Dazu hat unsere Professorin uns einen Vorschlag über die Requirements gemacht.

![Stakeholder](/assets/2017/03/stakeholder.svg)

Bild Quelle: Ulrike Steffens

In diesem Vorschlag sind mir einige Dinge aufgefallen, die sich überschneiden:

- Alle 3 Stakeholder wollen Services anbieten/ einbinden.

  Wollen sie das wirklich? Was müssen wir da wirklich bauen um das zu bewerkstelligen? Was wollen sie unterschiedliches?

- Prozessnutzer und Prozessdesigner wollen laufende Prozesse monitoren und abrechnen

Außerdem sind einige Punkte meiner Meinung nach nicht sehr klar formuliert:

- Prozessnutzer
  - "Prozesse customizen":

    Vermutlich will er nur Eingabewerte setzen? Den eigentlichen Prozess anpassen machen ja die Prozessanbieter. Mögliche Eingabewerte könnten auch aus extra Services kommen (Cloud Storage Import).

  - "Prozesse skalieren":

    Das BPaaS Angebot sollte selbstständig laufende Prozesse skalieren. Das sollte kein Requirement einer Aktion sein, die der Stakeholder tätigen will? Nur Eingangsdaten usw. bestimmen?

- monitoren:

  Was wollen die einzelnen Stakeholder wirklich wissen? Ihre Kosten/ Einnahmen. Und sonst?

# Grobe Idee

Wir haben uns dann in einer kleinen Gruppe zusammen gesetzt, um einmal eine grobe Struktur eines möglichen BPaaS Angebots auszuarbeiten.

![Idee für BPaaS](/assets/2017/04/tti_arch.svg)

In den Ecken sind wieder die 3 Stakeholder Nutzer, Prozessanbieter und Serviceanbieter.

Der Service Anbieter hat einen Service erstellt, den er gerne in unser BPaaS Angebot integrieren möchte (bekannt machen möchte). Dieser Service wird dann in unserem System als Eintrag in die Liste vorhandener Service Spezifikationen hinzugefügt.

Ein Prozess Anbieter ruft die Liste vorhandener Services ab. Daraus kombiniert er dann einen neuen Business Process. Die Spezifikation des Prozesses wird dann in unserem System in der dafür vorgesehenen Liste hinterlegt.

Aus diesen spezifizierten Prozessen erstellt unser System dann einen Service, der diese gesammelten Aktionen später durchführen kann. Ist der Service erstellt, wird dieser ebenfalls in der Liste der Services bekannt gegeben und kann so auch wieder abstrahiert in neue Prozesse integriert werden.
Außerdem protokolliert dieser neue Service seine Nutzung und die Nutzung integrierter Services in das Monitoring.

Der Prozess Nutzer ruft die Liste der vorhandenen Prozesse ab. Aus diesen kann er einen auswählen, möglicherweise Parameter setzen und starten. Außerdem will er bei einem Monitoring abfragen können, was gerade für ihn läuft, wie lange das möglicherweise dauert, wie viel es ihn schon gekostet hat, möglicherweise Hochrechnungen für Kosten bis der Prozess beendet ist, aufgetretene Fehler usw.

# Offene Punkte

- Wie beschreibt ein Serviceanbieter einen Service? Was muss beschrieben werden? Was wären Inputs? Outputs? Wie stellt man sicher, das ein Service, der JSON zu CSV konvertiert auch nur hinter Services geschaltet werden kann, der JSON ausgibt?
- Ein Business Process kann, so wie es im Bild aussieht, das unsere Professorin uns als Vorschlag gegeben hat, Kontrollblöcke wie möglicherweise if/else-Blöcke enthalten. Wie werden diese spezifiziert?
- Wie weit kann ein Prozessnutzer Prozesse anpassen? Nur bestehende Prozesse um In- und Outputs erweitern? (Beispiel: Cloud Storage als Input, Ausgabe Format konvertieren, drucken und verschicken)
- Was beinhaltet das Monitoring

  - Was will der Nutzer sehen?

    - Angefallene Kosten
    - Restdauer
    - ...?

  - Was will der Prozessanbieter sehen?

    - Anzahl der Nutzungen seiner Prozesse (+ daraus entstehende Einnahmen für ihn)
    - Services die besonders lange brauchen
    - ...?

  - Was will der Prozessanbieter sehen?

    - Anzahl der Nutzungen seiner Services (+ daraus entstehende Einnahmen für ihn)
    - ...?

Die offenen Punkte müssen nun wieder in der großen Gruppe diskutiert und genauer spezifiziert werden.
