---
title: Rain Brainz - Eigene Bilder simpel präsentieren
date: 2021-12-31T15:40:00+01:00
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - photos
  - web
  - website
---
Ich mache immer mal wieder Bilder und überlege schon seit Ewigkeiten, wie ich diese präsentieren könnte.
Hier im Blog gibt es schon lange Bilder für einzelne Posts, aber die sind nicht unbedingt als Bildersammlung geeignet.
Auf Dienste im Besitz großer Firmen hatte ich keine Lust.
Eine Überlegung war [Pixelfed](https://pixelfed.org/) zu nutzen, welches genau wie Mastodon auf ActivityPub un Dezentralität setzt.
Vor einer ganzen Weile schon bin ich über [die Galerie von Leah](https://chaos.social/@leah/104065853551741116) gestoßen, welche komplett in HTML und CSS selbst gebaut ist.
Und so kam es nun dazu, dass ich mir etwas ähnlich simples gebaut habe.

<!--more-->

Ziel meiner eigenen kleinen Webseite für Bilder war es, möglichst simpel und Effizient zu sein, ohne größere Frameworks.
Auch wollte ich static content haben, welcher einmalig generiert wird und dann nur noch ausgeliefert werden muss.
Das funktioniert mit minimalen Server und Client Ressourcen.

Dabei brachte mich die Umsetzung von Leah auf die [CSS Pseudo-Klasse `:target`](https://developer.mozilla.org/en-US/docs/Web/CSS/:target).
Im verlinkten Mozilla Developer Eintrag ist sogar ein Beispiel für eine "Pure-CSS lightbox".
Das ganze kombiniert mit Flexboxen und ein wenig CSS ergibt eine Webseite, die auf kleinen und großen Geräten, bei Tag und Nacht gut benutzbar ist.

Um die Bilder in einer für das Web angemessenen Form bereitzustellen werden alle Bilder mit ImageMagick zu WebP gewandelt und verkleinert.
Auf das Konvertieren von Inhalten gehe ich in [diesem Blogartikel]({{< relref "/post/2021/11/02/convert-everything" >}}) näher ein.
Ein Skript generiert nun die HTML Seite und konvertiert alle Bilder passend.
Im Anschluss wird das Ergebnis per rsync auf einen Server geschoben und ist nun unter [rain-brainz.de](https://rain-brainz.de/) erreichbar.
Der generierende Quellcode ist ebenfalls öffentlich auf [github.com/EdJoPaTo/rain-brainz.de](https://github.com/EdJoPaTo/rain-brainz.de), man kann jedoch aus meiner Sicht auch den Ergebnis-Quellcode gut im Browser ansehen.

Vielleicht baust du dir ja auch eine kleine Bildergalerie nach.
Oder hast Ideen oder Vereinfachungen für meine Bildergalerie.
Vielleicht erfreust du dich aber auch einfach nur an meinen Bildern.
Du wärst nicht die erste Person, die meine Bilder als Bildschirmhintergrund nutzt.
