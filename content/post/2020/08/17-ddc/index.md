---
title: Monitor Einstellungen per Commandline
date: 2020-08-17T18:20:00+02:00
resources:
  - name: cover
    title: Kopfsteinpflaster nach dem nächtlichen Regen
    src: wl-kopfsteinpflaster.jpg
tags:
  - command-line
  - linux
  - monitor
---
Ich habe bei mir zwei Computer an einem Monitor angeschlossen.
Wenn ich zwischen den beiden wechseln will, muss ich immer die Tasten am Monitor verwenden… Oder?

Ich als fauler Mensch habe mir das automatisiert, sodass mein Monitor immer das Gerät anzeigt, was ich gern sehen würde.
<!--more-->

Der Trick hierbei nennt sich [DDC/CI (Display Data Channel Command Interface)](https://en.wikipedia.org/wiki/Display_Data_Channel).
Dies existierte bereits in VGA und ist so in eigentlich allen Display Anschlüssen vorhanden.
Darüber lassen sich dann bei den meisten Monitoren Dinge wie Helligkeit, Kontrast oder Eingang einstellen und auslesen.
Je nach Monitor kann man auch alle Einstellungen, die auch im Monitor Menü vorhanden sind, einstellen.
Für mich reicht jedoch Helligkeit und der Eingang.

Spannend hierbei ist: Das Gerät welches diese Signale sendet muss nicht mal die aktive Bildquelle sein.
So kann beispielsweise der Windows PC angezeigt werden, während das Linux System den Monitor heller macht.

Als Tool habe ich hierfür `ddcutil` verwendet.
Mittels `ddcutil detect` kann man sich alle verbundenen Monitore anzeigen lassen,
mit `ddcutil capabilities` die verfügbaren Features anzeigen und mittels `ddcutil getvcp <code>` und `ddcutil setvcp <code> <value>` kann man jeweils einen aktuellen Wert lesen oder schreiben.
Um die aktuelle Monitor Helligkeit zu lesen, kann so `ddcutil getvcp 10` genutzt werden und mittels `ddcutil setvcp 10 50` die Helligkeit auf 50 gesetzt werden.
Hierfür habe ich mir einen alias gebaut und kann mal eben mit `ddc-brightness 50` die Helligkeit auf 50 setzen.

Spannender für mich war jedoch das Einstellen der Bildquelle.
Ich persönlich habe einen NUC (Arch Linux) und einen Windows PC, die ich jeweils exklusiv nutze, sprich entweder der Eine oder der Andere ist an.
Diese Eigenschaft habe ich mir dann zu nutze gemacht:
Ich habe einen [systemd service](https://github.com/EdJoPaTo/LinuxScripts/blob/8b741b35a6f6c5584739bf3e27e7eec3ccc2461a/Arch/systemd/nuc-display-switch-windoof.service) gebaut, der beim Starten meines NUC dem Monitor sagt "zeige NUC" und beim Herunterfahren "zeige Windoof".
Solange mein NUC also aus ist und nichts kontrollieren kann, ist Windows an der Reihe.
Wenn ich den NUC starte, ist der Windows PC vermutlich aus, ich will den NUC nutzen, also wird das Bild auf diesen gewechselt.

Das läuft jetzt so seit über einem Monat und ich bin ziemlich zufrieden damit.
Einziger Nachteil: mein NUC scheint über HDMI kein DDC sprechen zu können/wollen, daher schalte ich aktuell nur meinen Hauptmonitor über DisplayPort.
Mit einem Raspberry Pi hatte ich mit HDMI auch Probleme.
Mit meinem MacBook und USB-C zu HDMI funktionierte es.

USB Kabel für Maus, Tastatur, … muss ich dank einem USB Switch auch keine mehr umstecken, einfach das Gerät einschalten, welches ich benutzen möchte und ich kann Monitor und Eingabegeräte direkt verwenden.
Sehr entspannt.

Und vielleicht baue ich in Zukunft auch noch einen Umgebungslicht Sensor für automatische Helligkeitseinstellung.
