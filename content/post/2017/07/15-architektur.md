---
title: Die finale Architektur
date: 2017-07-15T01:30:00+02:00
background:
  name: Luhepark Winsen
  style: url(/assets/2017/07/luhepark1.jpg)
categories:
  - tti
tags:
  - bpaas-angebot
  - haw-hamburg
---

Ein Teil unseres Teams hat sich dazu entschlossen, die Themen des Vortrages in einzelnen Blog Posts der jeweiligen Personen aufzuarbeiten und gegeneinander zu verlinken, um einen genaueren Einblick der jeweiligen Komponenten für die Leser zu bieten.
Da ich für die Architektur unseres Teams verantwortlich war, bildet dieser Post eine Übersicht über all unsere Komponenten.

Unsere Komponenten sind die **Website**, **API**, **BPExecutor**, **BPInstance**, **Monitor**, **Data Center** und den **Services**.
Jede dieser Komponenten stellt dabei einen Docker Container dar, die miteinander kommunizieren.
![Komponenten](/assets/2017/07/komponenten.svg)

Die **Website** wird von den Nutzern unseren BPaaS Angebots genutzt.
Sie bietet eine grafische Schnittstelle zu unserem System.
Mit ihrer Hilfe können die Business Prozesse ausgeführt werden.
Außerdem können neue Business Prozesse und die darin verwendeten Services angelegt werden.
Zum Erstellen der Website wurde das [React Framework](//facebook.github.io/react/) verwendet.
Mehr dazu im [Blog Eintrag zum Praktikum](//tti-ss17-wiechmann.jimdo.com/praktikum/) vom Verantwortlichen der Website…

Die Website benutzt für alle Interaktionen mit unserem System die **API**.
Diese bietet eine REST Schnittstelle an, die mit Hilfe von [Swagger](//swagger.io/) definiert wurde.
Dies bietet den Vorteil, das Swagger sowohl eine gute Doku, als auch vereinfachte Erstellung der API Komponente bietet.
Die API ist stateless und reicht sämtliche Anfragen an die jeweiligen, zuständigen Komponenten innerhalb des Systems weiter.
Dafür wird [RabbitMQ](//rabbitmq.com) verwendet.
Mehr zur API im [Blog Post](//tti-ss2017-portfolio.jimdo.com/2017/07/13/beschreibung-unserer-api/) vom Verantwortlichen…

Der **Data Center** enthält die persistent gespeicherten Informationen unseres Systems, wie die Business Prozesse oder die hinterlegten Services, die verwendet werden können.
Mehr zum [Data Center](//haw-hamburg-tti.blogspot.de/2017/07/datenbank-fur-eine-bpaas-plattform.html) und zur [Definition der gespeicherten Daten](//haw-hamburg-tti.blogspot.de/2017/07/business-processes-in-einer-bpaas.html) im jeweiligen Blog Post der Verantwortlichen…

Der **BPExecutor** nimmt die von außen kommenden Anfragen an, einen Business Prozess auszuführen.
Die zusätzlich benötigten Informationen holt er über die API aus dem Data Center.
Sobald alle Informationen gesammelt sind, werden diese in eine RabbitMQ Queue gepackt.
Diese Queue wird von einer freien **BPInstance** abgerufen und der Business Prozess gestartet.
So können immer genau so viele Business Prozesse ausgeführt werden, wie BPInstances gestartet sind.
Wird ein Business Prozess beendet, wird die BPInstance wieder frei und kann den nächsten Business Prozess ausführen.
Mehr zum BPExecutor und der BPInstance im [Blog Post zum Thema]({{< relref "/post/2017/07/25-bpexecutor-bpinstance" >}})…

Der **Monitor** dient zur Auswertung der Kundenaktivität, um Aussagen treffen zu können, wie viel ein Business Prozess oder Service genutzt wurde.
Dafür beobachtet dieser im System verlaufende RabbitMQ Nachrichten.
Aus Zeitgründen wurde der Monitor im Laufe des Projekts zurückgestellt und nicht weiter bearbeitet.
Etwas ausführlicher beschrieben wird der Monitor im [Blog Post](//tti-ss2017-portfolio.jimdo.com/2017/07/08/monitor-oder-ein-anfang/) des Verantwortlichen…

Die **Services** stellen die einzelnen Schritte eines Business Prozesses dar.
Diese können von Kunden erstellt und in unserem System zur Verwendung registriert werden.
Dafür wurde eine RESTful Schnittstelle definiert, um Service Anbietern eine möglichst simple Schnittstelle zu bieten.
Mehr dazu im [Service Blog Post]({{< relref "/post/2017/07/15-services" >}})…
