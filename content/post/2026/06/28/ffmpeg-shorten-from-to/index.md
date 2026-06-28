---
title: Video kürzen mit ffmpeg
date: 2026-06-28T15:15:00+02:00
categories:
  - open-source
tags:
  - command-line
  - ffmpeg
  - linux
---
Wenn ich mal eben ein Video auf einen bestimmten Abschnitt kürzen will, dann verwende ich gerne `ffmpeg` dafür. Da ich das immer mal wieder mache und die commands aus meiner shell history zusammen suche, dachte ich mir, schreibe ich das mal richtig auf.

<!--more-->
Für das grobe reicht meistens schon das GTK Tool Footage ([auf Flathub](https://flathub.org/apps/details/io.gitlab.adhami3310.Footage)), wird aber grade bei längeren Videos schnell unpräzise.

Um präziser zu werden, öffne ich das Video mit `mpv` mit `--osd-fractions` von der command line aus:

```bash
mpv --osd-fractions input.mp4
```

Dann kann ich mit `mpv` genau zum ersten Frame gehen, den ich sehen möchte.
Grob mit der Leise unten oder Pfeiltasten rechts links, präzise Frame für Frame mit `.` (Punkt) vorwärts und `,` (Komma) rückwärts.
Pausiert sehe ich dann in der command line den genauen Zeitstempel mit Millisekunden.
So suche ich den ersten Frame heraus und den ersten Frame nach dem Abschnitt den ich haben möchte.

Dann benutze ich diese in `ffmpeg`:

```bash
ffmpeg -i input.mp4 -c copy -c:v libx264 -ss 0:02:27.600 -to 0:02:37.600 output.mp4
#      -i argument: Input Datei
#                   -c copy: Codec für Audio, Video, … als Kopie vom input
#                           -c:v argument: Codec nur vom Video, hier libx264
#                                        -ss timestamp: Startzeit
#                                                        -to timestamp: Endzeit
#                                                                        Dateiname vom Output
```

Einmal testweise mit nur `-c copy -c:v libx264`, welches den Video input als h264 neu encodiert, was relativ schnell geht.
Leider reicht es nicht, nur `copy` ohne Videocodec anzugeben, da existierende Encodings nicht zwischen jedem Frame getrennt werden können.

Wenn ich damit zufrieden bin, encodiere ich das noch mal mit `-c copy -c:v libx265` als h265, was kompakter ist und von den meisten modernen Geräten Hardware decodiert werden kann (und für ältere Geräte mit Software Decoder auch ok-ish funktioniert).
AV1 vermeide ich noch, wenn der Ausschnitt nicht nur für mich ist, da viele Geräte noch keine Hardware Decoder dafür haben.

Und damit habe ich dann ein gekürztes Video.
