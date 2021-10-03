---
background:
  name: Verschwörhaus Banner
  style: url(/assets/2019/03/ulm-verschwoerhaus-banner.jpg)
date: 2019-03-01T01:50:00+01:00
title: Wikidata Workshop Ulm
tags:
  - wikidata
  - ulm
  - telegram
---
Am Wochenende war ich auf dem Wikidata Workshop in Ulm.
Da ich mich woher nicht wirklich mit Wikimedia Dingen befasst habe, gab es so einiges Spannendes, Neues für mich.
Und ich habe mit Wikidata ein kleines Telegram Spiel gebaut.
<!--more-->

Durch ein paar Pullrequests zum [Circuit Generator zum 35c3](https://github.com/bleeptrack/35c3-circuit-generator) kam ich mit Bleeptrack ins Gespräch, die mir von diesem [Workshop](https://de.wikipedia.org/wiki/Wikipedia:Wikidata-Workshop-Ulm-2019) erzählte.
Da Wikimedia Anreise, Hotel und Verpflegung bezahlt, dachte ich mir, mal gucken was ich Neues lerne und fahre einfach mal nach Ulm.

# Was ist Wikidata?
[Wikidata](https://www.wikidata.org) ist der Versuch, all die Informationen, die auf Wikipedia zur Verfügung stehen, sprachunabhängig anbieten zu können.
Dabei stehen die Elemente alle in Kontext zueinander.
So ist ein [Tesla S](https://www.wikidata.org/wiki/Q1463050) ein [Elektroauto](https://www.wikidata.org/wiki/Q193692), welches ein [Fortbewegungsmittel](https://www.wikidata.org/wiki/Q42889) ist, welches wiederum ein [Werkzeug](https://www.wikidata.org/wiki/Q39546) ist, …
Identifiziert werden die Einträge dabei über Q-Nummern wie diese: [Q193692](https://www.wikidata.org/wiki/Q193692).

Spannend dabei fand ich, das die Tabelle, die auf vielen Wikipedia Seiten auf der rechten Seite zu sehen ist, sprachunabhängig aus Wikidata gefüttert wird.
Sobald also ein neuer Bürgermeister aktiv wird und dies auf Wikidata hinterlegt ist, haben alle Wikipedia Artikel, egal welche Sprache, diese Änderung.

Um Wikidata abzufragen, kann SPARQL verwendet werden.
So gibt es auch einen [Editor](https://query.wikidata.org/#SELECT%20%3Fitem%20%3FitemLabel%20WHERE%20%7B%0A%20%20%7B%20%3Fitem%20wdt%3AP31%20wd%3AQ193692.%20%7D%0A%20%20UNION%0A%20%20%7B%20%3Fitem%20wdt%3AP279%20wd%3AQ193692.%20%7D%0A%20%20SERVICE%20wikibase%3Alabel%20%7B%20bd%3AserviceParam%20wikibase%3Alanguage%20%22%5BAUTO_LANGUAGE%5D%2Cen%22.%20%7D%0A%7D), in dem die Queries mal eben ausprobiert werden können.

Die meisten Einträge können von jedem editiert werden.
Wenn einem also auffällt, das etwas fehlt, oder mittlerweile anders ist, kann dies entsprechend nachgetragen werden.
So hat zum Beispiel eine Kleingruppe auf dem Workshop die Politiker im Bundestag aktualisiert, welche nicht mehr im Bundestag sind oder Informationen zu diesen hinzugefügt.

# Der Workshop

Der [Workshop](https://de.wikipedia.org/wiki/Wikipedia:Wikidata-Workshop-Ulm-2019) selbst ging über 3 Tage von Freitag Nachmittag bis Sonntag Mittag.
Dabei fand er im [Verschwörhaus](https://www.wikidata.org/wiki/Q27945856), dem Ulmer Hackerspace statt.

![Automat im Verschwörhaus](/assets/2019/03/ulm-verschwoerhaus-automat.jpg)
Unter Anderem steht im Verschwörhaus auch dieser Automat.
Man kann dort Dinge, wie auch Raspberry Pis kaufen.
Der zweite Käufer kriegt dann allerdings den 6x schnelleren Raspberry Pi 2.
Fun Fact: Der Automat akzeptiert bis zu 2€ Münzen…

Es gab einige [Vorträge](https://www.youtube.com/playlist?list=PLRJOWz6dYKtEFA6hSHliGyRXWdbgs2cGO) zu verschiedenen Themen, zu denen ich aber eher die Einführungen angesehen habe.

Als Namensbadge und Gesprächsstarter hat Bleeptrack [generative Badges](https://chaos.social/@bleeptrack/101637293852959794) auf Basis eines Fragebogens erstellt.
So hatte jeder eine individuelle Badge, aus welchem Kontext man kommt (Jugend hackt, Open Knowledge Foundation, …), ob man Kaffee, Tee oder Kakao bevorzugt usw.

Generell war die Atmosphäre super.
Vor allem am zweiten Tag war ein geselliges vor sich hin basteln angesagt.
Es gab auch eine [Stadtführung von Nicht-Ulmern für Nicht-Ulmer](https://chaos.social/@fluxx/101641534158378281) oder ein nicht aufgezeichneter [Vortrag über Lizenzen](https://chaos.social/@fluxx/101647583230179999), der wohl unter anderem auch deswegen so super wurde, weil er nicht aufgezeichnet wurde.

# Wikidata Misfit (Telegram) Bot

Im Rahmen des Workshops sind mehrere Dinge entstanden, so unter anderem auch ein generiertes [Wikidata Kartenspiel](https://cardgame.morr.cc/), welches ich ziemlich cool finde.
So ist auch von mir ein kleines Telegram Minispiel entstanden: Der [Wikidata Misfit Bot](https://t.me/WikidataMisfitBot).

Der Bot schickt einem dabei 4 Bilder, eines davon passt nicht zu den Anderen.
Dabei wird zuerst zufällig eine Unterkategorie gewählt, die unter der Wahl des Nutzers liegt.
Wählt ein Nutzer zum Beispiel 'Fortbewegungsmittel', so kann zufälligerweise die Oberkategorie 'Elektroauto' kommen.
Dazu werden dann zufällig zwei Kategorien gewählt, aus der einmal die 3 zusammen gehörigen Bilder und einmal ein anderes Bild gewählt wird.

![Beispiel Misfit Bot](/assets/2019/03/misfit-example.png)

Je nach dem, was der Zufall macht, wird dies einfacher oder schwerer.
Ich kann zum Beispiel keine 4 Ladenfronten mit japanischen Schriftzeichen voneinander unterscheiden.
Die oben zu sehenden Katzen kriege ich aber vom Hund unterschieden. ;)

Schön an der ganzen Sache ist auch, dass Telegram Bots die eingestellte Sprache des Telegram Clients des Nutzers auslesen können.
Anhand dieser wird die passende Sprache in Wikidata für die Labels verwendet.
So hat sich bereits ein Indonesier darüber gefreut, dass der Bot indonesisch mit ihm spricht.
(Und auf meinen Vorschlag auch einige indonesische Übersetzungen zu Wikidata hinzugefügt.)

Der Quellcode ist auf [GitHub](https://github.com/EdJoPaTo/wikidata-misfit-bot) zu finden.
