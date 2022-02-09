---
title: Die Cloud - Computer fremder Menschen
date: 2021-10-18T23:45:00+02:00
resources:
  - name: cover
    src: alpacas.jpg
    title: Alpakas vor einem Corona Testzentrum
categories:
  - open-source
tags:
  - linux
  - macos
  - server
  - windows
---
Aktuelle Themen in der Firma brachten mich zum Nachdenken, was Cloud für mich bedeutet und wie ich persönlich damit umgehen will.
Es ist nicht das erste Mal, dass ich in diesem Blog von "ge-cloud" schreibe und Aussagen wie "Die Cloud sind nur die Computer fremder Menschen" sind mir nicht fremd.
Ab wann ist eine Cloud "spooky" und bis wohin bin ich bereit diese zu akzeptieren?

Es wäre inkonsequent zu sagen "Google Drive ist böse" und stattdessen einen Amazon S3 Bucket für die Dateien zu verwenden.
Einen Firmennamen zu nennen und zu verteufeln hilft nicht weiter - pauschal Clouds abzulehnen auch nicht.
Sind Menschen mit einer selbst gehosteten Nextcloud böse?

# Was will ich überhaupt?

Bevor man die Frage stellt, es muss eine Cloud her, muss man sich fragen, was will man überhaupt?
Was ist mein Anwendungsfall?
Was ist mein Ziel?
Welches Problem will man lösen?
Welche Aufgabe soll erfüllt werden?

Wenn ich beispielsweise ein Backup haben will, welches nicht am selben Ort wie die Daten liegt, dann kann ich auch Dinge auf Festplatten spielen und die einem Freund mitgeben.
Geht ganz ohne Cloud.
Will ich meine Dateien von einem anderen Ort aus nutzen können?
Will ich gemeinsam mit jemandem an etwas zusammen arbeiten?
Gemeinsam Programmieren oder gemeinsam eine Aufgabenliste pflegen?
Will ich meinen Quelltext automatisch testen?

Ich habe mal mit jemandem über eine geteilte [tmux](https://github.com/tmux/tmux/wiki) Session zusammen programmiert.
Funktionierte erstaunlich gut.
Und erfüllt auch die Bedingung "fremder Computer".
Mit dieser Lösung kann man natürlich nicht alles machen, aber ihr Ziel erfüllte sie effizient.

Man kann die Frage, was man überhaupt braucht, erst beantworten, sobald man sich über die eigenen Anwendungszwecke bewusst ist.
Ansonsten schlägt man mit einer Axt Schrauben in die Wand…

# Wie "sicher" müssen meine Daten sein?

Wie groß ist das Risiko, wenn meine Daten abhandenkommen?
Damit meine ich zwei Dinge: Wenn jemand anderes die Daten bekommt oder wenn man selbst die Daten nicht mehr bekommt.
Sprich, wenn jemand die Daten entwendet oder wenn es keine Backups gibt.

Teilweise bieten Cloud Dienstleister redundante Speicherung von Daten, was ein Vorteil sein kann.
Allerdings sind Dienstleistungen frei im Internet nicht unbedingt so sicher, wie im eigenen VPN ohne direkten Zugriff vom Internet.
Hier muss man abwägen, ob die Vorteile das Risiko überwiegen.

Man sollte allerdings aufpassen, dass man nicht mehrere Systeme für dieselbe Aufgabe benutzt.
Ein gutes Beispiel im Firmenumfeld sind die Messenger und die sichere Dateiablage.
Wie viele Menschen schicken auch die geheimen Daten über den unsicheren Messenger?
Wir sind Menschen und machen regelmäßig Fehler.
Die könnte man vermeiden, in dem man weniger Systeme bereitstellt und immer versucht, nur die Systeme zu halten, die den benötigten Schutzbedarf für alles bieten.

# Muss es wirklich eine Cloud sein?

Gerade weil die Cloud fremde Computer sind, will man gar nicht so unbedingt, dass seine eigenen Daten bei irgendwem Fremden liegen.
Aber müssen diese überhaupt bei Fremden liegen?

Hier gibt es für einige Probleme dezentrale Ansätze, sprich die Daten wandern nur zwischen den jeweiligen Teilnehmern hin und her und landen nie auf einem Server.
Ich persönlich verwende für Dateien [Resilio](https://www.resilio.com/) bzw. die Open Source Variante [Syncthing](https://syncthing.net) (aktuell leider noch beides parallel, da Syncthing keine iOS App hat).
Beide Tools arbeiten über das BitTorrent Protokoll, welches gleichzeitig an viele andere Peers sendet als auch empfängt.
Da hier Direktverbindungen genutzt werden, wird dies ziemlich schnell über LAN und auch bei vielen langsamen Peers kommt man auf einen doch recht schnellen Download.

Bei diesen Ansätzen gibt es keine Server, die die Daten kennen würden.
Und wenn einem der hauseigene Upload zu langsam ist, kann man immer noch einen verschlüsselten Share auf einem gut angebundenen Server einrichten.
Da der Server den Key nicht bekommt, kann dieser die Daten zwar nicht entschlüsseln, aber trotzdem verteilen.

So ziemlich alle Entwickler kennen das Tool Git, was im Grunde genommen auch genau das für Klartext-Dateien tut.
Dezentrales Tool, nur leider verstehen viele Leute nicht, was Git alles lösen kann.
Zum Beispiel bekommt man Versionierung geschenkt (und mit Remote, welcher einen Force Push verhindert, auch Revisionssicherheit).
Auch automatische Backups von Klartext-Dateien sind damit entspannt gelöst.
Irgendwas zerschossen?
Einfach auf einen älteren Commit zurückgehen.

Wenn man beispielsweise Kalender nutzen oder Kanban Boards gemeinsam bearbeiten will, kann man diese auch mit schlechten Internetanbindungen ins Internet hängen.
So viel Datendurchsatz braucht man für beispielsweise ein Textdokument auch nicht.
Dabei kann beispielsweise ein Raspberry Pi diese Dienste anbieten und man kann diese auch von unterwegs nutzen.
Man muss natürlich weiterhin auf Sicherheit achten, aber die Daten bleiben schonmal im Hause.

Auch ist man weiterhin arbeitsfähig, wenn mal das Internet weg ist oder man in der Bahn sitzt.
Hatte ich heute, Kasse geht nicht auf, kein Internet.
Man schickt mir dann eine Rechnung, sobald das wieder geht.

# Doch eine Cloud

Eine weitere Alternative stellt das Ende-zu-Ende Verschlüsseln der Daten dar.
Ich habe meinen Schlüssel und kann die Daten allen geben, die sie nicht haben wollen, anfangen können sie damit dann eh nichts.
Mir ist da als Tool [Cryptomator](https://cryptomator.org/) bekannt, nutze es selbst aber nicht (mir reichen Git und Syncthing).

Aus meiner Sicht werden hier zwei wesentliche Aspekte für mich sichtbar, worauf ich achten möchte:

- Die eigene Lösung sollte komplett öffentlich dokumentierbar sein.
- Der jeweilige Anbieter sollte egal sein, man sollte diesen austauschen können.

Wenn ich allen guten Gewissens die Dokumentation geben kann, wie meine Cloud Lösung funktioniert, dann erfüllt diese gewisse Sicherheits- und Datenschutzstandards.
Oder andersherum: Wenn ich mir nicht sicher bin, dann sollte man vielleicht noch mal schauen, ob da ein Sicherheitsproblem besteht.
Hier kommt dann auch wieder mein Hang zu simplen Lösungen, beispielsweise ein Git per SSH ist einfach zu verstehen und Risiken sind leicht abzuschätzen.

Und der andere Punkt ist vermutlich mit Quellcode einfach zu beschreiben.
Wenn ich meinen Quellcode automatisch testen lassen will, dann sollen die Testergebnisse überall reproduzierbar sein.
Es hilft mir nicht, wenn ich einen Computer habe, auf dem es nicht läuft, auf allen anderen aber schon.
Ich will mein Testscript gegen einen Computer werfen und dieser soll das ausführen.
Wenn dieser Computer aber eine besondere Syntax hat, dann kann ich nicht von A nach B wechseln.
Ein Bash Script, welches `cargo test` ausführt, läuft überall.
Eine GitHub Action, welche irgendwelche dunkle Magie einsetzt, läuft eben nur in GitHub Runnern und ich kann nicht so einfach zu einem anderen Test Runner umziehen.
Das, was ich mache, soll also interoperabel auf den Computern fremder Menschen laufen.

Und genauso sehe ich das auch für andere Cloud Dinge:
Solange ich das jeweilige, gewünschte Ziel auch lokal ausführen kann, kann ich mir die Cloud aussuchen und kette mich nicht an einer bestimmten Cloud fest.
So kann man alles lokal testen und ausprobieren und wenn die jeweilige Cloud doof wird, wechselt man.
Ein paar Beispiele, warum eine Cloud doof werden könnte:

- Preissteigerungen (Walled Garden können teuer werden)
- Rechtsgrundlagen ändern sich (EU kippt Privacy Shield)
- Die Betreiberfirma wird gekauft (GitHub gehört jetzt Microsoft)
- Es werden Sicherheitslücken bekannt

# Fazit

Wenn ich jetzt an den Anfang denke, ist Google Drive böse?
Dann kann ich die Fragen stellen.

- Was will ich überhaupt?
- Muss es wirklich eine Cloud sein?
- Kann ich guten Gewissens allen erzählen, wie genau ich das mache (oder kommen dabei meine Daten abhanden)?
- Kann ich die Cloud interoperabel austauschen?
