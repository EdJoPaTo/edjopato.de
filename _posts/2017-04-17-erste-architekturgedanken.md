---
layout: post
title: Erste Architekturgedanken
date: '2017-04-17 21:35:00 +0200'
categories:
  - tti
tags:
  - architektur
  - bpaas-angebot
  - meeting
---
Nach unserem [ersten Praktikumstermin]({% post_url 2017-04-09-praktikum1 %}) fand fast eine Woche später ein kurzes Meeting statt. Ein großer Vorteil des Meetings war die vorher grob geplante Struktur und welche Themen angesprochen werden wollen, weshalb es deutlich effektiver und strukturierter ab lief, als das erste Praktikum.
Begonnen wurde das Meeting mit einem Überblick über den Stand aller Anwesenden.
Dabei wurde festgestellt, dass den meisten eine Architektur und Schnittstellenbeschreibungen fehlen, an denen sie ihre Komponenten entwickeln können.
Außerdem wurde besprochen, das bis zum zweiten Praktikumstermin (26. April) ein grobes System stehen soll, das eine minimale Lösung bzw. ein Proof of Concept darstellt.
An diesem Ansatz können dann Risiken abgeschätzt werden und Fehlerquellen frühzeitiger erkannt werden.

Um eine Architektur zu erstellen. wurde ein Treffen für Architektur Interessierte geplant, zu dem erst mal komplett ohne Technologie über die Komponenten und Schnittstellen nachgedacht und ein Vorschlag erstellt werden sollte.
Da zu diesem Termin 6 von unseren 9 Praktikumsteilnehmern anwesend waren, wurde entschieden, den Schritt des Vorschlags zu überspringen und die Überlegungen direkt "fest" zu setzen.

![Jeder hat andere Gedanken](/assets/2017/04/chairimagine1.gif)

Gif Quelle: [Sheepfilms Chair Imagination](http://sheepfilms.co.uk/2010/05/20/chair-imagination/)

Im ersten Praktikum wurde eine grobe Architektur erdacht, die dazu zu Grunde genommen wurde.
Diese wurde an ein Whiteboard gemalt und generalüberholt: Die Architektur benötigt nun Interaktionen mit den Services, als auch eine gewisse Simplizität für den ersten Meilenstein.

![Komponenten Erster Ansatz](/assets/2017/04/ersteransatz-komponenten.svg)

Als die Diskussion dann zu sehr in Richtung Abläufe zwischen den Komponenten abdriftete, wurde auf die Darstellung in einem Sequenz Diagramm gewechselt, um auch dort über die selben Dinge zu diskutieren.

![Sequenz Diagramm Erster Ansatz](/assets/2017/04/ersteransatz-sequence.svg)

Ein Prozessnutzer wird einen Business Prozess anstoßen.
Der Einfachheit halber haben wir im ersten Entwurf das Start Event und das Starten eines Business Prozesses gleich gesetzt. So ist das einzige auftretende Event der "Start" Befehl vom Prozessnutzer und nur eine Instanz läuft zur Zeit.
Außerdem sind Serviceanbieter und Prozessanbieter aktuell ebenfalls zurückgestellt. Ihre Tätigkeiten sollen im ersten Entwurf fest einprogrammiert oder statisch hinterlegt werden.

Um einen Prozess anzustoßen, wird sich der **Nutzer** eine **Website** aufrufen. Diese Website läuft beim Nutzer lokal und stößt über eine **API** die Aktion in unserem System an. Dies hat den Vorteil, das später ebenfalls ein CLI Tool oder eine andere Variante der Steuerung entwickelt werden kann, die die bereits vorhandene API benutzt.

Die API spricht mit dem **Controller** über das interne Kommunikationsprotokoll und abstrahiert so die externe und interne Sicht des Systems.
Der Controller wird den Prozess beim **Executor** anstoßen. Dafür ruft der Executor die Konfiguration des Business Prozesses vom **Data Center** ab. Mit dieser Konfiguration startet der Executor dann, wenn ein Event eintritt (im ersten Entwurf direkt) eine neue **BP Instanz**. Die Instanz kennt ihre Business Prozess Logik über die mitgegebene Config und ist so für alle Business Prozesse gleich gehalten. Abhängig von der Config werden dann von der BP Instanz die jeweiligen **Services** angestoßen. Diese haben möglicherweise eine Interaktion mit einem User **Bimbo** (Der Name wurde mehrheitlich von allen Anwesenden gewählt).
Sobald alle Services durchgelaufen sind, signalisiert die BP Instanz dem Executor die durchgeführte Instanz und beendet sich selbst.
Diese Signalisierung wird über die einzelnen Layer bis hin zum Nutzer gemeldet.

Insgesamt hat mir die Architekturdiskussion wesentlich besser gefallen als das erste Praktikum, da die Diskussion zielgerichteter war und zu einem Zeitpunkt nicht wichtige Punkt auf später verschoben wurden.
So haben alle ihre Meinungen einbringen können.
