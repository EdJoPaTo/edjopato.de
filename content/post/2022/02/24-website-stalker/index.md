---
title: Eigenes Tool - Website Stalker
date: 2022-02-24T16:16:00+01:00
categories:
  - open-source
tags:
  - command-line
  - git
  - linux
  - macos
  - rss
  - rust
  - server
  - web
---
Wenn man wissen will, was so auf fremden Webseiten passiert, gibt es häufig RSS-Feeds.
Etliche Webseiten haben so etwas jedoch nicht oder man möchte Details wissen, die so nicht in RSS-Feeds stehen.
Die einfache Lösung ist ein Cronjob mit `curl`, `sed` und `git commit`, diffs liegen dann in einem Git Repository.
Das ist so halbwegs komfortabel und habe ich für mich in eine Executable gegossen, die das für mich in besser macht.
Und dieses Tool will ich hier beschreiben.
<!--more-->

Angefangen hat es fast wie oben beschrieben.
Webseite laden, ein bisschen filtern mit regulären Ausdrücken und dann in einem Git Repository speichern.
Damals war das noch ein Telegram Bot, dem man sagen konnte, was man haben will.
War schon mal ganz nett, hat einem auch direkt per Telegram über Änderungen benachrichtigt, Notifications gab es also quasi gratis.
Aber ideal war das auch noch nicht, vor allem war das zentralisiert auf meinem Server und das skaliert nicht so wirklich gut.
Ein Nutzer hätte so relativ leicht einen Weg gebaut, alle n Minuten riesige Dateien von fremden Servern zu ziehen, das wollte ich mir nicht ans Bein binden.

## Die Rust Anwendung

Mittlerweile, seit 10 Monaten, ist das eine Rust Anwendung, die Teil meines Alltags wurde.
Konfiguriert wird über eine YAML Datei und das Tool wird dann regelmäßig ausgeführt.
In meinem Fall mache ich das über die CI von GitHub, geht aber auch beispielsweise über systemd oder crontab, ziemlich simpel.

So sieht eine relativ einfache Konfiguration aus:

```yaml
sites:
  - url: "https://edjopato.de/"
    editors:
      - html_prettify
  - url: "https://rain-brainz.de/"
    editors:
      - css_select: img
      - html_prettify
```

Jedes Mal, wenn das Tool gestartet wird, wird die Konfiguration gelesen und alle URLs abgerufen.
Dann werden die Editoren (ähnlich wie `sed`) genutzt um das Ergebnis zu filtern und besser vergleichbar zu machen.
In diesem Fall wird `html_prettify` genutzt, um das HTML zu formatieren.
Das macht die Diffs übersichtlicher, was genau geändert wurde und hilft dabei, die Struktur zu verstehen.
Die zweite URL benutzt außerdem `css_select`, welches [CSS Selektoren](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors) zum Filtern benutzt.
Dabei werden nur die selektierten Elemente weiter genutzt, hier im Beispiel die Bilder (`img`).
Eine ganze Liste der verfügbaren Editoren gibt es in der [README](https://github.com/EdJoPaTo/website-stalker#editors).
Hier gibt es über reguläre Ausdrücke zum Ersetzen, Formatierungen von Formaten auch einen Editor um einen RSS-Feed zu generieren, den man dann wieder abonnieren kann.
Wenn da weitere Ideen für Editoren aufkommen, kann man/ich die gerne einbauen.

Wird die Anwendung nun ausgeführt (`website-stalker run --all --commit`) werden alle URLs abgerufen, mit den Editoren bearbeitet und abgelegt.
Mit `--commit` werden die Dateien auch gleich commited und müssen nur noch gepusht werden.

Der Befehl sieht erstmal etwas komplizierter aus, ist aber der, der im Cronjob (oder was auch immer regelmäßig läuft) steckt.
Wenn man neue Webseiten hinzufügt und diese testen will, will man normalerweise erstmal keinen Commit und auch nicht alle URLs.
Fügt man beispielsweise einen weiteren Punkt hinzu:

```yaml
  - url: "https://wiki.gnome.org/Schedule"
    editors:
      - css_select: "#content"
      - html_markdownify
```

Kann man diesen mit diesem einfacheren Befehl direkt testen: `website-stalker run gnome`.
`gnome` ist dabei der Filter, welche URLs ausgeführt werden sollen.

### RSS Feeds

Beispielsweise Hetzner hat keinen mir bekannten RSS-Feed für die [News](https://www.hetzner.com/news/).
Dafür kann der `website-stalker` auch direkt einen Feed erstellen.
Hier werden auch wieder CSS Selektoren benutzt um Items, Titel, Links und so weiter zu finden und zu nutzen (Details im [README]()).
Für Hetzner erstellt mein [öffentliches Konfigurations-Beispiel](https://github.com/EdJoPaTo/website-stalker-example) auch einen [Hetzner News Feed](https://raw.githubusercontent.com/EdJoPaTo/website-stalker-example/main/sites/com-hetzner-news.xml) mit folgendem Snippet:

```yaml
- url: "https://www.hetzner.com/news/"
    editors:
      - rss:
          item_selector: .list-card li
          title_selector: h4
          content_editors:
            - html_prettify
```

## Fazit

Mittlerweile ist mein `website-stalker` ein Begleiter im Alltag und neben RSS meine Quelle an Informationen und Neuerungen.
Für meinen Bedarf funktioniert das Tool schon echt gut und kann viele der generellen Anforderungen abdecken.
Wenn es da noch weitere Ideen gibt, wie das Ganze besser werden kann, gerne her damit!
Gerade für Editoren gibt es bestimmt noch Ideen oder Ansätze, die ich bisher nicht brauchte oder auf dem Schirm hatte.
Kommt dafür gerne auf mich zu, über die [GitHub Issues](https://github.com/EdJoPaTo/website-stalker/issues) oder über einen der hier Blog Footer referenzierten Wege.

Herunterladen kann man das Tool auf [GitHub](https://github.com/EdJoPaTo/website-stalker/releases), es ist aber auch im AUR verfügbar.
