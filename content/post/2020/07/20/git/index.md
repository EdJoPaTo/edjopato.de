---
title: Wie machst du eigentlich - Git
date: 2020-07-20T19:30:00+02:00
categories:
  - how-do-i
tags:
  - command-line
  - git
---

Etwas das beim Entwickeln ganz nebensächlich passiert: Die Versionsverwaltung nutzen.
Macht man halt so.
Aber wie mache ich das eigentlich?

<!--more-->

Dies ist nicht als Einführung gedacht, sondern mehr als Hintergrundwissen wie und warum ich etwas mache.
Ich nehme an, das man schon grundsätzliches von Git versteht, wie staged files, Branches, … und erkläre solches hier nicht im Detail.

Und wie immer gilt: Man Pages sind dein Freund: `man git`.

# Ordnerstruktur

Projekte, die ich mit Git verwalte, habe ich alle unter einem Ordner, in meinem Fall `~/git`.
Darunter befinden sich mehrere Ordner zum jeweiligen Thema des Projekts, wie beispielsweise der Ort, für den ein Projekt entsteht (`study`, `<company-name>`, …) oder das grobe Thema des Projekts (`telegram-bots`, `smarthome`, …).
Passt ein eigenes Repo bisher in keine dieser Kategorien, dann landet es erstmal in `personal`.
Projekte die ich von anderen anschauen will oder Pull Requests dafür mache, kommen in den Ordner `other`.

# .gitconfig

Meine Git Config mit all ihren Einstellungen habe ich in [meinen Configs](https://github.com/EdJoPaTo/LinuxScripts/blob/main/Applications/random-configs/gitconfig) verewigt und aktualisiere diese regelmäßig mal.

Auch hier versuche ich den Weg zu gehen, möglichst wenig zu konfigurieren.
Damit kann ich leichter noch mal zum Beispiel bei fremden Git Problemen helfen.
Auch habe ich so nicht so viele Probleme, wenn ich mal eben auf einem Server oder Raspberry irgendwas tue, wo meine gitconfig fehlt.

## Alias

- `git lg`: Quasi ein fancy `git log --oneline --graph`
- `git release-log`: Ein `git log --oneline` Format, welches ich als Release Log Vorlage benutze.
- `git diffw` und `git showw`: jeweils dasselbe wie der Befehl ohne angehängtes w, aber nützlich um mal eben einen wortbasierten Diff statt einem zeilenbasierten Diff anzusehen.
- `git puff`: Mein `git push --force` in Anlehnung an das Comic "Puff!", irgendwas wird dabei bestimmt schon kaputtgehen.
  Allerdings wird in diesem Command `--force-with-lease` verwendet, was quasi bedeutet:
  Mache nur einen Force Push, wenn der Remote denselben Stand hat, wie ich lokal erwarte.
  Sollte also jemand anderes zwischenzeitlich etwas gepusht haben, schlägt dieser Force Push fehl.
- `git s`: Die `--short` Version von `git status`, die auch noch `--branch` Informationen anzeigt, inklusive above und ahead.

## Push

- `push.default = simple`: Ich kann `git push` statt `git push -u origin main` nutzen, wenn der Branch richtig dem Remote zugeordnet ist.
- `push.followTags = true`: Beim Pushen werden automatisch relevante Tags mit übertragen, die auf einen der zu übertragenen Commits zeigen.

## Pull

- `pull.ff = only`: Normalerweise löst ein `git pull` quasi ein `git fetch && git merge` aus.
  Dies kann entweder bedeuten es gibt neue Commits, die einfach nur weiter gehen (fast forward = ff) oder in der Zwischenzeit sind parallel andere Änderungen auf dem Remote passiert, die dann einen Merge Commit auslösen.
  Ich persönlich finde es aber gut, Dinge lokal zu machen und dabei nicht ungefragt anzunehmen, der Remote habe bestimmt recht.
  Wenn ein Merge auftritt, bedarf dieser möglicherweise zusätzlicher Aufmerksamkeit, also will ich in dem Falle selber schauen.
  Wenn aber nur weitere Commits vorhanden sind, die fast forwarded werden können, dann glaube ich dem einfacher.

## Rebase

Rebase ist tendenziell fortgeschritten, da es einen History Rewrite durchführt.
Wenn man Commits, die bereits auf dem Remote sind, mit in den History Rewrite einbezieht, dann muss man force pushen.
Ich persönlich will nur History Rewrites mit noch nicht gepushten Commits machen.
Dann kann auch nicht so leicht aus Versehen etwas kaputtgehen.
(Kleine Fehlerwahrscheinlichkeit bei häufigem Nutzen geht irgendwann auch mal schief.)

Probiere dich damit auf jeden Fall aus, bevor du das produktiv nutzt.
Aber habe auch keine Angst davor, dich auszuprobieren.

- `rebase.autoSquash = true`: wähle automatisch fixup für Commits mit fixup Message beim interaktiven Rebase aus. (Nützlich für `git commit --fixup=<hash>`, wird später genauer erklärt)
- `missingCommitsCheck = error`: Breche ab, wenn beim interaktiven Rebase Commits nicht mehr im todo sind. Man sollte drop verwenden, statt die Zeile zu löschen, damit die Intention klar ist.

## Commit

- `commit.gpgSign = true`: Signiere die Commits mit dem `user.signingkey`.
  Commits können auch fremde Autoren haben.
  Jemand kann `git commit --author "Karl"` benutzen.
  Ist aber der Commit mit deinem Key signiert, dann weiß man, das sich niemand für dich ausgegeben hat, da nur du den Key hast.
  [Hier](https://help.github.com/articles/signing-commits-using-gpg/) gibts mehr dazu.

  **Edit 2021-10**: Mittlerweile benutze ich keine GPG signed Commits mehr.
  Ich habe keinen Umgang mit GPG Keys gefunden, der für mich gut genug funktioniert, bei dem diese sowohl ablaufen, als auch langfristig funktionieren.
  Außerdem gab es immer mal wieder Probleme, zum Beispiel wenn man per SSH auf einem Gerät mit aktivierten GPG Keys ist und etwas committen will.
  Und wenn ich nicht signiere, kann ich immer noch sagen, "war ich doch gar nicht".

## User

- `user.name = <name>`
- `user.email = <email>`

# Verwendung im Projekt

Wenn ich mit einem Projekt anfangen will etwas zu tun, gehe ich meistens mit einem Terminal in genau diesen Ordner: `cd git/personal/iPhoneBatteryHealth` (Tab für autocomplete ist super).
Dann hole ich mir den aktuellen Stand vom Remote (meistens GitHub) via `git fetch`.
Mit `git status` kann ich dann sehen, was grade los ist.
Da ich grade mit dem Projekt anfange, wieder etwas zu tun, sollte es grade auf dem Standard-Branch sein, keine lokalen Änderungen haben und seit dem Fetch auf gleichem Stand wie der Remote sein.
Ich habe mir den alias `git s` konfiguriert, der `git status --short --branch` ausführt.
Damit sehe ich quasi dasselbe wie durch `git status` auf einen Blick, nur ohne dabei erklärenden Text zwischen den gewünschten Informationen zu haben.
Außerdem zeigt meine Shell den aktuellen Branch, ob es Änderungen gibt oder ob möglicherweise Commits auf dem Remote sind, die ich noch reinholen muss oder anders herum noch pushen muss, an.
Damit spare ich mir dann den Aufruf von `git s`, wenn ich es nicht genauer wissen will.

Dann arbeite ich an dem Projekt.

Aktuell verwende ich dazu Visual Studio Code.
Tendenziell funktioniert, rein für die Git Nutzung, Atom noch mal besser für mich.
Zum Beispiel macht Visual Studio Dinge komplizierter zu verstehen, weil so etwas wie "sync" nicht in Git existiert, sondern quasi `git fetch && git merge && git push` ist.
Atom ist da sehr nah an Git Commands und das hilft beim Verstehen, was Git tut.

Auf meinem Arbeitslaptop verwende ich neben Visual Studio (kein VS Code) Atom, mit dem ich die meisten Git Dinge mache.
Visual Studio Code ist da nicht so gut wie Atom, aber gut genug.
Immer mal, selten, fehlt mir etwas, das mache ich dann mit der Konsole.

Für Commits will ich immer möglichst kleine, eindeutig nur eine Sache "erfüllende" Commits haben.
Das hat später den Vorteil, genau zu sehen, was der Grund für eine geänderte Zeile ist oder um genau ein Feature wieder rückgängig zu machen.

Für die Commit-Message halte ich mich an [Conventional Commits](https://www.conventionalcommits.org/).

Manchmal ist noch nicht klar abzusehen, ob etwas funktioniert, dann committe ich nicht ganz so schnell, wie ich manchmal gern würde und entwickle weiter.
Dann sortiere ich später die jeweiligen Änderungen in mehrere unterschiedliche Commits.
Dabei verwende ich quasi den patch mode (`git add --patch`), nur mit GUI durch Visual Studio Code oder Atom.
Ich füge also Zeilen/Blockweise Änderungen zum Commit hinzu, nicht ganze Dateien.

Manchmal kommt es vor, das ich später noch eine Zeile finde, die in einem früheren Commit fehlt.
Entweder es ist der direkt vorher gemachte Commit, dann arbeite ich quasi wie vorher mit `git add`, sodass diese Änderung gestaged ist.
Dann füge ich diese Änderung zum vorherigen Commit hinzu: `git commit --amend`.
Wenn der Commit früher passiert ist, verwende ich meinen `git lg` alias, um den Hash des jeweiligen Commits zu kopieren.
Dann kann ich mit `git commit --fixup=<hash>` einen fixup Commit erzeugen.
Dieser unterscheidet sich quasi nicht von einem normalen Commit, außer das die Commit-Message `fixup! <old commit message>` ist.
Dies allein hilft jetzt noch nicht, kann aber bei einem Rebase genutzt werden.

Immer mal oder wenn ich fertig bin, verwende ich `git rebase --interactive --autosquash` (oder kurz mit meiner gitconfig: `git rebase -i`).
Dabei wird automatisch der Remote Branch verwendet, wenn dies richtig aufgesetzt ist.
Alle Commits bis zu dem, den der Remote kennt, werden zum Rebase todo hinzugefügt und in einem Editor angezeigt.
Durch das `--autosquash` wurden bereits die fixup Commits an die richtige Stelle verschoben und als fixup markiert.
Hier können Commits beliebig in ihrer Reihenfolge geändert werden, gelöscht werden, zusammen gefügt werden, Commit-Messages editiert, ….
Speichert und schließt man den Editor, wird genau dieses todo ausgeführt.

Ich empfehle allerdings, sich mal mit `git rebase` auszuprobieren, bevor man das produktiv nutzt.
Ein guter Tipp an der Stelle: nur weil Commits nicht mehr in dem Branch sind, sind sie noch nicht weg.
Mit `git reflog` oder `git log --reflog` (und damit auch `git lg --reflog`) kann man sich diese noch mal anzeigen, um an seine verschollenen Commits zu kommen.

Immer einmal häufiger als man so denkt, sollte man `git push -u` nutzen (gilt auch für mich).
Damit sind die Commits auch auf dem Remote und nicht weg.
Das `-u`, kurz für `--set-upstream` setzt das Tracking zwischen dem lokalen und dem remote Branch.
Ansonsten verrennt man sich, grade am Anfang mit git, etwas leichter.

# Branches

Die meisten meiner Projekte sind allein, daher habe ich bisher noch nicht so viel schreibwürdige Erfahrung mit gutem Zusammenarbeiten.
Tendenziell machen mehrere Branches pro Person Dinge einfacher, da man nicht so häufig Merge Commits oder Rebases braucht.
Allerdings hat man dann auch nicht exakt die Dinge, die die andere Person grade jetzt gebaut hat.

Ich verwende Branches meistens nur, um Dinge auszuprobieren, für die ich länger brauche.
Diese kann ich dann problemlos pushen ohne das der Standard-Branch in Mitleidenschaft gezogen wird.

# Schlusswort

Wie bei so ziemlich allem kann man überall noch etwas lernen.
Wenn du denkst, ich habe etwas vergessen oder etwas kennst, dass das Leben erleichtern kann, dann gern her damit!

Und wenn du Fragen zu einem "Wie machst du eigentlich X" Thema hast, dann wird daraus vielleicht auch ein Blog Eintrag.
