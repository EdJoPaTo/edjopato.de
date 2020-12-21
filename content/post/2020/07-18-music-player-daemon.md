---
background:
  name: Apfelbaum bei Nacht
  style: url(/assets/2020/07/wl-nightly-appletree.jpg)
date: 2020-07-18T15:50:00+02:00
lastmod: 2020-07-18T15:50:00+02:00
title: Einfach nur Musik hören
tags:
  - arch-linux
  - command-line
  - internet-radio
  - mpd
  - music
---

Wenn ich zum Beispiel am coden bin, will ich nebenbei einfach nur Musik hören.
Internet Radio oder Musik die hier auf der Platte liegt.
Aber muss dafür wirklich ein "riesiges" VLC mit GUI und allem laufen, nur um Musik abzuspielen?
<!--more-->

Auf einem [Raspberry Pi an meiner Musikanlage habe ich bereits ein mpd im Einsatz]({{< relref "../2018/08-08-mpd-pi.md" >}}).
Der mpd, der Music Player Daemon ist ein Hintergrund Prozess mit eigentlich nur einem Job:
Eine Musik Playlist auf dem lokalen Audio Output abzuspielen.

mpd hat dabei eine eigene Musik Datenbank, die aus einem Ordner heraus generiert werden kann.
Aus dieser Datenbank kann man dann Dinge in die aktuelle Playlist packen und abspielen.

# Einrichten

(Die Einrichtung ist hier für Linux beschrieben, funktioniert aber so ähnlich auch unter macOS. Windows habe ich persönlich nicht ausprobiert.)

Ich persönlich mag es, Konfigurationen möglichst wenig anzupassen.
Wenn die Konfiguration zu kompliziert wird, ist es vielleicht nicht das passende Tool für mich.
Und so habe ich die Standard Konfiguration von mpd auch nur minimal angepasst.

Im Wesentlichen habe ich den Standard Ordner für Musik definiert, wie er auch [unter Linux schon definiert ist](https://wiki.archlinux.org/index.php/XDG_user_directories).
Damit mpd Einstellungen nach dem neu starten noch hat, müssen diese irgendwo abgelegt werden.
Dafür habe ich `database_file` und `state_file` definiert.
Normalerweise muss man mpd aktiv sagen, wenn der Musik Ordner neu eingelesen werden soll um Änderungen zu bemerken.
Darüber will ich aber nicht nachdenken müssen, also habe ich auch noch `auto_update` aktiviert.
Somit wird der Musik Ordner automatisch auf Änderungen überprüft.
Der ganze Rest, wie Ausgabegerät usw., funktionierte zumindest bei mir einfach out of the box, was ja genau das ist, was ich will.
Meine ganze Konfiguration habe ich hier abgelegt: [Repo](https://github.com/EdJoPaTo/LinuxScripts/blob/master/Applications/mpd/mpd.conf).

Da ich mpd als Nutzer haben will und nicht als System Dienst, wird die Konfig im Home abgelegt: `~/.config/mpd/mpd.conf`.
Dann starte ich mpd über systemd als Nutzer Dienst: `systemctl start --user mpd.service`.
Damit mpd bei jedem einloggen gestartet wird, kann ich den dienst auch aktivieren: `systemctl enable --user mpd.service`.
(Hinweis: Wenn ein Ordner nicht exisiert, der in der Konfiguration definiert ist, startet mpd nicht.)
Das `install.sh` script im Repo tut all das: Erstellt die Ordner, linkt die config (dann brauche ich nur die Datei im Repo aktualisieren und diese wird gleich genutzt) und startet und aktiviert den mpd Dienst.

In meinem Fall liegt nicht die ganze Musik im `~/Music` Ordner, weil sie zum Beispiel über Resilio synchronisiert wird und damit im Resilio Ordner liegt.
Das habe ich über einen Link gelöst (`ln -rs ~/rslsync/music ~/Music/resilio-music`).
Damit ist sämtliche Musik (indirekt) in `~/Music` zu finden und ich brauche weniger komplexe Konfiguration.

# Benutzen

Jetzt läuft mpd im Hintergrund und kann von Clients angesprochen werden.
Diese Clients sagen dem mpd dann, was genau es tun soll.
Zum Beispiel gibt es den Command Line Client mpc.
Wenn ich `mpc play` ausführe, dann startet mpc, sendet an mpd 'spiel ab' und beendet sich selbst wieder.
Der Client selbst ist also quasi nur die Fernbedienung.
Das ganze funktioniert auch über Netzwerk, mpd und mpc müssen nicht auf dem selben Rechner laufen.

Ich kann jetzt also sagen, ich will meine Musik aus dem Ordner 'Baum' hören (`mpc add Baum`), möchte bitte das diese in zufälliger Reihenfolge abgespielt wird (`mpc random on`) und das abgespielt werden soll (`mpc play`).
Wenn ich dann das Lied grade nicht mag, wechsle ich einfach zum Nächsten (`mpc next`).
Und sobald ich wieder Ruhe will, kann ich einfach pausieren (`mpc pause`).

Man kann auch Internet Radio damit hören, in dem man die URL des Livestreams einfach per add der Playlist hinzufügt: `mpc add http://radio-url/stream.mp3`.

Witzigerweise kann mpd auch das Audio von Videos wiedergeben.
In der Anfangszeit hatte ich den Download Ordner von Telegram als Musik Ordner hinzugefügt und einfach alles darin abgespielt.
Telegram selbst hat selber guten Support für Audio Files (sowohl Musik als auch Hörbücher / Podcasts), einfach die mp3 in einen Chat packen und einfach hören, sehr entspannt.
So hatte ich nun aber auch irgendwelche Videos im selben Download Ordner und wunderte mich, was für komische Musik da kommt.
Mittlerweile habe ich aber alles in einem eigenen Ordner abgelegt, von daher kein Problem mehr.
