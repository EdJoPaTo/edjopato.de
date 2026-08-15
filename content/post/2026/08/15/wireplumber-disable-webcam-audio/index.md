---
title: Jegliches Audio von Webcams in Wireplumber deaktivieren
date: 2026-08-15T21:37:00+02:00
categories:
  - open-source
tags:
  - audio
  - desktop
  - linux
---
Wenn ich eine Webcam am Rechner angeschlossen habe, dann ist das Audio von dieser eigentlich nie relevant oder eher sogar nervig:
Aus Versehen ein schlechtes Raummikrofon ausgewählt, statt dem guten Headset Mikrofon.

Als ich jetzt testweise auch noch mehrere Webcams angeschlossen hatte und damit einen Haufen ungenutzter Audiogeräte hatte, dachte ich mir, da muss es doch was sinnvolles geben.

Mit Pipewire, genauer gesagt Wireplumber, der das Pipewire Protokoll für mich bereit stellt, lassen sich Regeln definieren, die Geräte generell einstellen können.

Dafür habe ich `~/.config/wireplumber/wireplumber.conf.d/52-disable-webcam-audio.conf` erstellt und darin folgendes definiert:

```json
# See https://wiki.archlinux.org/title/WirePlumber
monitor.alsa.rules = [
  {
    matches = [
      {
        device.form-factor = "webcam"
      }
    ]
    actions = {
      update-props = {
        device.disabled = true
      }
    }
  }
]
```

Im Grunde wird für alle `alsa` Geräte, die den `form-factor` `webcam` haben, das Gerät deaktiviert. Da es sich nur um die `alsa` Geräte handelt, funktionieren die Webcams als Bildquelle natürlich weiter.

Gleiches "Problem", ähnliche Lösung: Die nervigen HDMI und Audio Buchsen vom Mainboard, die ich eh nicht benutze? `device.bus = "pci"`, der Rest bleibt gleich.

An der ersten Zeile ist es schon zu sehen, ein Blick ins [Arch Wiki](https://wiki.archlinux.org/title/WirePlumber) lohnt sich.
Ich will hier nicht komplett erklären, wie diese Regeln im Detail funktionieren, eher einmal den Anstoß geben, dass sie existieren.
Es geht auch noch mehr, war aber für mich bisher (noch?) nicht relevant.

Was für mich aber relevant ist: Sie lassen sich in den dotfiles mitnehmen und auf anderen Geräten genauso nutzen.

Probier dich gern aus und berichte über nützliche Funde!
