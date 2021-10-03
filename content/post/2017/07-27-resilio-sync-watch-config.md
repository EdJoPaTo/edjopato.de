---
background:
  name: Brücke bei Fahrenholz über die Ilmenau
  style: url(/assets/2017/07/fahrenholz.jpg)
date: 2017-07-30T17:27:00+02:00
title: Das "Resilio Sync Watch Config" Tool
tags:
  - bittorrent
  - cli
  - file
  - jasmine
  - nodejs
  - resilio-sync
  - sharing
  - sync
  - testing
  - travis-ci
---
Ich habe ein Abstraktionstool für Resilio Sync erstellt.
Was ist überhaupt Resilio Sync, warum habe ich das getan und was hilft mir das?
<!--more-->

# Resilio Sync

Um meine Dateien zu synchronisieren nutze ich [Resilio Sync](https://www.resilio.com/individuals/).
Resilio Sync ist aus BitTorrent Sync entstanden und wurde aus der Firma von BitTorrent ausgegliedert.
Der Vorteil von dem Torrent Prinzip ist das Peer to Peer:
Jeder Endpunkt bzw. jeder Client sorgt dafür, das die Übertragung schneller wird.
Das ganze ist dezentralisiert (bis auf Tracker, die von Resilio gestellt werden, aber nicht genutzt werden müssen) und so vergleichsweise ausfallsicher.
Außerdem sind die Daten nicht auf Servern von zum Beispiel Dropbox, Google (Drive) oder Microsoft (OneCloud) sondern nur auf den eigenen Clients.
So laufen für mich zu Hause ein Raspberry Pi und auf meinem vServer jeweils ein Client, die für mich schnelle und immer erreichbare Synchronisation sicherstellen.

Mein einziger Nachteil aktuell:
An meiner Hochschule der HAW Hamburg sind die BitTorrent Ports geblockt (was auch nachvollziehbar ist).

# Warum habe ich das getan?

Für meine einzelnen Zwecke habe ich einzelne Ordner erstellt, die einzeln gesynct werden.
So habe ich beispielsweise Ordner für Projekte, Hochschulkrams Krams, Spielspeicherstände, Windows Portable Tools, Wallpaper, TeamSpeak, …
Diese Ordner synchronisiere ich zu Hause nur auf die Geräte, die dies benötigen.
So werden die Windows Portable Tools nicht auf meinen NUC, auf dem Arch Linux läuft, synchronisiert und andersherum, Projekte werden nicht auf meinen Windows Rechner synchronisiert, auf dem ich fast nur noch spiele.

Aus diesen Umständen habe ich mittlerweile ~15 Ordner.
Da mein Raspberry Pi zu Hause und mein vServer jedoch alles synchronisieren soll, müssen diese von allen Ordnern wissen.
Da ich die Resilio Sync Clients auf beiden Geräten Headless und ohne Webinterface über die Config einstelle, ist dies der Ort, an dem alle Einstellungen stattfinden.
Die Config erlaubt dafür eine größere Menge an Einstellungen pro Ordner, als hier für mich notwendig wären: alle gleich.
Deshalb ist das anpassen und hinzufügen der Config relativ viel Copy Paste Arbeit.
Außerdem muss ich mich dann auf beiden Geräten per SSH aufschalten und Resilio Sync neu starten, damit die Config neu eingelesen wird.
Beides wurde für mich auf Dauer nervig.

# Was tut das Tool jetzt?

Das eigene Tool tut zwei Dinge:
Eine Abstraktion der Config schaffen und bei Änderungen Resilio neu starten.

## Die Config

Ich habe für mich eine Abstraktion der Config geschaffen.
Die Syntax ist grob am Beispiel der folgenden Config beschrieben.
```json
{
  "basedir": "/path/to/resilio/base/folder/",
  "folders": {
    "uniStuff": "<key>",
    "homeStuff": "<key>",
    "tmp": "<key>"
  },
  "passthrough": {
    "folder_defaults.use_lan_broadcast": false,
    "sync_trash_ttl": 1,
    "use_upnp": false
  }
}
```
Diese Beispielconfig oben wird zu der folgenden Config für Resilio Sync.
```json
{
  "device_name": "hostname",
  "storage_path": "/path/to/resilio/base/folder/.sync",
  "shared_folders": [
    {
      "dir": "/path/to/resilio/base/folder/uniStuff",
      "secret": "<key>"
    },
    {
      "dir": "/path/to/resilio/base/folder/homeStuff",
      "secret": "<key>"
    },
    {
      "dir": "/path/to/resilio/base/folder/tmp",
      "secret": "<key>"
    }
  ],
  "folder_defaults.use_lan_broadcast": false,
  "sync_trash_ttl": 1,
  "use_upnp": false
}
```

Wie man in der unteren Config sehen kann, ist für jeden `shared_folders` Eintrag ein Objekt vorgesehen.
Außerdem gibt es den `folder_defaults.use_lan_broadcast` Key.
Es ist möglich, jeden der `folder_defaults` für jeden Ordner einzeln einzustellen, wie ich aber bereits beschrieben hatte:
Ich brauche alle Ordner gleich, nichts spezielles.

Der Vorteil der eigenen Config ist die wesentlich kürzere Schreibweise der Ordner.
Es ist klar, das alle Ordner im `basedir` landen werden und keine weiteren Einstellungen haben werden.
So wird dies angenommen und nur noch Name und Key gespeichert.

Werden weitere Einstellungen in der Config benötigt, können die in `passthrough` definiert werden.
Diese werden 1:1 in die Resilio Sync Config kopiert.
In diesem Fall sorgen die Einstellungen dafür, das der Papierkorb 1 Tag hält, LAN Sync deaktiviert ist und der Router nicht per UPNP konfiguriert werden soll (auf dem vServer sinnvoll, zu Hause ist LAN Sync aktiv).


## Neustart von Resilio Sync

Außerdem erkennt das eigene Tool Änderungen in der Config.
Bei diesen Änderungen wird die Config neu generiert und Resilio Sync mit der neuen Config neu gestartet.
Die Config selbst lege ich in einen Resilio Sync Ordner ab.
Dieser wird synchronisiert und bei Änderungen wird automatisch Resilio Sync neu gestartet.
So muss ich mich nicht mehr per SSH verbinden, um jeweils Resilio mit den Änderungen neu zu starten.

# Ziele bei der Umsetzung

Da mir "einfach nur erstellen" eines Tools zu Langweilig war, habe ich das Ganze als NodeJS CLI haben wollen, dessen Parser mit einem NodeJS Test Framework getestet wird.
Diese Tests sollen dann automatisch von [Travis-CI](//travis-ci.org/) ausgeführt werden.

## CLI

Für das CLI habe ich mit einer Eigenimplementierung begonnen.
Dazu habe ich die Befehlszeilenargumente mit `process.argv` ausgelesen und analysiert.

```js
  const args = process.argv.slice(2);
  const help = args.some(s => s === '-h' || s === '--help');

  configFilePath = args[args.length - 1];
  start = args.some(s => s === '-s' || s === '-w');
  watchmode = args.some(s => s === '-w');
```

Später habe ich das auf die NodeJS Libary [cli](//www.npmjs.com/package/cli) umgestellt (siehe [Commit b30b142](//github.com/EdJoPaTo/resilio-sync-watch-config/commit/b30b142786b3127436d4a93cff159d1a751c304e)).

## Testen

Zum Testen des Parsers wollte ich ein NodeJS Test Framework verwenden.
Die zwei Größten sind hier [Mocha](//mochajs.org/) und [Jasmine](//jasmine.github.io/), es gibt aber noch deutlich mehr.
Ich habe mich für Jasmine entschieden, da auch Angular 2 dieses Framework verwendet und hier dieses Wissen so auch für Angular Projekte nutzen könnte.

Grundlegend werden die Tests in <name>spec.js Dateien abgelegt.
Dort wird wird dann grob in dieser Struktur gearbeitet:

Komponente X macht Y

oder im Quellcode:

```js
describe('Komponente X', () => {
  it('macht Y', () => {
    expect(true).toBe(true);
  });
});
```

Eine Komponente hat dabei viele Dinge, die sie tun kann, so gibt es für einen `describe` Block viele `it` Blöcke.
Innerhalb eines `it` Block werden dann die genauen Tests definiert.
Diese arbeiten mit Hilfe von [Matchers](//jasmine.github.io/api/edge/matchers.html), wie in diesem Fall das `toBe()`.

## Travis-CI

Travis-CI ist für das Testen von Projekten gedacht und für OpenSource Projekte komplett kostenlos nutzbar.

Um Travis-CI zu konfigurieren, wird eine `.travis.yml` Datei in das Root Verzeichnis des GitHub Repos gelegt und das Projekt bei [Travis-CI aktiviert](//travis-ci.org).


```yaml
language: node_js
node_js:
  - "6"
  - "7"
  - "8.0"
  - "8.1"
  - "8.2"
  - "8"
  - "node"
```

In diesem Fall wird in der Konfiguration die Programmiersprache festgelegt.
Dies ist hier NodeJS.
Daraufhin weiß Travis-CI, dass das Standard Test Skript `npm test` ist.
Da dies in meiner `package.json` gesetzt ist, muss ich das Skript nicht einstellen.

Außerdem werden die Versionen von NodeJS definiert, auf denen getestet werden soll.
Dabei steht `node` für die aktuellste Version von NodeJS, was zum Zeitpunkt des Schreibens `8.2.1` ist.
Damit führt Travis aktuell für `8`, `8.2` und `node` exakt das gleiche aus.
Mich wundert, warum hier keine automatische Optimierung passiert und Gleichheit erkannt wird.

Zusätzlich habe ich mit
```yaml
notifications:
  email: false
```
  den E-Mail 'Spam' deaktiviert.

## Quellcode

Der gesamte Quellcode ist auf [GitHub](//github.com/EdJoPaTo/resilio-sync-watch-config).
Die [Commits](//github.com/EdJoPaTo/resilio-sync-watch-config/commits/master) Messages sind so geschrieben, um nachvollziehen zu können, was passiert ist.

# Fazit

Wenn ich einen neuen Ordner zur Synchronisation hinzufügen will, muss ich nur noch lokal bei mir in der vereinfachten Config den Namen und Key des Ordners eintragen.
Die entfernten Clients wenden diese Änderung automatisch an, ohne das ich etwas dafür tun muss.
Ein hoch auf Automatismen!
