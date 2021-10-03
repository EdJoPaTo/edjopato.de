---
background:
  name: Wolken
  style: url(/assets/2021/04/clouds.jpg)
date: 2021-04-11T15:10:00+02:00
title: Open Source Lizenzen
tags:
  - copyleft
  - foss
  - license
  - linux
  - nodejs
  - npm
  - rust
  - telegram
---
Ich habe mit der Zeit nun schon so einige Software Projekte, von denen nahezu alle Open Source auf GitHub sind.
Und eigentlich will ich auch, dass das so bleibt.
Bisher habe ich einfach überall die MIT Lizenz reingeworfen, aber geht das noch besser?
<!--more-->

Vorweg natürlich gesagt, ich bin definitiv kein Anwalt und verkünde hier nur mein Halbwissen.
Und ich lasse mich natürlich auch gern korrigieren, wenn ich hier Blödsinn von mir gebe. ;)

# Was gibt es überhaupt für Lizenzen?

Im Grunde gibt es die Unterscheidung zwischen "permissive" und "copyleft" Lizenzen.

Erste erlauben nahezu alles.
Man darf die Software / Library nutzen, in eigene Software einbauen, verändern, Geld damit machen, …

Copyleft Lizenzen erlauben dies im Grunde auch alles, haben dabei aber einen Haken.
Jegliche Veränderung und jegliche Software, die diese Software nutzt, muss ebenfalls unter einer gleichartigen Lizenz den Nutzern zur Verfügung gestellt werden.
Dadurch wird sichergestellt, dass eine Software auch Open Source weiter lebt.
Die Copyleft Lizenzen unterscheiden sich grob in ihrem Umfang, welchen sie abdecken.

Die "schwächeren" Copyleft Lizenzen verlangen das Veröffentlichen von Veränderungen und Erweiterungen, sobald man jemandem eine Kopie davon gibt.
Sprich, wenn man seine Veränderung nicht nur für sich selbst haben will.

Die "starken" Copyleft Lizenzen verlangen zusätzlich noch das Veröffentlichen von Software, die mithilfe der lizenzierten Software gebaut wurde (sobald man diese an Andere gibt).
Hat meistens den Nachteil, dass dies Firmen nicht unbedingt gefällt.

Ein Problem haben die "starken" Copyleft Lizenzen noch:
Ich muss die Software nur dann veröffentlichen, wenn ich diese an Andere weitergebe.
Baue ich beispielsweise ein Backend, dann kann dies tausende Zugriffe verarbeiten, ohne das jemand jemals die ausführbare Datei zu Gesicht bekommt.
Hierfür gibt es die Network Copyleft Lizenzen.
Diese werten eine Software bereits als "durch andere benutzt", wenn Andere beispielsweise über ein Netzwerk damit interagieren.
Ein Fork einer REST API muss also, sobald sie von jemandem zugegriffen werden kann, ebenfalls unter einer vergleichbaren Lizenz veröffentlicht werden.

# Beispiele für die jeweiligen Arten von Lizenzen

Der Linux Kernel ist als GPL, einer starken Copyleft Lizenz veröffentlicht.
Ich kann also den Kernel nehmen, anschauen, anpassen und muss dies nicht veröffentlichen.
Sobald ich aber jemandem von meiner coolen Verbesserung erzähle und diese weiter gebe, muss ich diesen Nutzern meiner Veränderung diese ebenfalls unter der GPL bereitstellen.

Eine Abschwächung der GPL gibt es mit der LGPL (früher Library GPL, jetzt Lesser GPL), welche eine schwächere Copyleft Lizenz ist.
Diese ist beispielsweise für Libraries gut, bei denen man will, dass die Library selbst Open Source bleibt.
Software die mit dieser Library entwickelt wird, muss allerdings nicht mehr mit dieser Lizenz veröffentlicht werden.

Nahezu identisch zur GPL existiert die AGPL, welche sich nur in einem Punkt von der GPL unterscheidet:
Die Software zählt bereits als genutzt, wenn sie über ein Netzwerk von Anderen genutzt wird.
Damit ist die AGPL eine Network Copyleft Lizenz.
Beispielsweise die Nextcloud ist als AGPL veröffentlicht.
Passe ich also meine Nextcloud an und nutze diese nur selber, muss ich diese Veränderung nicht veröffentlichen.
Gebe ich aber jemandem Zugriff auf meine Instanz, muss diese Veränderung an die Nutzer veröffentlicht werden.

Die MIT Lizenz beispielsweise ist eine "Permissive" Lizenz.
Diese sagt im Grunde nur aus, dass die Nutzer selber Schuld sind und damit so ziemlich alles machen dürfen, was für lustig befunden wird.

Eine recht gute Übersicht über noch mehr Lizenzen, die in die jeweiligen Kategorien fallen, gibt es [hier](https://blueoakcouncil.org/copyleft).

# GPL Version 2 und 3

Wenn man sich die aktuelle Lage anschaut, dann findet man immer wieder `GPL-2.0` und `GPL-3.0`, genau genommen meistens `GPL-2.0-only` und `GPL-3.0-or-later`.
Der Linux Kernel beispielsweise ist `GPL-2.0-only` und [Linus Torvalds ist auch nicht an der 3.0 interessiert](https://www.youtube.com/watch?v=PaKIZ7gJlRU).

Version 2 ist stark daran interessiert, dass Quellcode ein geben und nehmen ist und nicht nur genommen wird und Änderungen verschwinden.
Version 3 versucht, die Version 2 zu verbessern und einige Punkte strikter auszuformulieren.
Hier wird der Lizenztext deutlich länger und damit wohl auch deutlich komplexer.
Ein Hauptargument von Linus gegen die Version 3 ist der Zwang, das Hardware, welche die Software ausführt, auch in der Lage sein muss, Forks auszuführen.
Bei Version 3 muss also ein Gerät das Aufspielen von anderen Versionen erlauben, bei Version 2 ist dies nicht explizit gefordert.

Aus Nutzer Sicht ist die Version 3 damit noch mal besser, da sie noch mehr Freiheiten für den Nutzer bedeuten.
Firmen tun sich damit schwerer.

# Wie werden Lizenzen deklariert

Normalerweise wird der Lizenztext mit einer veröffentlichten Software mit ausgeliefert.
Auf GitHub liegt im Hauptordner eine `LICENSE` Datei, welche auch automatisch von GitHub gelesen und wenn bekannt, am Repository bereits die Lizenz markiert wird.
Veröffentlicht man Libraries auf beispielsweise [NPM](https://www.npmjs.com/) oder [Crates.io](crates.io), so muss die jeweilige Projektkonfigurationsdatei eine Lizenz beinhalten.
Bei NPM ist dies beispielsweise Freitext.
Bei crates.io muss die Lizenzdatei angegeben werden oder eine Bezeichnung aus der [SPDX Lizenzliste](https://github.com/spdx/license-list-data/tree/master/text) haben.

Software die beispielsweise im Arch Linux (User) Repository landen, haben ebenfalls ein Lizenzfeld in jeder Paketbeschreibung.

Zusätzlich sehen Lizenzen vor, dass diese in allen Quellcode Dateien erwähnt werden.
Persönlich finde ich dies aber als relativ viel Arbeit und "dont repeat yourself".
Ein Projekt hat eine LICENSE Datei oder eine Projektdatei, die dies bereits deklariert.
Wenn jemandem die Lizenz unklar ist, darf diese sowieso nicht so einfach genutzt werden und ich sehe es als nicht allzu schwer an, die Lizenz durch diese zwei Wege zu finden.

# Welche Lizenzen nutze ich jetzt?

In meinem Falle möchte ich, dass meine Software, die ich gerne der Allgemeinheit zur Verfügung stelle, auch weiterhin quelloffen bleibt, auch wenn diese von Anderen weiter entwickelt und verbessert wird.
Hierfür eignen sich die Copyleft Lizenzen gut.
Andererseits will ich auch, dass meine Libraries relativ frei benutzt werden können.
Eine starke Copyleft Lizenz würde dies definitiv einschränken.

Für meine Tools, die bei jemandem lokal ausgeführt werden, wie zum Beispiel [mqttui](https://github.com/EdJoPaTo/mqttui), nutze ich nun die GPL.
Diese ist verbreitet und erprobt.
Ich gehe auch nicht davon aus, dass interaktive Tools die zur Anzeige von Inhalten dienen (wie mqttui) in anderen Tools eingebunden werden.
Damit ist auch der Nachteil, den andere durch die GPL dadurch erhalten könnten, relativ gering.
Veränderungen und Verbesserungen werden aber durch die GPL veröffentlicht.
Im Idealfall hoffe ich natürlich auf Pull Requests, aber auch eigenständige Forks mit modifiziertem Ziel sind natürlich cool.

Meine Telegram Bots werden zwar benutzt, landen aber nie auf einem lokalen Rechner.
Damit wäre die GPL eher nutzlos.
Hierfür bedarf es einer Network Copyleft Lizenz wie der AGPL.
Allerdings ist nicht ganz klar, ob eine Benutzung über ein Telegram Client, welcher dann indirekt mit der Bot Implementierung kommuniziert, unter "Netzwerk" fällt und ob die AGPL bei Telegram Bots wirklich so greift.
Bei kleineren Telegram Bots ist mir das auch relativ egal, aber beispielsweise der [HAW HH Calendar Bot](https://github.com/HAWHHCalendarBot/TelegramBot) wird von einigen Hundert genutzt.
Wenn ich in Zukunft einfach keine Lust mehr habe und irgendwer den Bot übernimmt, wäre es trotzdem cool zu sehen, dass dieser weiterhin Open Source und für möglichst viele nützlich bleibt.

Libraries und Templates sind schon komplizierter.
Einerseits will ich, dass diese Open Source sind und bleiben, andererseits will ich auch, dass diese genutzt werden können.
Würde ich diese beispielsweise als AGPL lizenzieren, so müsste ich bereits einige selbst entwickelte Software, die ich aktuell nicht veröffentlicht habe, veröffentlichen.
Nur weil ich darin meine eigene Library verwende, interessiert sicherlich nicht jeden der Workaround, den ich nie anständig gemacht habe. ;)
LGPL wäre eine Überlegung wert, da hier nur Änderungen und Erweiterungen öffentlich bleiben müssten.
Die MIT ist jedoch auch deutlich simpler.
Hier bin ich mir noch nicht so recht im Klaren.

Auch fehlt mir noch die Unterscheidung zwischen den Permissive Lizenzen und ob die MIT an der Stelle so eine gute Wahl ist.

# Fazit

Auf meiner Suche nach besseren Lizenzen kam ich doch an einigen, für mich neuen Dingen vorbei.
Die Unterteilung in unterschiedliche Kategorien von Copyleft Lizenzen und das man Änderungen für sich selbst machen kann, ohne diese zu Veröffentlichen, waren für mich vorher relativ unbekannt.

So richtig sicher in meiner Wahl der Lizenzen bin ich mir zwar immer noch nicht so recht, aber ich weiß definitiv schon mal mehr als vorher.
Und wie eingangs schon erwähnt, wenn es noch interessante Details gibt, die ich vielleicht noch gar nicht weiß oder ich hier Blödsinn von mir gebe, teilt es mir gerne mit ;)
