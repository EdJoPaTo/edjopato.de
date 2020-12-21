---
background:
  name: Luhepark Winsen
  style: url(/assets/2017/07/luhepark2.jpg)
categories:
- tti
date: 2017-07-15T02:10:00+02:00
lastmod: 2017-07-15T02:30:00+02:00
tags:
- bpaas-angebot
- services
title: Die Services
---

Die Services unseres BPaaS Angebots stellen die Bestandteile eines Business Prozesses dar.
Dabei durchläuft ein Business Prozess mehrere Services, um sein Ziel zu erreichen.
Der Nutzer entscheidet dabei beim Nutzen eines Services über den Fortgang des jeweiligen Business Prozesses.

Ein Service wird dabei von Externen erstellt und für unser System zur Verwendung registriert.
Dafür benötigen die Services eine gemeinsame Schnittstelle.
Diese Schnittstelle ruft die BPInstance auf, um den Service zu nutzen.

Um eine, für Externe möglichst simple und viel verwendete Form einer Schnittstelle bereitzustellen, wurde sich dabei auf RESTful festgelegt.
Damit der Service Daten von unserem System anfragen kann, werden teilweise Anfragen als Long Polling an den Service gestellt, die dieser beantworten kann, sobald er dies benötigt.

```json
{
  "gui": "http://instance.nochkeineurl.de/gui/",
  "data": "http://instance.nochkeineurl.de/data",
  "result": "http://instance.nochkeineurl.de/result"
}
```
Für einen Service selbst wurden 3 Routen definiert.
Auf der ersten Route wird ein **GUI** angeboten, das dem Nutzer über unsere Website zur Verfügung gestellt wird.
Mit dem GUI kann der Nutzer den Service bedienen.
Die weiteren Routen werden von der BPInstance mittels Long Polling angesprochen.
Die BPInstance fragt also den Service und der Service antwortet, sobald dieser ein Ergebnis hat.
Mit der **data** Route kann der Service nach Daten fragen, die er benötigt.
Diese werden von der BPInstance bereit gestellt und können durch vorherige Services erstellt worden sein.
Mit der **result** Route wird das Ergebnis des Services zurück gemeldet.
Sobald diese Route beantwortet wurde, gilt der Service als beendet.

Da ein Service mehrfach eingesetzt werden könnte, muss der Service Anbieter mehrere Instanzen bereit stellen.
Die BPInstance fordert dabei zu Beginn auf einer BaseUrl eine Instanz an.
Der Service Anbieter kommt dieser Anforderung nach, startet eine Instanz o.A. und gibt die oben genannten URLs der Instanz zurück.
Die BPInstance benötigt zum Arbeiten also nur die BaseUrl eines Services, mit Hilfe die BPInstance die jeweiligen URLs von gui, data und result einer Instanz anfordert.

So lassen sich über diese Schnittstelle sehr frei Services erstellen oder auch bestehende mit Hilfe von Wrappern in unser System einbinden.

Wenn dich noch mehr Komponenten unseres BPaaS Angebots interessieren, schau dir doch die Übersicht aller Komponenten im Blog Post der [Architektur]({{< relref "../2017/07-15-architektur.md" >}}) unseres Systems an.
