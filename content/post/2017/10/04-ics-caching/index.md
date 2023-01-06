---
title: Caching von abonnierten ICS Kalendern
date: 2017-10-04T19:54:00+02:00
categories:
  - open-source
tags:
  - calendarbot
  - haw-hamburg
  - ios
  - macos
  - telegram
---
Der [HAWHHCalendarBot](https://hawhh.de/calendarbot/) wird mittlerweile doch recht viel genutzt.
Eine der häufigsten Kritiken ist das langsame Aktualisieren des Kalenders mit dem Google Kalender.
Jetzt war ich mal neugierig und habe in die Server Logs geschaut, um zu vergleichen, wie lange die einzelnen Clients (iOS, Google, HAW Mailer, …) die Kalender cachen.
Wie lange es also dauert, bis die Endgeräte den aktualisierten Kalender anzeigen können.
<!--more-->

# Analyse

Um die jeweiligen Dienste bewerten zu können, habe ich jeweils die abgerufenen Kalender Dateien und den jeweiligen User Agent betrachtet.

```plaintext
141.22.70.173 - - [28/Sep/2017:13:37:38 +0000] "GET /tg/<id>.ics HTTP/2.0" 200 15400 "-" "iOS/11.0 (15A372) dataaccessd/1.0"
```

In diesem Eintrag aus dem `access.log` ist erkennbar, das der Aufruf von einer HAW IP erfolgt ist.
Außerdem ist die Zeit und die genaue Kalender Datei erkennbar.
`200` ist der HTTP Code für Success und `15400` die Größe der Antwort.
Am Ende steht der UserAgent, in diesem Fall ein iOS Gerät mit iOS 11.

## Ergebnisse

**iOS** und **macOS** aktualisieren jeweils alle 20 bis 40 Minuten.
Außerdem kann man die Aktualisierung manuell anstoßen (In der iOS Default Kalender App unten Mitte _Kalender_ wählen und in der Auswahl der anzuzeigenden Kalender nach unten ziehen → refresh).
Zudem wird der Server Cache (`HTTP 304`) respektiert, um übertragene Daten zu sparen, wenn keine Änderungen vorhanden sind.

Der **HAW Mailer** (Microsoft Exchange) aktualisiert, präzise wie ein Uhrwerk und auf die Sekunde genau, alle 3 Stunden.
Vermutlich relativ zum Zeitpunkt des Hinzufügens.

Der **Google Kalender** aktualisiert (meistens) so grob alle 10 bis 18 Stunden.
Auf den ersten Blick keine Regel dafür erkennbar.
Außerdem scheint er nicht zu vergessen: Einmal einen Kalender hinzugefügt und wieder entfernt, aktualisiert wird weiterhin.
Es gibt sowohl positive, als auch negative, (deutliche) zeitliche Ausreißer (Extreme: 12min, 35h).

**Microsoft Outlook** aktualisiert alle 30 Minuten und respektiert ebenfalls den Server Cache (`HTTP 304`).

## Beobachtete Technologien

**iOS** und **macOS** verwenden in neueren Versionen `HTTP/2.0` statt `HTTP/1.1` und **iOS**, **macOS** und **Outlook** verwenden, wenn möglich, IPv6 zum Server (buuh, die HAW hat kein IPv6 👎. Und sowas will Informatik Hochschule sein. 🙄)
Möglicherweise könnte der **HAW Mailer** (Microsoft Exchange) auch IPv6 nutzen, kommt jedoch aus dem HAW Netzwerk, daher wird das wohl aktuell nichts.

# Fazit

iOS und macOS gehen da mit guten Beispiel voran und prüfen regelmäßig auf Aktualisierungen, ohne Daten zu übertrangen, wenn nicht nötig.
Der Google Kalender ist wohl nicht die schlaueste Wahl, um den Kalender zu abonnieren.
Besser ist da der HAW Mailer, der auf Microsoft Exchange basiert.

Tipps zum Abonnieren eines Kalenders findet man im Telegram Bot [@HAWHHCalendarBot](https://t.me/HAWHHCalendarBot) unter `/subscribe`.
