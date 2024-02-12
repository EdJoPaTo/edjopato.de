---
title: Mittels Fuzzyfind in Git Ordner springen
date: 2022-06-09T14:43:00+02:00
categories:
  - open-source
tags:
  - command-line
  - git
  - linux
  - macos
---

Als ich [`project-below`]({{< relref "/post/2022/02/09/project-below">}}) baute, hatte ich damit einen anderen Anwendungsfall vor:
Skripte in allen Projekten unterhalb des aktuellen Ordners ausführen.
Dafür benutze ich das Tool auch regelmäßig, aber mittlerweile benutze ich es deutlich häufiger, um in eines meiner lokalen Projekte zu springen.
Ich bin mir bewusst, dass man mit [`fd`](https://github.com/sharkdp/fd) (+ [`fzf`](https://github.com/junegunn/fzf)), [`zoxide`](https://github.com/ajeetdsouza/zoxide) oder [`autojump`](https://github.com/wting/autojump) ähnliches erreichen kann, aber für mich funktioniert mein Weg hier besser.

<!--more-->

Mein Ziel ist es, mal eben in ein anderes Projekt von mir zu springen.
Projekte sind bei mir immer Git Repositorys, welche im `~/git` Ordner liegen.
Und ein Tool, welches Ordner von Projekten auf Basis bestimmter Eigenschaften findet, habe ich ja mit `projekt-below`.

Ich fange mit einem simplen Beispiel an, welches `fd` und `fzf` nutzt:

- Mittels `fd` die Ordner rekursiv unter dem aktuellen Ordner finden.
- Das Ergebnis in `fzf` pipen und interaktiv auswählen.
- Die Auswahl in `cd` nutzen, um in den gewählten Ordner zu kommen.

So sieht das als Alias aus:

```bash
alias cdf='cd "$(fd --type=directory | fzf)"'
```

Nun will ich aber nicht jeden Ordner haben, sondern nur Git Projekte.
Hier nutze ich dann mein `project-below`.
Und da ich das meistens zum Wechseln von einem zum anderen Projekt nutze, starte ich direkt im `~/git` Ordner.

```bash
alias cdg='cd ~/git && cd "$(project-below --directory=.git --list | fzf)"'
```

Damit habe ich zwei mittlerweile recht häufig genutzte Befehle, `cdg` und `cdf`.

Man kann auch noch `--preview` von `fzf` nutzen, habe ich eine Weile, aber nie darauf geachtet, was dann dort angezeigt wird, also flog es wieder raus.

Warum aber `fd` oder `project-below` und nicht zum Beispiel `zoxide`?
Ich persönlich mag keinen Zustand (State).
Projekte wie `zoxide` bauen einen Cache auf, was man häufig benutzt und funktionieren daher nur mit diesem Cache wirklich gut.
Ich wechsele aber zu häufig die Geräte und will diesen Cache nicht mitnehmen.
Außerdem halte ich Cache / State für einen Seiteneffekt mit Fehlerpotenzial, wenn es sich also vermeiden lässt, nehme ich das gerne.
Und `project-below` ist dank guter Filter noch schneller als `fd` im eigenen Dateisystem unterwegs.
Messbar ist es zwar, aber im Alltag merke ich keine Verzögerung beim Benutzen.

Eine ganze Liste von meinen Aliasen gibt es in meinem [LinuxScripts Repository](https://github.com/EdJoPaTo/LinuxScripts/blob/0793d9fb3b6f76c0301a61be1b8cf61830a60e81/configs/zsh/aliases.zsh).
Da sind sicherlich für den ein oder anderen noch ein paar Inspirationen enthalten.
Und wenn du hier oder dort ein "Wieso machst du dass denn so kompliziert?" findest, freue ich mich natürlich auch über die Optimierungsvorschläge. ;)
