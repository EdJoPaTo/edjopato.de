---
background:
  name: Steinstufen nach dem Regen
  style: url(/assets/2020/09/wl-rain-steps.jpg)
date: 2021-06-13T18:16:00+02:00
title: RSS lesen synchronisieren mit Miniflux
tags:
  - desktop
  - foss
  - linux
  - news
  - phone
  - pine64
  - pinephone
  - rss
  - smartphone
---
Seit einer Weile [lese ich meine RSS Feeds auf dem PinePhone via NewsFlash]({{< relref "../2021/04-08-pinephone-rss-reader.md" >}}).
Das funktioniert erstaunlich gut.
Vor ein paar Tagen kam ich darauf, dass YouTube (und Invidious) ebenfalls Atom Feeds bereitstellt, über die man sich seine Subscriptions abbilden kann.
Nur schaue ich meine Videos eher nicht am Handy.
Also muss eine Synchronisierung her, damit ich beides sowohl am PC als auch am Handy nutzen kann.

Ich dachte mir also, werd ich mir wohl mal irgendeinen spooky Anbieter suchen und NewsFlash über eben diesen synchronisieren.
Damit das hinterher auch gut funktioniert, habe ich mir angeschaut, mit welchen Diensten synchronisiert.
Im [Repo ist eine Liste](https://gitlab.com/news-flash/news_flash_gtk#looking-for-service-maintainers), welches Plugin einen Maintainer hat.
"Local RSS" ist ja quasi das normale benutzen ohne Sync.

Der erste Eintrag in der Liste ist Miniflux, wozu das Plugin ebenfalls vom Hauptentwickler unterstützt wird.
Beim genaueren Betrachten von Miniflux stellte ich fest, das ist ja zum selber hosten.
Miniflux ist im Grunde recht minimalistisch, in Go geschrieben und damit eine Single-Binary, minimalistisches HTML, Vanilla ES6 JavaScript, als [12 Faktor Anwendung](https://12factor.net/) entwickelt.
Klingt cool, das Einzige, was mich noch stört, ist die Datenbank (Ich bin immer noch kein Fan von Datenbanken).
Also mal ausprobieren.
Das offizielle Container-Image mit dem Beispiel Compose File genommen und mal gestartet.

Alles funktioniert simpel, dass Einrichten ging schnell über die opml Datei.
Die opml Datei brauche ich sowieso und habe ich in einem Git Repo gespeichert, da ich mein PinePhone, jedes Mal, wenn ich ein anderes Image ausprobiere, ja quasi zurücksetze.
(Ich habe "keine"  Backups, ich habe Git Repos.)
NewsFlash muss man zum Nutzen eines anderen Services (statt dem bisherigen "Local RSS") einmal resetten.
Danach wird einfach Server, Benutzername und Passwort angegeben.
Das funktionierte auch direkt.
NewsFlash funktioniert dann genauso, nur das alles im Netzwerk passiert.
Wenn ich einen Post als gelesen markiere, dann wird dies automatisch mit MiniFlux online synchronisiert.
Geht natürlich nur, wenn man Internet hat.
Alles Andere bleibt gleich.

Die Weboberfläche ist, wie schon erwähnt, simpel gehalten und reagiert sehr schnell auf alles.
Schneller, als so manch eine lokale Anwendung.
Ein Segen, wenn man sonst einige "moderne" Web Anwendungen zur Arbeitszeit benutzen "darf".

Ein bisschen ungewohnt war die Sortierung "alt nach neu" zuerst, allerdings macht diese meistens Sinn.
Wenn Dinge zeitlich aufeinander aufbauen, dann ist vorn anfangen schon gar nicht so doof.

Beim Stöbern durch die Einstellungen bin ich auf die Liste an Environment Variablen gestoßen.
Wie es sich für eine 12factor App gehört, können die Einstellungen so schon getätigt werden.
Wenn ich also eine Einstellung suche, dann ist die hier perfekt aufbereitet zum Ändern mit dem aktuellen Wert hinterlegt.
Sehr entspannt, wenn man das Ding selber hostet.

Cool ist dann auch die Progressive-Web-App: Am Handy kann ich die Webseite auf dem Home Bildschirm ablegen.
Benutzt werden kann diese dann wie andere Apps und auch schneller als so manch andere App, trotz des Pings zum Webserver.
Irgendwie schon traurig, dass gute Anwendungen einmal halb durch Deutschland schneller sind, als Andere, lokal installierte…

Meine Backup opml in dem Git Repo kann ich weiterhin aus NewsFlash oder auch Miniflux exportieren.
Wenn die Datenbank also abrauchen sollte, dann sind keine Daten in Gefahr (abgesehen vom Lesestatus).

Im Grunde brauche ich die Webseite nicht zu benutzen.
NewsFlash arbeitet weiterhin wie ich es gewohnt bin, nur eben jetzt mit Synchronisation.
Aber dafür funktioniert die Webseite einfach zu gut.
Wenn ich also auf einem nicht Linux Gerät ohne NewsFlash bin und mal Feeds lesen will, warum also nicht Miniflux.
Damit habe ich, im Gegensatz zu meiner ersten Annahme, keinen spooky RSS Feed Dienst gefunden, sondern einen ziemlich coolen, minimalistischen, welcher auch noch ziemlich entspannt zu benutzen und warten ist.
Und das macht Lust auf eigens entwickelte kleine Webanwendungen, die ja, mal wieder bewiesen, besser sein können, als die meisten Software Schmieden einem das vormachen.
