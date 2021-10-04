---
title: Das Kalenderbot Backend zu Rust migrieren
date: 2020-09-11T22:53:00+02:00
background:
  name: Set me
  style: url(/assets/2020/09/wl-rain-rhododendron.jpg)
categories:
  - open-source
tags:
  - calendarbot
  - csharp
  - haw-hamburg
  - rust
  - typescript
---
In letzter Zeit wollte ich etwas Erfahrungen mit Rust sammeln.
Da der Kalenderbot relativ einfache, gut getrennte Komponenten mit klaren Interfaces hat, bietet sich dieser an.
Und so habe ich das Backend des Kalenderbots zu Rust migriert.
Der neue Downloader und Parser sind jeweils deutlich effizienter als ihre C# Vorgänger.
<!--more-->

# Bestehende Architektur

Der Nutzer interagiert mit dem Telegram Bot.
Dabei wählt dieser die Veranstaltungen aus, die später in seinem Kalender sein sollen.
Welche Veranstaltungen es gibt, lädt der Downloader herunter und speichert dies als JSON ab.
Der Parser nimmt sich die gewünschten Veranstaltungen und baut daraus einen Kalender für den jeweiligen Nutzer.

Zusätzlich kann ein Nutzer noch Veränderungen an Veranstaltungsterminen definieren.
Zum Beispiel "Termin beginnt später".
Diese werden ebenfalls vom Parser in den Kalender des Nutzers einbezogen.

Der Telegram Bot ist in JavaScript / NodeJS entstanden und wurde während dem Umstellen auf Rust ebenfalls zu TypeScript migriert.
Mit TypeScript arbeite ich schon länger und der Kalenderbot fehlte noch.
Damit konnte ich nun endlich auch neue Features meiner [telegraf-inline-menu](https://github.com/EdJoPaTo/telegraf-inline-menu) Library nutzen, für die vorher noch seltsame Workarounds existierten.
Was mir nun auch mehr Vertrauen in die Stabilität des Hinzufügens von Veränderungen an Terminen gibt.

Der Downloader und Parser existierten bis dahin in C# und wurden nun zu Rust migriert.

# Der Umbau

Begonnen habe ich mit dem Downloader, da dieser vergleichsweise einfach ist.
Es gibt wenig Randbedingungen, einfach nur alle 100 Minuten einen Haufen URLs herunter laden und als sinnvolle JSON speichern.

Dem bestehenden C# Parser ist egal, wer die JSON Dateien erstellt.
So kann ich bereits den Rust Downloader nutzen, während der C# Parser noch im Einsatz ist.

## Parser

Der Downloader arbeitet hauptsächlich mit http Requests und regulären Ausdrücken um die ICS Dateien zu finden und später die ICS Dateien zu lesen.
Beides war relativ einfach gemacht.

Was sich beim Entwickeln aber zum Problem heraus stellte, ist die Arbeit mit Zeitzonen.
Für Uhrzeiten gibt es in Rust das crate (Paket) [chrono](https://crates.io/crates/chrono).
(Was nebenbei ein Interessanter Aspekt von Rust ist, nicht alles grundsätzliche in der Standard Library haben zu wollen.)
Ich weiß nicht, ob die Dokumentation von chrono einfach nur nicht so ist, wie ich mir das so vorstellte oder ob ich da etwas schwer von Begriff war, immerhin bin ich relativ neu was Rust angeht, auf jeden Fall hab ich ein wenig gebraucht um genug zu verstehen wie chrono denkt, um irgendwie zum Ziel zu kommen.
chrono hat `DateTime` und `NaiveDateTime`. Ersteres beinhaltet Zeitzonen Informationen, wie UTC oder +02:00, die naive Variante weiß davon nichts.
Im Falle von ICS Dateien ist die Zeitzone extra angeben,
Die HAW verwendet immer Europe/Berlin, daher war mein Ansatz einfach immer die lokale Zeit zu verwenden.
Ich lese also die Zeit naiv ein und wandle diese dann in ein `DateTime` mit Zeitzone Local um.
Diese speichere ich dann nach RFC3339 in einem String um, der im JSON gespeichert wird.
Witzig wird es beim Einlesen dieses RFC3339 Strings, da dieser dann weder `DateTime<Local>` noch `DateTime<UTC>` ist, sondern ein `DateTime<FixedOffset>` was einen wieder vor das Problem des Umwandelns stellt.

Rückblickend betrachtet, nachdem ich auch den Parser gebaut habe, sollte ich wohl noch mal statt `Local` chrono-tz und `Berlin` verwenden.

Der neue Downloader ist nun auch etwas freundlicher gegenüber dem alten Downloader und wartet 200ms zwischen zwei Requests.
Damit haben die Server, von denen die ICS Dateien kommen, ein wenig mehr Luft zum Atmen, vor allem wenn auch noch andere Requests kommen.

## Downloader

Der Parser wirkt im ersten Gedanken auch relativ simpel: schauen wenn sich was ändert, dann die Config neu bauen und fertig.
Allerdings gibt es mehrere unterschiedliche Fälle.

Einer davon ist die Unterscheidung zwischen einer Änderung in einer userconfig oder einer Veranstaltung.
Ändert sich eine userconfig dann muss nur diese genutzt werden, um einen Kalender zu erstellen.
Ändert sich jedoch eine Veranstaltung, dann haben potenziell mehrere Nutzer diese Veranstaltung.
Der alte C# Parser hat sich alle Nutzer angeschaut und nur die Nutzer neu gebaut, die auch diese Veranstaltung haben.
Dies habe ich jetzt im Rust Parser weg gelassen, da ich zum Schauen, welche Nutzer neu gebaut werden müssten, eh die Config habe und diese dann auch einfach direkt bauen kann.

Ein anderer Fall ist der Kalenderdatei Suffix.
Der Suffix sorgt dafür, dass man nicht einfach den Kalender eines anderen Nutzers sehen kann, da die URL aus der eindeutigen Telegram ID erstellt wird.
Ändert der Nutzer diesen Suffix, so muss der alte generierte Kalender gelöscht werden (oder auf den neuen Dateinamen verschoben werden).
Früher war es auch möglich einfach keinen Suffix zu haben.
Da dies aber unsicherer ist und noch einen weiteren Fall bedeutet hätte, sorgt der Telegram Bot nun dafür, dass jetzt Nutzer auch einen Suffix hat.
Unsichere Kalender werden gar nicht erst mehr gebaut.
Privatsphäre per default gibt es also durch das Migrieren zu Rust auch gleich.

Jeder Nutzer hat seine privaten Änderungen an Veranstaltungsterminen.
Zu dieser Änderung muss der jeweilige Veranstaltungstermin gefunden werden und dieser existiert möglicherweise gar nicht mehr.
Änderungen können auch neue Termine hinzufügen, wieder ein anderer Fall.
Je nach der Einstellung des Nutzers verhalten sich gelöschte Veranstaltungen auch anders (unterschiedliche Tools interpretieren den STATUS CANCELLED unterschiedlich, Workaround dafür).

Das betrachten von Dateiänderungen wurde dank [notify](https://crates.io/crates/notify) unerwartet einfach.
Lediglich das beobachten von "irgendwas" in einem Ordner, wie es für die Veranstaltungen gebraucht wird, geht damit nicht out-of-the-box, ließ sich aber relativ einfach damit bauen.

Und nun läuft das Backend produktiv in Rust.

# Ressourcenauslastung

Zum Testen und vergleichen der neuen und alten Varianten habe ich aktuell beides laufen.
Die jeweiligen Inputs sind die selben, nur der Output geht bei der C# Variante in einen anderen, nicht produktiv genutzten Ordner.
Damit kann ich Outputs vergleichen und nachvollziehen, ob alles geht.

Ein netter Nebeneffekt ist, dass ich die beiden Tools jeweils unter gleichen Eingabebedingungen zur Laufzeit vergleichen kann.
Beispielsweise in htop kann ich RAM Nutzung und genutzte CPU Zeit auslesen.

In den beiden folgenden Screenshots von htop sind jeweils die beiden Tool Varianten, zuerst in Rust, dann in C# (=dotnet) zu sehen.
Die Screenshots wurden im Idle der jeweiligen Tools aufgenommen, der Downloader lädt nichts herunter und der Parser baut nichts.

![htop Screenshot Downloader](/assets/2020/09/htop-downloader-9h.png)
![htop Screenshot Parser](/assets/2020/09/htop-parser-9h.png)

Die RES Spalte spiegelt den RAM Verbrauch in kB wieder.
Der Rust Downloader belegt also 12MB RAM, während der C# Downloader 93MB RAM belegt.
Der Rust Parser belegt nicht mal 1MB RAM, im Vergleich zum C# Parser welcher 43MB belegt. MEM% ist die gleiche Aussage, nur prozentual relativ zum Host RAM (16GB).

Außerdem spannend ist die CPU Zeit, die die jeweiligen Tools bisher verwendet haben.
Alle vier Tools liefen zum Zeitpunkt der Screenshots etwa neun Stunden.
Dabei ist die Angabe in Minuten:Sekunden zu lesen, wobei die 3te Stelle der Millisekunden fehlt.
Der C# Parser hat also 8 Minuten und 33.33 Sekunden die CPU benutzt.

Der RAM Verbrauch von den Rust Tools ist deutlich geringer (⅑ beim Downloader, 1 43tel beim Parser).
Allerdings wundert mich, dass der Downloader so viel mehr RAM belegt als der Parser, da der Downloader 100 Minuten lang einfach nur genau nichts tut, also auch keine Ressourcen belegen müsste.

Besonders bedeutend fand ich die verwendete CPU Zeit der beiden Parser.
Ich vermute, dass der File Watcher in C# einfach sehr ineffizient arbeitet.
Ich hatte allerdings auch für das Alpine Image auf den Polling Watcher umgestellt, da ich Probleme mit nicht erkannten Änderungen hatte.
Möglicherweise ist das Problem gefixt, vermutlich ist der normale Watcher deutlich effizienter.
Aber auch der C# Downloader ist 6 mal CPU gieriger als seine Rust Variante.

Eine andere spannende Metrik ist die Größe der fertigen Container Images, die dann im Produktivsystem geladen und ausgeführt werden.
Im folgenden Screenshot sind nicht nur die Downloader und Parser aufgeführt, sondern auch noch der Telegram Bot und Mensa Crawler, um einen Vergleich mit NodeJS führen zu können.
Alle Images werden mit mehreren Stages gebaut, sprich erst werden die Sourcen zum Ergebnis gebaut und dann in dem Ziel Image nur noch die notwendigen Dinge hinterlegt.
Für NodeJS heißt das beispielsweise, dass Beispielsweise der TypeScript Compiler nicht im Image sind, obwohl diese für das Bauen in der ersten Stage benötigt wurden.
Das sorgt für kleinere Images.

![Größe der Images](/assets/2020/09/image-size.png)

Bei den Tags der Images ist 1 die "alte" C# Version und 2 die neue Rust Version.
In der dritten Spalte ist das jeweils benutze Basisimage und die verwendete Programmiersprache/Umgebung aufgeführt.
Auch hier ist Rust wieder vor C#.
Allerdings bin ich erstaunt, wie gut das C# Alpine Image ist.
Das NodeJS Alpine Image ist selbst schon seine 100MB groß, was die Größe der darauf basierenden Images erklärt.

Man darf allerdings bei den Images nie vergessen, dass diese in Layern aufgebaut werden.
In diesem Fall basieren 5 Images auf Alpine, sprich die unteren Alpine Layer sind gleich und existieren daher auf dem System auch nur einmal, nicht für jedes Image wieder.
Ähnlich mit den beiden NodeJS Alpine Images, die ebenfalls geteilt werden.

Und wo wir schon bei Metriken sind, Lines of Code:
Die beiden Rust Tools haben zusammen etwa 1400 LoC, die beiden C# Tools haben zusammen etwa 1200 LoC.
Das sagt allerdings nichts über die Lesbarkeit des Codes usw. aus.
Unterscheidet sich nicht signifikant und ist eine nicht so wichtige Metrik, von daher würde ich diese beim Vergleich vernachlässigen.

# Fazit

Das Migrieren zu Rust fing als Projekt an, um Rust programmieren zu üben.
Ich verwende sonst viel TypeScript, welches für mich mittlerweile sehr entspannt von der Hand geht, allerdings nicht unbedingt für seine Effizienz bekannt ist.

Ich hatte vorher gesehen, dass gerade der Parser viel CPU Zeit verwendet und ging schon davon aus, dass gerade dieser in Rust deutlich effizienter sein sollte.
Allerdings hatte ich nicht damit gerechnet, dass diese so viel effizienter sein würden.
Die kleinste Verbesserung, die benutzte CPU Zeit vom Downloader, bei dem die C# Variante das 6fache benötigt (alle anderen Verbesserungen sind deutlich größer!) ist schon signifikant.
Das ist nicht nur ein paar Prozente mehr heraus holen, sondern ein vielfaches mehr.

Tendenziell würde ich vermuten, dass C# generell effizienter sein sollte als NodeJS, allerdings ist die Chromium Engine auch extrem optimiert.
Auf meinem Server war der C# Parser immer eines der selbst geschriebenen Tool, welche ganz oben bei der verwendeten CPU Zeit zu finden waren.
Im Vergleich zum C# Downloader gibt es allerdings definitiv einige Telegram Bots, die mehr CPU Zeit nutzen.

Spannend mit diesem Projekt ist, dass damit das letzte meiner C# Tools in den Ruhestand geht.
C# war für mich die erste "richtige" Sprache, die ich auch für produktiv länger laufende Projekte eingesetzt habe.
Die andere aktuell von mir eingesetzte Sprache, TypeScript (und damit NodeJS) wird Rust allerdings vorerst nicht ablösen.
Für kleine Tools sicherlich, aber Größeres wie Telegram Bots laufen da schon sehr entspannt mit TypeScript.

[Ein](https://github.com/EdJoPaTo/network-stalker) [paar](https://github.com/EdJoPaTo/led-matrix-countdown) [kleine](https://github.com/EdJoPaTo/mpd-internetradio-destuck) Tools habe ich ja nun schon mit Rust gebaut und bin auch dort begeistert von Rust.
Mal sehen was die Zukunft bringt.
Vergessen werde ich Rust so schnell auf jeden Fall erst mal nicht wieder.
