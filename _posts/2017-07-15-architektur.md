---
layout: post
title: Die finale Architektur
date: '2017-07-15 01:30:00 +0200'
sitemap:
  lastmod: 2017-07-15 02:10:00 +0200
categories: tti
tags: praktikum bpaas-angebot architektur komponenten
header: large
background:
  style: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.0)), url(/assets/backgrounds/luhepark1.jpg)
  color: '#555'
  is-dark: true
  name: 'Luhepark Winsen'
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
Zum erstellen der Website wurde das [React Framework](//facebook.github.io/react/) verwendet.
Mehr dazu im Blog Eintrag vom Verantwortlichen der Website, sobald dieser erschienen ist…

Die Website benutzt für alle Interaktionen mit unserem System die **API**.
Diese bietet eine REST Schnittstelle an, die mit Hilfe von [Swagger](//swagger.io/) definiert wurde.
Dies bietet den Vorteil, das Swagger sowohl eine gute Doku, als auch vereinfachte Erstellung der API Komponente bietet.
Die API ist stateless und reicht sämtliche Anfragen an die jeweiligen, zuständigen Komponenten innerhalb des Systems weiter.
Dafür wird [RabbitMQ](//rabbitmq.com) verwendet.
Mehr zur API im Blog Eintrag vom Verantwortlichen der API, sobald dieser erschienen ist…

Der **Data Center** enthält die persistent gespeicherten Informationen unseres Systems, wie die Business Prozesse oder die hinterlegten Services, die verwendet werden können.
Mehr zur Definition dieser Daten im Blog Eintrag der Verantwortlichen, sobald dieser erschienen ist…

Der **BPExecutor** nimmt die von außen kommenden Anfragen an, einen Business Prozess auszuführen.
Die zusätzlich benötigten Informationen holt er über die API aus dem Data Center.
Sobald alle Informationen gesammelt sind, werden diese in eine RabbitMQ Queue gepackt.
Diese Queue wird von einer freien **BPInstance** abgerufen und der Business Prozess gestartet.
Es können also immer genau so viele Business Prozesse ausgeführt werden, die aktuell BPInstances gestartet werden.
Wird ein Business Prozess beendet, wird die BPInstance wieder frei und kann den nächsten Business Prozess ausführen.
Mehr zum BPExecutor und der BPInstance im Blog Eintrag vom Verantwortlichen der beiden Komponenten, sobald dieser erschienen ist…

Der **Monitor** dient zur Auswertung der Kundenaktivität um aussagen zu können, wie viel ein Business Prozess oder Service genutzt wurde.
Dafür beobachtet dieser im System verlaufende RabbitMQ Nachrichten.
Aus Zeitgründen wurde der Monitor im Laufe des Projekts zurückgestellt und nicht weiter bearbeitet.

Die **Services** stellen die einzelnen Schritte eines Business Prozesses dar.
Diese können von Kunden erstellt und in unserem System zur Verwendung registriert werden.
Dafür wurde ein RESTful Schnittstelle definiert, um Service Anbietern eine möglichst simple Schnittstelle zu bieten.
Mehr dazu im [Service Blog Post]({% post_url 2017-07-15-services %})…
