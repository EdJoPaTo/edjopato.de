---
title: Browser Erweiterungen
date: 2021-06-29T18:42:00+02:00
resources:
  - name: cover
    src: hh-skyline.jpg
    title: Hamburger Skyline aus Sicht einer Elbfähre
categories:
  - how-do-i
  - open-source
tags:
  - linux
  - macos
  - privacy
  - web
  - windows
---
Vor über einem Jahr habe ich meinen [Blogpost, wie ich Browser verwende]({{< relref "/content/post/2020/06-18-browser.md" >}}), schon geschrieben.
Da sich seit dem schon einiges getan hat, könnte ich Mal wieder vom aktuellen Stand berichten.
Ich habe damals versucht, alles in einem Blogpost zu behandeln, aber es bietet sich an, dies ein wenig aufzuteilen.
Hier also ein Überblick über meine aktuellen Browser Erweiterungen im Firefox.
<!--more-->

**Edit 22:34**:
- Privacy Badger entfernt
- LocalCDN zu Decentraleyes hinzugefügt
- Links zu Chrome, Edge und Opera hinzugefügt

Allgemein muss man vielleicht noch einmal sagen: Erweiterungen können in der Lage sein, jeglichen Browserverlauf und Inhalt einzusehen.
Und damit auch sensible Informationen wie Passwörter oder Interessen!
Grundsätzlich sollte man immer schauen, ob man einer Erweiterung vertraut und im Zweifel heißt es immer, je weniger, desto besser.
Persönlicher Ansatz: Wenn es von der Erweiterung offenen Quellcode gibt, dann kann der Quellcode der Erweiterung im Store zwar immer noch anders sein, aber es ist schon mal ein gutes Indiz, dass dieser nicht komplett spooky ist.
Ein anderes Indiz ist die Markierung als "Recommended", welche nur an von Mozilla geprüfte Erweiterungen verteilt wird.

# Hintergrund Erweiterungen

Zuerst die Erweiterungen, die man einfach installieren kann und dann laufen diese, ohne irgendwas weiter zu tun, im Hintergrund mit und verrichten ihren Dienst.
Diese würde ich eigentlich jedem empfehlen.

## uBlock Origin

uBlock Origin (Achtung, nicht "uBlock"!) ist ein Content Blocker.
Dieser entfernt hauptsächlich Werbung.

Hier muss ich mich aber noch mal mehr mit befassen, uBlock hat mittlerweile mehr Features, als noch vor einigen Jahren und da sind einige Gute hinzugekommen.
Unter anderem das Erkennen von CNAME DNS Einträgen auf CDNs und Tracker (was immer häufiger wird), finde ich spannend.
Habe ich mir aber noch nicht angeschaut, steht auf meiner TODO-Liste.

Aber im Grunde: Installieren, läuft.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
- [addons.opera.com](https://addons.opera.com/en/extensions/details/ublock/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/odfafepnkmbhccpbejgmiehpchacaeak)
- [Sourcecode](https://github.com/gorhill/uBlock)

## ClearURLs

Häufig enthalten URLs etliche, zusätzliche Parameter, wie Referenzen, woher man den Link hat usw.
Diese werden vom Anbieter genutzt, um Tracking zu betreiben.
Kommst du von einem Newsletter?
Hat dir eine Freundin diesen Link gegeben und du hast dieselben Parameter im Link, wie sie schon hatte?

All diese Informationen löscht ClearURLs aus den URLs heraus.
Und sorgt dabei auch gleich für kürzere, weniger nervige URLs.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/mdkdmaickkfdekbjdoojfalpbkgaddei)
- ~~addons.opera.com~~
- [Sourcecode](https://gitlab.com/KevinRoebert/ClearUrls)

## ~~Privacy Badger~~

Leserkommentar:
uBlock Origin tut bereits, was Privacy Badger verspricht.
Weniger Erweiterungen sind besser, also keine Empfehlung mehr.

- [Sourcecode](https://github.com/EFForg/privacybadger)

## Decentraleyes / LocalCDN

Viele übermäßig große Webseiten verwenden Content Delivery Networks um diese zu groß gewordenen Webseiten nicht mehr vollständig selber ausliefern zu müssen.
Das hat den Vorteil, dass diese CDN weltweit verteilt und dichter am Nutzer sein können.
Dies hat aber auch den Nachteil, dass diese genau wissen, für welche Webseiten sie gerade Dinge ausliefern, die Nutzer also Nachverfolgen können.

Decentraleyes oder LocalCDN stellen Ressourcen aus CDNs lokal bereit.
Dafür wird, wenn Inhalt benötigt wird, dieser einmal in einer Variante ohne [Referer](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referer) erfragt.
Das CDN kann also nicht mehr allzu viel damit anfangen.
Diese werden danach lokal bereitgestellt.
Da CDNs statischen Content bereitstellen, der sich nicht häufig ändert (dank Versionierung meistens sogar nie), können diese auch gut lokal zwischengespeichert werden.

Leserkommentar:
LocalCDN ist ein Fork von Decentraleyes.
Beide haben dasselbe Ziel nur unterschiedliche Maintainer.
Persönlich nutze ich Decentraleyes, weil diese Erweiterung in den Arch Linux Repositories verfügbar ist.
Für eine brauchbare Aussage müsste ich jedoch beide Varianten vergleichen, was ich bisher nicht getan habe.

Decentraleyes
- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/)
- [addons.opera.com](https://addons.opera.com/extensions/details/decentraleyes/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/decentraleyes/ldpochfccmkkmhdbclfhpagapcfdljkj)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/lmijmgnfconjockjeepmlmkkibfgjmla)
- [Sourcecode](https://git.synz.io/Synzvato/decentraleyes)

LocalCDN
- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/localcdn-fork-of-decentraleyes/)
- ~~addons.opera.com~~
- ~~chrome.google.com~~
- ~~microsoftedge.microsoft.com~~
- [Sourcecode](https://codeberg.org/nobody/LocalCDN)

## GNOME Shell integration

Wenn man als Desktop Umgebung Gnome (oder ein Derivat, wie im Falle von Ubuntu) verwendet, dann kann man Gnome Erweiterungen über [extensions.gnome.org](https://extensions.gnome.org/) installieren.
Damit der Browser dies kann, benötigt man diese Browsererweiterung und auf dem System die "chrome-gnome-shell".

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep)
- ~~addons.opera.com~~
- ~~microsoftedge.microsoft.com~~
- [Sourcecode](https://gitlab.gnome.org/GNOME/chrome-gnome-shell)

# Kleine Helferlein

Neben den Erweiterungen, die ich einmal installiere und dann vergesse, gibt es noch kleine Tools, welche Aufgaben "auf Anforderung" erfüllen und welche ich immer mal wieder aktiv benutze.

## Dark Reader

Abends sind einige Webseiten schon etwas hell.
Mit ein wenig angepassten Styles ändert diese Erweiterung Webseiten zu einem dunklen Theme.
Definitiv nicht perfekt und eigentlich wäre ein nativer dunkler Modus der jeweiligen Webseite besser, aber häufig gibt es den nicht.
Und dafür ist diese Erweiterung großartig.

Ich persönlich habe eingestellt, dass diese dem System Theme folgt, sprich tagsüber hell und nachts dunkel.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/darkreader)
- [chrome.google.com](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh/)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/dark-reader/ifoakfbpdcdoeenechcleahebpibofpc/)
- ~~addons.opera.com~~
- [Sourcecode](https://github.com/darkreader/darkreader)

## Privacy Redirect

Einige der großen Dienste sind anstrengend, langsam und nicht gerade freundlich für die Privatsphäre.
Dafür gibt es leichtgewichtige, privatsphärefreundlichere Alternativen.
um ein paar Beispiele zu nennen:
Für Twitter gibt es [Nitter](https://github.com/zedeus/nitter), für YouTube gibt es [Invidious](https://github.com/iv-org/invidious), für Maps gibt es [OpenStreetMap](https://www.openstreetmap.org/) usw.
Für Videos verwende ich beispielsweise ausschließlich Invidious, welches so viel weniger Ressourcen im Browser benötigt und weniger anstrengend ist.

Mit dieser Erweiterung kann man diese Seiten automatisch erkennen und auf die jeweilige Alternative umleiten.
Dabei wird entweder zufällig aus einer der vielen hinterlegten Instanzen ausgewählt oder die Instanz des Vertrauens gewählt.
Nitter ist beispielsweise nur ein Container ohne jeglichen persistenten Zustand und fix selber hochgezogen.

Manchmal gehen einige Dinge nicht, vielleicht ist ein Video buggy oder man braucht selten doch mal eines der Feinheiten, die in der Alternative (noch) nicht vorhanden sind.
Dann kann man die Erweiterung mal eben aufmachen und die jeweilige automatische Umleitung kurzzeitig deaktivieren.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/privacy-redirect/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/privacy-redirect/pmcmeagblkinmogikoikkdjiligflglb)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/privacy-redirect/elnabkhcgpajchapppkhiaifkgikgihj)
- ~~addons.opera.com~~
- [Sourcecode](https://github.com/SimonBrazell/privacy-redirect)

## SingleFile

Einmal diese Website mit allen Bildern usw. als einzelne HTML Datei herunterladen?
Dafür ist diese Erweiterung.
Viel mehr kann ich hier eigentlich gar nicht mehr dazu sagen.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/single-file/)
- [chrome.google.com](https://chrome.google.com/extensions/detail/mpiodijhokgodhhofbcjdecpffjipkle)
- [microsoftedge.microsoft.com](https://microsoftedge.microsoft.com/addons/detail/efnbkdcfmcmnhlkaijjjmhjjgladedno)
- ~~addons.opera.com~~
- [Sourcecode](https://github.com/gildas-lormeau/SingleFile)

## SVG Screenshot

Screenshots als PNG sind bekannt.
Man kann aber auch einen Bereich als SVG mit Text usw. als Inhalt exportieren.
Dabei hilft diese Erweiterung.

Der Vorteil dabei ist, dass nicht die Pixel, sondern die Inhalte als SVG gespeichert werden.
Zum Einen ist dies häufig kleiner als ein Bild, zum Anderen bleiben Informationen wie Texte erhalten.
Auch kann man mit Tools, wie beispielsweise Inkscape, seine Screenshots viel leichter manipulieren.
Mit im Grunde allen Vorteilen von SVGs.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/svg-screenshots/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/svg-screenshot/nfakpcpmhhilkdpphcjgnokknpbpdllg)
- ~~addons.opera.com~~
- ~~microsoftedge.microsoft.com~~
- [Sourcecode](https://github.com/felixfbecker/svg-screenshots)

# Experten

Einige Erweiterungen, die ich benutze, würde ich definitiv nicht jedem empfehlen.
Entweder wird mehr Wissen vorrausgesetzt, was da genau gerade passiert und wie man diese benutzt oder sind möglicherweise anstrengend, wenn man noch nicht an diese gewöhnt ist.
Beide sind aber großartig und ich würde diese nicht missen wollen.
Meiner Mutter würde ich diese aber beispielsweise nicht empfehlen ;)

## uMatrix

Sehr mächtig, aber auch in der Lage für viel "warum geht das nicht?" zu sorgen.
Im Grunde kann man auswählen, welche Inhalte (Spalten) von welchen Quellen (Zeilen) geladen werden dürfen und welche nicht.
Zeigt auch ein wenig auf, wie viel Murks einige Webseiten versuchen zu laden und wie viel davon gar nicht benötigt wird.
Und einige Webseiten werden sehr anstrengend zu benutzen, weil sie so viel unnötige Komplexität haben.

Leider hat der Entwickler die Entwicklung eingestellt und arbeitet nur noch an uBlock Origin.
Dafür hat uBlock Origin aber auch einige Features bekommen, die vorher nur uMatrix hatte.
Muss ich mich aber noch mal mit auseinandersetzen.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/umatrix/)
- [addons.opera.com](https://addons.opera.com/en-gb/extensions/details/umatrix/)
- [chrome.google.com](https://chrome.google.com/webstore/detail/umatrix/ogfcmafjalglgifnmanfmnieipoejdcf)
- ~~microsoftedge.microsoft.com~~
- [Sourcecode](https://github.com/gorhill/uMatrix)

## Temporary Containers

Die Container sind ein Firefox Feature, welches normalerweise deaktiviert ist.
Sie erlauben das komplette Trennen von Webseiten.
Wenn man sich bei einer Webseite in Container A anmeldet, dann weiß Container B nichts davon.
Mit der [Firefox Multi-Account Containers Erweiterung](https://github.com/stoically/temporary-containers) bietet Firefox selbst die Möglichkeit, mehrere Container für beispielsweise Arbeit, Freizeit und Banking bereitzustellen.

Mir geht das aber nicht weit genug.
Warum denn nicht für alles einen Container benutzen und den hinterher wieder löschen?
Damit ist alles von allem getrennt.

Vermutlich sollte ich auf meine Benutzung der Erweiterung noch mal in einem weiteren Blogpost eingehen, das würde den Rahmen des kurzen Überblicks sprengen.

- [addons.mozilla.org](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/)
- ~~addons.opera.com~~
- ~~chrome.google.com~~
- ~~microsoftedge.microsoft.com~~
- [Sourcecode](https://github.com/stoically/temporary-containers)

# Fazit

Vielleicht habe ich ja ein paar Ideen geben können, was bei dir noch hilfreich wäre.
Vielleicht hast du jetzt aber auch ein "Warum fehlt hier X?" auf der Zunge?
Ich bin auf jeden Fall neugierig auf letzteres!
