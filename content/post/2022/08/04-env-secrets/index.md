---
title: Environment Variablen Secrets in der Command Line
date: 2022-08-04T08:36:00+02:00
categories:
  - open-source
tags:
  - command-line
  - container
  - desktop
  - linux
  - macos
  - secrets
  - telegram
---
Beim Entwickeln nutze ich fremde Dienste, für die ich API Token habe.
Das sind Secrets die nur für mich gelten und die geschützt werden müssen.
Da gestern mal wieder News zu einem Angriff aufgetaucht sind, welcher alle Environment Variablen ausliest und mitnimmt, zeige ich mal, wie ich dieses Problem für mich behandle.
<!--more-->

Vorneweg natürlich die einfachste Variante: Je weniger fremde Dienste eins beim Entwickeln benötigt, desto besser.
Manchmal kommt eins aber nicht drumherum.
Ich nutze beispielsweise für die GitHub API oder Telegram Bots API Tokens.

Der aktuelle Angriff ist vor allem in CI/CD Systemen relevant.
GitHub Actions erstellen für jeden Run einen eigenen Token, welcher nur für die Dauer des Runs gültig ist.
Wird dieser entwendet, ist dieser nutzlos nach einem Run.
Secrets die als Secrets definiert wurden, müssen weiterhin aktiv an der jeweiligen Stelle, zum Beispiel als Environment Variable, eingesetzt werden.
Hier empfiehlt es sich dann nur an genau den Stellen, an denen diese gebraucht werden, diese auch einzusetzen und sonst nicht.

Lokal möchte ich etwas mehr Komfort und habe Tokens die ein paar Monate gültig sind und im Idealfall für jedes meiner Geräte, für den ich ein Token brauche, einen eigenen Token.
Damit verlässt der Token das Gerät nicht.

Auch haben diese Secrets nichts in Quellcode, Makefiles, Dockerfiles, Git Repos oder so verloren, welche schnell mal geteilt werden.
Etwaige `.env` Dateien sollten immer in einer `.gitignore` enthalten sein, damit diese nicht versehentlich doch im Repo landen.
Permanent im Environment will ich diese auch nicht haben, da eben jeder Prozess diese lesen kann.

Für mich habe ich das über eine extra Funktion in meiner Standard-Shell `zsh` gelöst:

```bash
loadsecrets() {
  export BOT_TOKEN=123:ABC
  export GITHUB_PAT=ghp_123
}
```

Wenn ich etwas testen will, dann benutze ich einmal diese Funktion und danach sind diese Secrets in meinen Environment Variablen der einen Terminal Session, sonst nicht.

Natürlich kann ein menschlicher Angreifer die `loadsecrets` Funktion finden und wenn jemand vorher diesen Blogpost gelesen hat, noch viel einfacher.
Und wenn ein befallener Prozess beim Benutzen die Environment Variablen entführt, sind gleich alle dort konfigurierten Secrets "weg".
Mein Ansatz hier ist aber ein "gut genug".
Ich will mich hier gegen Automatismen schützen, die häufig auftreten und nicht gegen einen menschlichen Angreifer.
Außerdem sind die Secrets auf meinem Gerät keine, womit groß Schaden angerichtet werden könnte.
Der `GITHUB_PAT` hat begrenzte Rechte für das, wofür ich ihn regelmäßig nutze und nicht mehr.
Und hinter dem Telegram Bot des `BOT_TOKEN` steckt ein Test Bot.

Im Standardfall sind somit erstmal keine Secrets in meinen Environment Variablen und wenn, dann nur in einem Terminal.
