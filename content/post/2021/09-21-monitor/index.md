---
title: Ein neuer Monitor und ungewöhnliche Experimente
date: 2021-09-21T23:31:00+02:00
tags:
  - monitor
---
Ich habe mir einen neuen Monitor gekauft.
Seit Jahren überlegte ich mir, "vielleicht mal ein neuer Monitor" und jedes Mal dachte ich mir "ach, ein bisschen was fehlt noch".
Auch die Rechnung, wann sich die Stromkosten rentiert hätten für neuere, effizientere Monitore, kam so bei ~12 Jahren raus, also lohnte es sich nicht wirklich.
Ich habe zwei alte Dell U2711 Monitore.
U2711 steht für UltraSharp 27" von 2011.
Gekauft habe ich mir jetzt den Dell U2722DE.

Der Monitor bietet einige Features, an denen ich Interesse habe.
Zum Einen hat der Monitor DisplayPort Out und damit DisplayPort MST (Multi Stream Transport) Unterstützung.
Das bedeutet, man kann mit einem Stecker am Computer mehrere Monitore ansteuern.
Außerdem hat der Monitor neben DisplayPort (und HDMI) auch USB-C mit DisplayPort 1.4.
Ich kann also Geräte mit USB-C, wie Laptops, an den Monitor anschließen und so auch mehr als einen Monitor ansteuern.
Und als weiteres, großes Feature bietet der Monitor einen KVM-Switch mit USB-Hub, passend zum jeweiligen Input Signal, an.
Ich kann also meine Maus, Tastatur, Headset usw. an den Monitor anschließen und je nach Eingabegerät werden diese an den richtigen Computer weiter geleitet.

In der Theorie ist das Ganze ganz cool:
Man hat ein Hauptgerät, welches über DisplayPort und USB an den Monitor angeschlossen ist.
An dem DisplayPort Out gibt es dann weitere Monitore (die beiden U2711), welche über dasselbe Kabel versorgt werden können.
Wenn ich jetzt einen Laptop anstecke, dann wechselt Tastatur, Maus, usw. und auch die Monitore auf den Laptop.
Vorher schon geschaut, die Auflösung von 3 2560x1440 Monitoren benötigt HBR3, welches ab DisplayPort 1.3 verfügbar ist.
Natürlich hat mein NUC5i3 nur DisplayPort 1.2, aber man will ja auch etwas kaufen, was ein paar Jahre tut.
Die U2711 halten ja schließlich auch schon 10 Jahre.

Als der Monitor ankam erstmal aufgebaut und versucht, die Kabel zu sortieren.
3 Monitore und mehrere Computer haben eine Menge wirrer Kabel.
Spannend war dann das Menü des Monitors.
Beispielsweise musste das USB-C PD zum Laden eines angeschlossenen Geräts explizit eingeschaltet werden.
Dabei gab es den Hinweis, dass der Monitor dann mehr Strom verbrauchen würde, als auf dem Energielabel angegeben ist.
Sollte das nicht so ziemlich jedem denkenden Mensch klar sein, dass das Laden mit 90W über USB-C nicht Teil des ~20W durchschnittlichen Verbrauch sein kann?
Auch das DisplayPort MST, welches das DisplayPort Out und die Chain erlaubt, musste explizit eingeschaltet werden.
Dass man den DisplayPort Out und den zweiten USB-C Port am Monitor mit einem Gummi-Blocker versieht, damit niemand aus Versehen etwas reinsteckt und sich dann wundert, warum dieser nicht funktioniert, kann ich nachvollziehen.
Aber warum man sowas extra anschalten muss, nicht unbedingt.

Vor dem Monitor habe ich einen billigen (40 €) DisplayPort MST Hub (1 DP auf 3 DP Ausgänge) verwendet.
Damit kann ich am NUC 3 Monitore (2x U2711 und ein Full-HD Monitor) betreiben.
Dafür reicht auch DisplayPort 1.2 aus.
Ich hatte die Befürchtung, dass der DisplayPort MST Hub die Chain unterbrechen könnte, aber tatsächlich kann man den Hub sowohl zwischen NUC und Monitor stecken, als auch an den DisplayPort Out Port des Monitors und trotzdem noch einen Monitor dahinter ansteuern.
Ziemlich cool, dass das geht.
Damit kann man also ein DisplayPort Kabel bzw. ein USB-C Kabel zum neuen Monitor haben und der DisplayPort Out mit MST Hub kann zwei weitere Monitore ansteuern.
Für 2x 2560x1440 + Full-HD reicht DisplayPort 1.2, für 3x 2560x1440 leider nicht mehr.
(Ich habe extra darauf geachtet, dass auch der USB-C Port des Monitors DisplayPort 1.4 kann, das können nämlich nicht alle, was zu lustigen Überraschungen führen kann.)

Allerdings habe ich bisher kein Gerät mit DisplayPort 1.4.
Der NUC5i3 hat nur DisplayPort 1.2.
Der i7-7567 kann laut Datenblatt nur 2 Monitore und macht auch nicht mehr als das.
Das PinePhone scheint kein DisplayPort MST zu unterstützen.
Das MacBook kann mit macOS softwareseitig kein DisplayPort MST, also auch nur einen Monitor pro Kabel.

Eine Sache, über die ich vorher nicht nachgedacht habe, aber rückblickend doch durchaus Sinn ergibt:
Man kann mit dem U2722DE über USB-C nur entweder USB 3.2 oder USB 2.0 mit DisplayPort MST.
Mehrere Monitore haben eine Menge Datendurchsatz, von daher nachvollziehbar, dass das nicht beides gehen wird.
Aber für meinen Anwendungsfall, Headset, Maus und Tastatur definitiv ausreichend.

Mit dem NUC5i3 habe ich den Monitor aktuell über HDMI angeschlossen und die beiden U2711 mit dem DisplayPort MST Hub.
Leider können die U2711 über HDMI nicht die volle Auflösung, ohne dass man dort [nachhelfen muss](https://github.com/EdJoPaTo/u2711-hdmi-linux).
Mein Workaround läuft leider nur unter X11, nicht unter Wayland.
Von daher bin ich erstmal damit verblieben, den neuen Monitor über HDMI anzuschließen, da der NUC nur 1x DisplayPort und 1x HDMI hat.
Ich nutze aktuell also kein DisplayPort Out des Monitors.
Ein wenig Schade aber das wird irgendwann mit neuer Hardware auch mal kommen.

Ein Problem habe ich mit dem Monitor noch:
Solange der Input Auto Detect (automatisch erkennen, auf welchem Input Daten kommen) an ist, schaltet Gnome die Monitore nicht in den Stand-by-Modus, wenn man den PC sperrt.
Dafür habe ich Auto Detect abgeschaltet, ist für mich jetzt kein großes Problem, nur ein wenig Schade (An der Stelle doch ganz gut, dass man so etwas abschalten kann).
Offiziell hat Dell keinen Support des Monitors für Linux (oder macOS), nur für Windows 7+.
Es gibt dazu Bug Reports, vielleicht ist das Problem irgendwann behoben.
Unter macOS und USB-C habe ich das Problem nicht beobachtet, dort geht dieser ganz normal in den Stand-by-Modus.

Ansonsten hat der Monitor ein gutes Bild, ähnlich wie ich es von den U2711 gewohnt bin.
Ein wenig Halo-Effekt ist bei IPS zu erwarten, aber deutlich weniger als bei den U2711.
Die U2711 sind im Vergleich etwas gelblicher bei den gleichen Einstellungen, könnte am Alter liegen, weiß ich nicht.
Da ich keine farbentreuen Dinge damit mache, für mich aktuell nicht weiter relevant.
Einziger Nachteil des Bildes gegenüber den U2711 ist das schwarz, welches heller ist.
Aber es ist ja auch kein OLED Monitor und so häufig hat man kein komplett schwarzes Bild, dass das auffallen würde.
Es fiel mir auch nur im direkten Vergleich auf.
Der neue Monitor hat einen deutlich kleineren Rahmen als die U2711, aber so im Alltag ist das irgendwie kein Vor- oder Nachteil.
(In einem Laptop hingegeben wäre dies anders, für den Desktop ist es für mich aber einfach nicht relevant.)

Alles in allem ist der Monitor mit seinen Features schon cool.
[Das Einstellen der Helligkeit über DDC/CI]({{< relref "/content/post/2020/08-17-ddc.md" >}}) funktioniert weiterhin problemlos.
Ich kann mal eben ein USB-C Gerät anstecken und benutzen.
Nur das mit der DisplayPort MST Chain bedarf noch neuerer Hardware, was meinen aktuellen NUC5i3 angeht.
