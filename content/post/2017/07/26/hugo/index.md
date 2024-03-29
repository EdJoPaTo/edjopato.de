---
title: Von Jekyll zu Hugo
subtitle: Statische Seitengenerierung für Blogs
date: 2017-07-26T00:42:00+02:00
categories:
  - open-source
tags:
  - web
  - website
---

Der Blog wurde bisher mit [Jekyll](https://jekyllrb.com) erstellt, wie bereits in einem [früheren Blogpost]({{< relref "/post/2017/03/30/neue-website" >}}) beschrieben wurde.
Dies bot die Vorteile von statischer Seitengenerierung, jedoch war die Nutzung mit Ruby in meinen Augen unschön.

Erst muss Ruby installiert werden, dann müssen bestimmte Gems installiert werden usw.
Jetzt kann man argumentieren, das eine CI Lösung diese Aufgaben übernehmen kann, ich würde jedoch gerne lokal arbeiten können und sehen, was gerade geschrieben wird.

Außerdem können mit Jekyll einige Dinge nur mit größerem Aufwand realisiert werden, wie Seiten für einzelne Tags / Kategorien.

Auf der Suche nach Alternativen bin ich auf [Hugo](https://gohugo.io) gestoßen.
Hugo nimmt einem einiges ab, was ich vorher mit Jekyll nachgebaut hatte.
So wird zum Beispiel ein Atom RRS Feed oder eine Sitemap ohne jegliches Zutun von Hugo erstellt.
Auch Seiten für Tags / Kategorien entstehen ohne weitere Einstellungen.

Zudem ist die Trennung zwischen Theme und Content klarer und durchgezogener.
Mit Hugo erstellter Content kann von den meisten Themes direkt dargestellt werden und nur minimale zusätzliche Einstellungen sind nötig.

Auch die Entwicklungsgeschwindigkeit von Hugo ist deutlich höher als von Jekyll.
Es kommen regelmäßig Features hinzu, wohin gegen Jekyll sich auf kleine Features und Bugfixes beschränkt.
Und da Hugo in den Arch Linux Community Repositories ist, ist es einfach mittels pacman installierbar und über die integrierte CLI nutzbar.
(Auch in Debian-basierten Distributionen (Ubuntu, Mint, …) in den offiziellen Repos.)
Mit der höheren Entwicklungsgeschwindigkeit entstehen allerdings auch Nachteile, wenn man einen eigenen Theme entwickelt:
So ist die Doku teilweise veraltet und man muss sich etwas mehr herein fuchsen, um an sein Ziel zu kommen.

Ein weiterer Vorteil ist die deutlich höhere Geschwindigkeit der Erstellung:

```plaintext
Jekyll: 2,63s user 0,18s system 99% cpu 2,813 total
hugo: 0,21s user 0,03s system 235% cpu 0,102 total
```

Dies kommt beim einmaligen Erstellen zwar nicht großartig zum Tragen, ist jedoch beim Erstellen und editieren von Posts deutlich bemerkbar.
Ein LiveReload System ist integriert, der Browser lädt automatisch neu, was zusätzlich entspannteres voran kommen ermöglicht.
Auch bietet die Option `--navigateToChanged` den Vorteil, mit den Browser automatisch zum aktuell editierten Post zu springen.

Einige Grenzen bietet Hugo für mich jedoch dennoch:

- Die CLI bietet kein Autocomplete für ZSH und für Bash scheint diese auf Arch nicht zu funktionieren.
  Da ich jedoch auch mal eben per `hugo <command> --help` nachschauen kann, stört mich dies nicht so stark.
- Man kann keine Templates für beispielsweise bestimmte Tags erstellen (oder ich hab es in der Doku nicht gefunden).
  Im Jekyll Blog hatte ich eine extra Seite nur für die TTI Posts in chronologischer Reihenfolge erstellt.
  Diese kann ich mit Hugo für die TTI Kategorie nicht wieder erstellen (oder ich weiß einfach nur nicht wie).

Unabhängig von der Einführung von Hugo habe ich noch ein paar weitere Dinge optimiert, die mich vorher störten:
Das CSS Framework [Bulma](https://bulma.io) wurde durch selbst geschriebene CSS Regeln abgelöst.
Diese umfassen wesentlich weniger Regeln und sich mit der Anwendung in Hugo auf das benötigte beschränkt.
Außerdem wird der CSS Content jetzt im HTML Head ausgeliefert, statt als eigene Datei.
Dies beschleunigt die Darstellung.
Nur die Bilder werden noch separat geladen.

Alles in allem bin ich mit Hugo zufriedener als mit Jekyll, weshalb Hugo Jekyll ~~ablösen wird~~ abgelöst hat.
