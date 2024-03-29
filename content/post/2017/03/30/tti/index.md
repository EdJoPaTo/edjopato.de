---
title: Erstellung eines BPaaS Angebots
date: 2017-03-30T17:33:00+02:00
categories:
  - tti
tags:
  - bpaas-angebot
  - haw-hamburg
---

Ich studiere im ersten Semester Master Informatik an der HAW Hamburg.
Dort belege ich den Kurs TTI: Technik und Technologie verteilter Informationssysteme.
Als Prüfungsleistung ist ein ePortfolio, so wie dieser Blog, vorgesehen.
Hier wird es also noch häufiger um TTI gehen.
Ziel des Praktikums ist es, einen Cloud Dienst zu erstellen.

![Cloud](cloud.svg)

Bild Quelle: Ulrike Steffens

Dabei wird immer mehr der Basis einer Anwendung auf ein Cloud System verlagert.
Dieses Cloud System übernimmt dann Teile, wie zum Beispiel bei IaaS die Infrastruktur.
Ein Nutzer von einem IaaS Anbieter muss sich dann nicht mehr um die Wartung und Instandhaltung der Infrastruktur kümmern.
Außerdem bezahlt er nur noch die Leistung, die er wirklich verwendet.

So läuft mein [Telegram Bot](https://calendarbot.hawhh.de/) zum Beispiel auf einem vServer.
Die Infrastruktur wird dabei von meinem vServer Anbieter gestellt.
Die Laufzeitumgebung Node, sowie meine Anwendungslogik habe ich aber selbst aufgespielt, konfiguriert usw.
Es basiert also auf einer IaaS Architektur.

Im Praktikum sollen wir nun ein generisches Business Process as a Service Angebot entwickeln.
Im Grunde genommen handelt es sich dabei eher um eine Service Komposition aus mehreren SaaS Services, da es wieder "nur" eine Software bildet.

![BPaaS](bpaas.png)

Bild Quelle: Fraunhofer IAO, 2012

Für unser BPaaS Angebot hat unsere Professorin uns 3 Stakeholder vorgeschlagen:

- Der **Prozessnutzer** ist der Endkunde des Systems.
  Er möchte vorhandene Business Prozesse nutzen und wie üblich bei Cloud Diensten nur noch das zahlen, was er wirklich verwendet.
  Zum Beispiel muss er dann nicht mehr das ganze Jahr teure Rechner im Haus haben, nur um am Jahresende eine Abrechnung durchführen zu können.
- Die **Prozessanbieter** kennen sich mit häufig genutzten Prozessen aus und erstellen diese in unserem Angebot.
  Dazu verwendet er bereits existierende Services (SaaS) und schaltet diese beliebig zusammen.
  Dafür das er diesen Prozess erstellt hat, möchte er bei jeder Nutzung einen gewissen Betrag erhalten, sowie analysieren können, an welchen Stellen der Prozess vielleicht noch nicht ideal läuft.
- Die **Serviceanbieter** stellen Dienste bereit, die in Prozessen verwendet werden können.
  Sie wollen ebenfalls die Nutzung analysieren können um ihre Dienste zu optimieren.
  Außerdem wollen sie für den genutzten Service bezahlt werden.

![Stakeholder](stakeholder.svg)

Bild Quelle: Ulrike Steffens

Im nächsten Schritt beginnt es nun damit, die Requirements der einzelnen Stakeholder auszuarbeiten: [Requirements der Stakeholder]({{< relref "/post/2017/04/03/requirements-stakeholder" >}}).
