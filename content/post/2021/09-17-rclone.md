---
license:
  name: CC BY-ND 4.0
  url: https://creativecommons.org/licenses/by-nd/4.0/
date: 2021-09-17T23:24:00+02:00
lastmod: 2021-09-17T23:24:00+02:00
title: Cloud-sync per Command-Line mit Rclone
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - rsync
  - windows
---
Wenn ich an Cloud Speicher großer Anbieter denke, dann denke ich tendenziell immer an "nervig" und "ge-cloud".
Für meinen privaten Kram bin ich den Komfort von SSH und Tools wie `rsync` gewöhnt, die mit einfachen Commands Daten durch die Gegend schieben können.
Nun kam ich durch die Arbeit an [Rclone](https://github.com/rclone/rclone) vorbei, welches die von Linux Commands wie `rsync` gewohnt simple Benutzung für proprietäre Cloud Dienste ermöglicht.
<!--more-->

Gefragt war für die Arbeit das automatische, regelmäßige Synchronisieren eines Ordners lokal mit einem Ordner in der Firmen OneDrive.
(Da ich die PN schon kommen sehe, ja, ich bin auch nicht über die OneDrive glücklich.)
OneDrive selbst funktioniert wohl nur, wenn ein Nutzer auf dem Windows Rechner angemeldet ist (Hab ich nicht nachgeprüft).
Da das Ganze eine "spooky Cloud" ist, nahm ich zwar an, dass es irgendeine API geben würde, aber dass das nervig werden würde.
Nach einer kurzen Suche bin ich auf ein quasi `rsync` für Clouds gestoßen: Rclone.
Go Single-Binary mit MIT-Lizenz, welche sogar in den Arch und Debian Repos ist, kann also schon mal nicht allzu grässlich sein.

Für quasi jeden Storage Provider gibt es eine Anleitung, welche auf der Webseite dokumentiert ist.
In meinem OneDrive Fall, ist diese unter [rclone.org/onedrive](https://rclone.org/onedrive/) zu finden.
Diese beschreibt quasi alles, was man braucht, in einer aus meiner Sicht echt gut übersichtlichen Dokumentation.
Man page und brauchbare `--help` sind auch vorhanden, für die vielen Flags, die die Executable so bietet.

Für mich sind quasi nur zwei Commands relevant, erstmal das Einrichten mittels `rclone config` und dann das regelmäßige abgleichen mittels `rclone sync --progress remote-name: ~/my/local/path`.
Das Benutzen von `rclone config` ist recht entspannt und führt einen interaktiv durch den Prozess durch.
Aus meiner Sicht könnte man dies damit auch ohne Anleitung schon einrichten.
Die Config wird dann in `~/.config/rclone/rclone.conf` abgelegt und kann auch auf andere Rechner kopiert werden usw.

Danach musste nur noch ein cronjob, systemd.timer oder in diesem Fall die Windows Aufgabenverwaltung eingerichtet werden, damit der `rclone sync` Command regelmäßig ausgeführt wird.
Die simplen Tools so zusammen stecken, wie man es selbst halt braucht und ich es von Linux Command-Line-Tools gewöhnt bin.

Alles in allem ein Command-Line Tool, wie man es vielleicht gewohnt ist.
Aus irgendeinem Grund habe ich hier für die proprietären Cloud Dienste einen Murks erwartet und nicht damit gerechnet, dass diese so sinnvoll gekapselt wurden.
Wieder einmal positiv überrascht worden, was es alles an coolen Tools gibt.
(Das ändert nichts daran, dass ich nicht glücklich mit einigen Cloud-Diensten bin, aber manchmal muss man eben das Beste aus der Lage machen.)

Abschließend, da die Frage sonst kommt: Ich persönlich verwende für meine privaten Daten im Idealfall (Text-only) Git Repos, ansonsten [syncthing](https://github.com/syncthing/syncthing) und für die großen Dinge ein NAS mit SFTP, Samba und `rsync`.
