---
background:
  name: Schlossteich in Winsen
  style: url(/assets/2020/06/wl-schlossteich.jpg)
date: 2020-06-18T17:55:00+02:00
title: Wie machst du eigentlich - Browser
categories:
  - how-do-i
tags:
  - arch-linux
  - browser
  - firefox
  - ios
  - macos
  - safari
  - web
  - windows
---

Wie benutze ich eigentlich meine(n) Browser?
<!--more-->

Letztens wurde ich immer mal gefragt, wie machst du eigentlich X.
Darum dachte ich mir, schreibe ich mal darüber Blog Artikel, die kann dann jeder lesen.
Da ich sowohl Arch Linux, macOS, Windows und iOS/iPadOS im Einsatz habe und auch regelmäßig alle Systeme verwende, habe ich wohl einen relativ guten Überblick über die jeweiligen Situationen auf den unterschiedlichen Plattformen.
Wissen tue ich aber definitiv nicht alles und freue mich immer über Tipps und Tricks.

Anfangen will ich mit dem Browser, was ja ein zentraler Bestandteil für die meisten Leute ist.

Ich persönlich nutze Firefox als meinen Haupt Browser auf Arch Linux, macOS und Windows. Außerdem habe ich noch Chromium als Zweit-Browser auf Arch Linux und macOS installiert, da dieser mit WebRTC (Jitsi & BigBlueButton) aktuell leider noch besser klar kommt.

# iOS / iPadOS

Unter iOS/iPadOS verwende ich aktuell einfach Safari, ist dabei, funktioniert.

Zusätzlich habe ich noch [Ka-Block!](https://apps.apple.com/de/app/ka-block/id1037173557) als Content Blocker installiert und lösche unregelmäßig mal die "Website Data" (Settings → Safari → Advanced → Website Data → Remove All Website Data).
Damit bleibt meine History erhalten aber ich hoffe Tracker etwas mehr los zu werden.

Das wars schon für Safari unter iOS / iPadOS.

# Suchmaschine
Als Suchmaschine verwende ich überall seit Jahren DuckDuckGo.
Vielleicht ist Google besser und ich weiß es nur einfach nicht, vielleicht habe ich mich auch einfach an DuckDuckGo gewöhnt, auf jeden Fall finde ich meistens was ich suche.

Zudem nutze ich die ["Bangs"](https://duckduckgo.com/bang) von DuckDuckGo ganz gerne.
Wenn ich zum Beispiel auf YouTube suchen will, gebe ich einfach "!yt cat" ein und lande in der YouTube suche nach Katzenvideos.
Wenn ich auf Wikipedia suchen will, nutze ich einfach "!w" oder "!wde" für die englische oder deutsche Wikipedia oder "!wd" um auf Wikidata zu suchen.
Wenn ich häufiger auf einer Webseite suchen will, schaue ich irgendwann nach dem passenden Bang und merke ihn mir dann.
Wenn ich ihn mir nicht merken kann, benutze ich diesen wohl auch nicht häufig genug.

Firefox bietet soetwas ähnliches mit Keywords von eingebauten Suchmaschinen an, allerdings müsste ich dafür den Browser auf jedem Gerät wieder einstellen.
DuckDuckGo hat bereits eine relativ große Datenbank an möglichen Bangs und ich kann diese auch an Rechnern benutzen, an denen ich das erste Mal arbeite (z.B. mal eben an einem an der Hochschule).

# Generelle Einstellungen

Generell stelle ich meinen Firefox so ein, das beim Beenden jegliche History gelöscht werden soll.
Damit ist mir klar, was danach noch gespeichert ist und was möglicherweise beim nächsten Mal noch auf die Session einwirken könnte: gar nichts.

Ich kann also zum Beispiel ganz entspannt auf Amazon nach etwas suchen, den Browser schließen und beim nächsten Öffnen sind die Amazon Vorschläge nicht voll davon.

Ich lasse die meisten Firefox Einstellungen bei den default Einstellungen, welche ich aber ändere sind diese:

## Home
- New Windows and Tabs → both → "Blank Page"

  Die Firefox eigene Home Seite hat für mich keinen Benefit und ist zudem noch grell weiß.
  Mit der blanken Seite wird scheinbar auch gleich der passende System Theme mit angewendet und der neue Tab ist tagsüber hell und nachts dunkel.

## Search

- Default Search Engine → DuckDuckGo

## Privacy & Security
- Enhanced Tracking Protection → Strict

  Damit hatte ich bisher keine Probleme, warum also nicht aktivieren.

- Cookies and Site Data → Delete cookies and site data when Firefox is closed → aktivieren

- Logins and Passwords → Ask to save logins and passwords for websites → deaktivieren

- History → kommt drauf an:
	-	Wenn die Erweiterung Temporary Containers nicht verwendet wird:
		-	Firefox will "Never remember history"
	-	Wenn die Erweiterung Temporary Containers verwendet wird:
		-	Firefox will "Use custom settings for history"
		-	Always use private browsing mode → deaktiviert lassen
		-	Clear history when Firefox closes
		-	Settings… → alles aktivieren

# Lesezeichen / Bookmarks

Das ist einfach, ich verwende keine Lesezeichen in Browsern.

Da ich mehrere Geräte verwende und die Browser nicht synchronisiere, müsste ich die Bookmarks überall pflegen.
Stattdessen verwende ich bereits anders geteilte Stellen, wie geteilte Ordner oder Telegram "Gespeicherte Nachrichten" für kurzzeitig relevantes.
Längerfristig relevantes gibt es entweder nicht oder ist eine Quelle für etwas, dann ist sie an dieser Stelle auch als Quelle aufgeführt.

Da beim Schließen meiner Browser auch alle Tabs verschwinden, lasse ich auch keine Tabs "ewig offen".

# Erweiterungen

Bei Erweiterungen versuche ich sparsam zu sein, vor allem mit Erweiterungen die Zugriff auf alle Webseiten bekommen.
Hier muss man beachten das derartige Erweiterungen auch Passwort Felder sehen und lesen können.
Es ist in der Vergangenheit durchaus vorgekommen, dass Erweiterungen Passwörter mitgelesen und weg gegeben haben.
Relativ bekannt sind dafür die Netflix Erweiterungen, die Netflix Passwörter gesammelt haben.

Also einmal mehr drüber nachdenken, was man sich da gerade installiert und wie viele Rechte dies wirklich braucht.

In meinem Fall sind alle Erweiterungen Open Source und auf GitHub zu finden.

## uBlock Origin

[uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) ist ein Ad-Blocker den ich einfach installiere und dann läufts.
Das sorgt für weniger nervige Werbung und weniger nervige Ressourcenfresser.

Auf Arch Linux installiere ich diesen auch gleich mit über pacman aus dem Repo, sodass ich mich beim Einrichten des Browsers auch nicht mehr um diese Basis Erweiterung kümmern muss.
Wird der Rechner auch noch von anderen genutzt, dann ist diese Erweiterung auch auf den anderen Nutzer Accounts schon vorhanden.

Ich hatte bisher auch noch nicht das Problem mit zu viel oder zu wenig geblockten Dingen.
Wenn mal irgendetwas nicht geblockt war, was ich erwartet hätte, aktualisiere ich mal eben die Blocklisten und danach läuft alles.

## uMatrix

[uMatrix](https://addons.mozilla.org/en-US/firefox/addon/umatrix/) ist eine relativ mächtige Erweiterung, mit der sich Netzwerk Anfragen bestimmter Dinge von bestimmten Domains blockieren lassen.

Wenn du deinen Browser einfach nur benutzen willst oder dich mit Web Technologien (noch) nicht so gut auskennst, überlege dir zwei Mal ob diese Erweiterung etwas für dich ist.
Allerdings lernt man auch eine ganze Menge, wenn man sie verwendet.

Der Grundgedanke dieser Erweiterung ist das Blockieren bestimmter Inhalte (Spalten) von der jeweiligen Domain (Zeilen), daher auch der Name Matrix.
Wenn eine Webseite aufgerufen wird, lädt diese von ihrer eigenen Domain und möglicherweise auch von dritten Domains Informationen nach.
Dies können Bilder sein oder auch Scripte, Fonts, Videos, Daten, ….
Wenn eine Webseite also zum Beispiel ein YouTube Video einbettet, dann werden Informationen von YouTube nachgeladen und diese dann auch in uMatrix angezeigt.

Ich werde an dieser Stelle keine Einführung in uMatrix bringen können, aber ich kann meine Regeln, nachdem mein Firefox erlaubt und blockiert, hier verlinken: [µMatrix Rules](https://gist.github.com/EdJoPaTo/62b4636d1d7c77a8f822b2bb1a583c9e).
Diese aktualisiere ich regelmäßig und sind erstmal nur für das Betrachten und Nutzen von Webseiten ausgelegt, ohne sich dabei auf diesen anzumelden.

## Temporary Containers

[Temporary Containers](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/) denken den Gedanken, wenn ich es zumache hat es auch wirklich alles vergessen, einen Schritt weiter.

Ich verwende dabei den "Automatic Mode" und habe die Random Container Color aktiviert.
Zudem habe ich noch "Container Number → Reuse available numbers" und "Delete no longer needed Temporary Containers -> After the last tab in it closes" aktiviert, damit die Nummern nicht all zu groß werden.

Wenn ich einen neuen Tab öffne, dann ist dieser in einem neuen, unabhängigen Container.
Alle Cookies und Webseiten Daten sind in diesem Container und wirken sich nicht auf andere Container aus.
(Erweiterungen wie uMatrix sind aber unabhängig und haben überall die selben Einstellungen)
Ich kann also einfach einen weiteren Tab aufmachen ohne das der Erste davon etwas mitbekommt.
So kann ich beispielsweise einmal angemeldet und einmal nicht angemeldet sein oder um das Beispiel von vorhin nochmal zu verwenden, etwas auf Amazon suchen ohne das danach überall etwas davon zu sehen ist.

Wenn ich zum Beispiel einen Link aus Telegram heraus öffne, wird dieser automatisch in einem neuen, temporären Container geöffnet.
Wenn ich diesen jetzt zum Beispiel in einem Container brauche, zum Beispiel weil ich in einem anderen Container bereits in GitHub angemeldet bin, dann kann ich auf diesen Tab rechts klicken und "Reopen in container" auswählen.

# Fazit

Ich vermute das ich mit meinem Ansatz "der Browser vergisst alles" relativ alleine stehe, aber für mich funktioniert das ganze relativ gut.
Es hat für mich vor allem den Vorteil das ich mich um nicht viel Gedanken machen muss.
Was weg ist, ist weg.

Vielleicht habe ich etwas vergessen hier zu erwähnen.
Vielleicht hast auch du noch gute Tipps für mich?
Vielleicht wünschst du dir auch noch die Beantwortung der Frage "Wie machst du eigentlich" zu einem anderen Thema?
Schreib mir einfach dazu eine Nachricht.
Wie du mich erreichst, siehst du im Footer.
