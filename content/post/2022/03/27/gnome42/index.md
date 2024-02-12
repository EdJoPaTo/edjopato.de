---
title: Meine Anpassungen und Erfahrungen mit Gnome 42
date: 2022-03-27T13:49:00+02:00
categories:
  - open-source
tags:
  - command-line
  - desktop
  - linux
---

Als Gnome 42 herauskam dachte ich mir, dass ich ja wieder so lange auf Gnome 42 in Arch Linux warten muss und habe mir mal wieder das [gnome-unstable](https://gitlab.com/fabis_cafe/gnome-unstable) Repository eingebaut.
Gleich das Beste zuerst, endlich geht etwas in meinem Arch nicht, endlich wieder was zum Nachvollziehen, das lief ja schon viel zu lange problemfrei.
Mit ein paar Fehlersuchen, Anpassungen und mentalen Umgewöhnungen läuft Gnome 42 mittlerweile schon ein paar Tage bei mir und funktioniert schon echt gut für mich.

<!--more-->

# Eye of Gnome

Die erste Feststellung beim Testen des neuen Screenshot-Tools: Der Bildbetrachter `eog` (Eye of Gnome) geht nicht.
Einmal im Terminal starten, Fehlermeldung lesen: `Clutter-CRITICAL: Unable to initialize the Clutter backend: no available drivers found.` (Auszug).
Eine Suche meiner installierten Pakete nach `clutter` verriet mir, `deepin-clutter` ist installiert statt `clutter`.
Warum auch immer.
Also das normale `clutter` installiert und Eye of Gnome geht wieder.

# Screenshots

Wie eben schon erwähnt wurde das Screenshot-Tool durch ein neues ausgetauscht.
Aus meiner Sicht ist das Interface freundlicher für Personen, die dieses seltener brauchen, Boxen zum Ziehen, Auswahl von ganzen Fenstern usw.
Als ich die macOS Tastenkürzel noch nicht konnte (ich finde die immer noch nicht intuitiv) habe ich auch häufig das macOS GUI dafür benutzt und das macht das neue Gnome Screenshot-Tool nun auch einfacher.

Ein wenig Verwirrung bei den Tastenkombinationen bringt Gnome jedoch mit, auch für Windows Nutzer.
`Umschalt + Druck` war vorher das Auswählen eines Bereiches und `Druck` waren alle Bildschirme.
Das ist in Gnome 42 genau andersherum, `Umschalt + Druck` nimmt alle Bildschirme auf.
`Druck` alleine öffnet das neue GUI.
Das wird ein wenig Umgewöhnung erfordern, auch weil man noch einmal `Enter` nach dem Markieren drücken muss.
Dafür wird es sowohl als Datei als auch in der Zwischenablage zum direkten Einfügen abgelegt.
Mal schauen wie mir das insgesamt gefällt, erstmal probiere ich es eine Weile weiter aus.

# Terminal und Console

Eine der neuen Anwendungen ist die Gnome Console.
Die Executable heißt `kgx`, Kingscross, das war doch das Terminal was auf einigen [PinePhone]({{< relref "/tags/pinephone" >}}) Distributionen mit seinem Namen und Logo verwirrte und niemand das Terminal fand.
Nun lässt nur noch der Name der Executable darauf schließen.

Ich habe Gnome Terminal erstmal vom Rechner geworfen und Gnome Console als Default gesetzt, damit ich das mal ein wenig ausprobiere.
Normalerweise benutze ich [`alacritty`](https://github.com/alacritty/alacritty) und Gnome Terminal war nur ganz selten offen.

Praktisch finde ich das automatische Anpassen an den hellen / dunklen Theme, ansonsten ist es, was die Optionen angeht, sehr minimal gehalten.
Was mir im Alltag mit Gnome Console am meisten aufgefallen ist, ist die Titelzeile.
Mein `alacritty` ist rahmenlos eingestellt und hat die volle Fläche Inhalt, da wirkt Gnome Console nicht so minimalistisch im Vergleich.
Eine Tatsache die mich bei den "Gnome Console ist mir zu minimalistisch" Aussagen in Gnome 42 Posts schon mehrfach belustigt hat.

Da `alacritty` bei mir als immer dunkel eingestellt ist und Gnome Console tagsüber hell ist, sind einige farbige Schriften nicht so gut lesbar.
Hier ist mir zum Beispiel [`bat`](https://github.com/sharkdp/bat) aufgefallen.
Aber das sind keine Probleme vom Terminal, sondern vom hellen Theme, das hätte ich in allen anderen hellen Terminals auch.

Am Anfang war ich auch etwas von der manchmal farbigen Titelzeile verwundert.
Bisher habe ich lila bei SSH Verbindungen und rot bei Adminrechten (`sudo`, `doas`) gesehen, ich könnte mit meinen Annahmen aber auch falsch liegen.

Auch muss man nicht erst in die Optionen gehen, um irgendeinen Haken raus zu nehmen, damit man in `htop` wieder F10 drücken kann.
Etwas das mich regelmäßig mit dem Gnome Terminal in neuen Installationen nervte.

Alles in allem funktioniert Gnome Console, so viele Einstellungen bräuchte ich eh nicht.
Kann aus meiner Sicht alles, was eine standardmäßig mitgelieferte Terminal-Anwendung können muss.
Ich habe nicht viele Gründe, warum ich wirklich `alacritty` stattdessen nehmen muss.
Das aus meiner Sicht wichtigere, die Einstellungen der Shell (`bash`, `zsh`, `fish`, …), gehen natürlich weiterhin unabhängig davon.

# Editor

`gedit` hat mit Gnome Text Editor Gesellschaft bekommen.
Wie bei Gnome Terminal habe ich `gedit` erstmal vom System geworfen, um den neuen Text Editor per Default zu nutzen und festgestellt, ich habe ihn seit dem kein einziges Mal offen gehabt.
Ich nutze meistens [`neovim`](https://neovim.io) in der Command Line, um Kleinigkeiten anzupassen oder die in den Arch Repositorys verfügbare Open Source Variante von Visual Studio Code für Projekte mehr mehreren Dateien.

Generell gefällt mir aber der neue Editor gegenüber `gedit`.
`gedit` war mit seinem Theme nur entweder Dunkel oder Hell benutzbar, ohne sich an den Rest des Desktop Themes zu halten.
So schien mir auch die Komplexität und Features in diesem lange existierenden Editor doch recht hoch.
Der neue Editor benutzt Komponenten vom [Gnome Builder](https://wiki.gnome.org/Apps/Builder) wieder und passt besser in das aktuelle Gnome Design.

# Light/Dark Theme

Das Thema ist wohl besonders kontrovers, weil es das bekannte Theming von GTK zerstört.
Ich persönlich mag durchgezogenes Design und das ging mit vielen Dritt-Themes häufig eh nicht so gut.
So habe ich eh lange Zeit schon `adwaita` benutzt und je nach Tageszeit automatisch zwischen `adwaita` und `adwaita-dark` gewechselt.

## Automatischer Wechsel

Leider ist das automatische Wechseln des Themes erst für Gnome 43 vorgesehen.
Nightlight ist aus meiner Sicht das gleiche Feature, nach dem Sonnenstand umschalten.
Für mich ohne großes Nachvollziehen unklar, warum das nicht mit in Gnome 42 gelandet ist, aber es wird sicherlich seine Gründe haben.
Das Setzen ist, wie beim bekannten `gtk-theme`, ein Setzen eines Wertes mittels `gsettings`.
Ich habe [meinem kleinen Tool](https://github.com/EdJoPaTo/sun-sets-gtk-theme) zum Setzen vom Theme auch den `color-scheme` Wechsel beigebracht.
Funktioniert problemlos, aber hoffentlich wird das Tool mit Gnome 43 überflüssig.

## Hintergrundbild

Die Hintergrundbilder haben nun ebenfalls eine helle und eine dunkle Variante, wie ich es zum Beispiel von iOS kenne.
Vor Gnome 42 unterstützte Gnome schon zeitbasierte Hintergrundbilder, die mit der Zeit durch mehrere Bilder gehen und so einen dynamischen Verlauf mitmachen.
Ein Feature auf das macOS Mojave mit dem Sandhaufen auch ziemlich stolz war.
So einen zeitbasierten Hintergrund habe ich mir mal irgendwann gebaut und seit dem nie wieder angepasst.

Die neuen Hintergrundbilder haben im Vergleich dazu nur zwei Varianten und einen starren Wechsel mit dem Theme, sind damit aber auch deutlich einfacher.
Ein [Twitter Thread](https://twitter.com/alexm_gnome/status/1491527119389827074) erklärt, wie man sich einen selber bauen kann:

```bash
gsettings set org.gnome.desktop.background picture-uri 'file:///home/edjopato/Pictures/Wallpapers/wh-day.jpg'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/edjopato/Pictures/Wallpapers/wh-night.jpg'
```

Man sieht in den Gnome Settings zwar nur die helle Variante, funktioniert aber.
Ich vermute, dass das Feature demnächst auch in Gnome Tweaks verfügbar sein könnte.

# Kleinigkeiten

Ein paar spannende Dinge verraten die [Release Notes](https://release.gnome.org/42/) noch, auf die man noch mal einen Blick werfen kann.

Disk Usage Analyzer hat ein paar Verbesserungen am Design bekommen.
Meistens verwende ich zwar [`dust`](https://github.com/bootandy/dust), aber die grafische Variante ist manchmal ein wenig übersichtlicher durch das Kuchendiagramm.

Gnome Settings hat den Remote Zugriff, um den Desktop fernzusteuern, von VNC auf RDP umgestellt.
