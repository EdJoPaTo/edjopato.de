---
background:
  name: Mensa Berliner-Tor an der der HAW Hamburg
  style: url(/assets/2020/01/haw-mensa.jpg)
date: 2020-01-14T22:40:00+01:00
title: MensaMining
subtitle: Mensa Daten des Hamburger Studierendenwerks
tags:
  - calendarbot
  - canteen
  - haw
  - haw-hamburg
  - hawhh
  - mensa
---
Die HAW Hamburg hat als eine von vielen Hamburger Unis und Hochschulen eine Mensa des Studierendenwerks.
Mein Kalenderbot enthält bereits seit Jahren den aktuellen Speiseplan und hat dafür die Webseite geparst.
Diese Daten habe ich gesammelt und mal einen Blick darauf geworfen.
<!--more-->

# Hintergrundgeschichte

Durch den Mangel an brauchbar abonnierbaren Veranstaltungsplänen habe ich vor Jahren ein kleines Tool geschrieben, welches die Veranstaltungspläne parst und als ICS Datei auf einem Webhost bereit stellt.
Im Laufe der Zeit wurde daraus ein [Telegram Bot](https://telegram.me/HAWHHCalendarBot), den mittlerweile hunderte von Studierenden benutzen und benutzt haben.

Ein Feature dieses Telegram Bots wurde das Anzeigen der Gerichte in der Mensa.
Um diese im Bot anzuzeigen, müssen diese Daten von dem Studierendenwerk geholt werden.
Leider gibt es dafür keine offene API, daher habe ich ein Programm zum Web Scraping der Webseite geschrieben.
Dieses Programm sammelt mir aktuell alle Mensen und Cafés des Studierendenwerk Hamburgs und läuft seit dem Wintersemester 2017.

Anfangs habe ich das Programm in C# entwickelt, habe es jedoch vor kurzem in TypeScript überführt.
Den Quellcode findet ihr auf [GitHub (mensa-crawler)](https://github.com/HAWHHCalendarBot/mensa-crawler), die gesammelten Daten findet ihr ebenfalls auf [GitHub (mensa-data)](https://github.com/HAWHHCalendarBot/mensa-data).

# Datenanalyse

Mit den Daten kann man nun einige Dinge betrachten.
Beispielsweise enthalten die Daten Informationen über Dinge wie vegan, vegetarisch, mit Rindfleisch, Fisch, … oder auch Preise, Zusatzstoffe/Allergene.

Ich will hier allerdings nicht alles zeigen, was ich mir so angesehen habe.
Die Daten sind verfügbar und ihr dürft selbst euren Ideen freien Lauf lassen.

Ein paar Inspirationen auf diesen Daten folgen unten, alle jeweils von der Mensa Berliner-Tor.
Um noch mehr Ideen zu bekommen, was alles möglich ist, kann ich beispielsweise den [BahnMining Talk vom 36c3](https://media.ccc.de/v/36c3-10652-bahnmining_-_punktlichkeit_ist_eine_zier) empfehlen.

![Average meal price per week](/assets/2020/01/price.svg)
![Pommes vs Twister](/assets/2020/01/pommes-twister.svg)

Auch mal einen Blick wert: Die Commits im [Data Repo](https://github.com/HAWHHCalendarBot/mensa-data/commits/master). Preisänderungen, Anpassungen von Zutaten, Allergene verschwinden oder kommen hinzu, …
