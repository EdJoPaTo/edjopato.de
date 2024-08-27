---
title: Meine Container mit Podman, systemd und Ansible
date: 2024-08-09T13:13:00+02:00
categories:
  - open-source
tags:
  - ansible
  - container
  - linux
  - server
  - web
  - raspberry-pi
---
Jahrelang habe ich für meine Container Docker Swarm benutzt.
Die Compose files waren eine schön kompakte Konfiguration.
Aber es gab ein paar Gründe, das ändern zu wollen.
Für lokale Dinge verwende ich schon eine ganze Weile Podman, welches Features wie rootless mitdenkt, statt sie nachträglich einzubauen.
Zuletzt lief mein Swarm nur noch auf einem Server, kein verteiltes System mehr, was ja eigentlich Zweck von Swarm ist.
Ich habe nicht so viel laufen, dass ich dynamische Lastverteilung bräuchte.
Auch wollte ich ein ähnliches Setup auf einem Raspberry Pi verwenden.
Und [`podman-auto-update`](https://docs.podman.io/en/latest/markdown/podman-auto-update.1.html) ist schon ein nettes Konzept.

Nach und nach habe ich auf ein Podman basiertes System umgestellt.
Seit einigen Monaten läuft das ganze auf unterschiedlichen Servern und Raspberry Pis und ich bin recht zufrieden damit.

<!--more-->

TL;DR: <https://codeberg.org/AllesKaese/podman-systemd-ansible-role>

Ich mochte meinen Docker Swarm.
Die Compose files sind nett und um Gegensatz zu `docker-compose` gibt es einige, bessere Annahmen vom Swarm.
Automatische Neustarts von abstürzenden Containern sind ein gutes Beispiel.
Allerdings ist Docker auch eine etwas komische Firma, die einen Haufen Prozesse mit `root` Rechten und offenen Ports auf meinen Geräten hatte.

## Der Weg zum Ansible Template

Für einzelne Dienste hatte ich schon immer mal einen Podman systemd Service geschrieben (oder via Podman generiert) und (als `root`) auf einem Raspberry Pi benutzt.
Wenn ich Änderungen am Code gemacht habe, wurden automatisch neue Container-Images gebaut und mit `podman-auto-update` automatisch aktualisiert, ohne das ich viel manuell tun musste.
Schon relativ komfortabel, aber viel Copy & Paste im Vergleich zu den ansonsten recht kompakten Compose files.
Und das war damals auch noch nur für einzelne Container, nicht mehrere zusammen oder komplexere Dinge.

Also habe ich immer mal geschaut, wie ich meine aktuelle Docker Swarm Welt abbilden könnte, um ein Setup mit Podman zu realisieren.

Das Projekt `podman-compose` lässt Compose files mit Podman laufen.
Das geht aber nicht von Swarm, sondern von `docker-compose` aus, dafür müsste ich meine Compose files etwas anpassen.
Zumindest damals fehlten auch noch einige Keywords, die nicht oder eher umständlich anders integriert werden mussten.
Und es war auch nicht klar, ob etwas schon existierte oder nicht, es musste immer alles neu erstellt werden, was den Neustart aller Container bedeutete.

[Podman unterstützt auch schon länger Kubernetes YAML Dateien.](https://docs.podman.io/en/latest/markdown/podman-kube.1.html)
Fand ich auch keinen schlechten Ansatz, da ich damit ein anderes, standardisiertes Format nutzen könnte.
Zwar ist der Kubernetes YAML Support nativ in Podman und kein drittes Projekt, aber auch hier fehlten Keywords.
Da zum Beispiel [`--init`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#init) kein Konzept in Kubernetes ist, muss es eher umständlich mit Annotationen abgebildet werden.
Wenn ich auch hier wieder dabei bin, Podman CLI Argumente nachzudengeln, kann ich das auch direkt machen.

Podman hat auch einen [Befehl um systemd Service Dateien zu generieren](https://docs.podman.io/en/latest/markdown/podman-generate-systemd.1.html).
Das habe ich dann als Basis genutzt und mit Ansible Jinja2 Templates selbst diese Service-Dateien für meinen jeweiligen Container generiert, mit den CLI Argumenten die ich so brauche.

Mittlerweile ist der Befehl abgekündigt und [Quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html) empfohlen.
Quadlets sind systemd Dateien, die dann mit `systemd.generator` die wirklichen Konfigurationsdateien generiert, wenn systemd gestartet wird.
Diese Generatoren stellt Podman bereit und konvertieren zum Beispiel eine `bla.container` Datei mit zum Beispiel `Image=alpine` als Inhalt zu einem `bla.service` mit `Exec=podman run alpine` (vereinfacht).
Und damit sind wir schon wieder bei dem Problem, welches ich mit Compose Files oder Kubernetes YAML hatte: Irgendwas muss konvertiert werden und vermutlich fehlt mal wieder die CLI Option, die ich gerne hätte.
Und da dieses Generieren auch irgendwo passieren muss, kann ich das auch selbst mit Ansible und Jinja2 machen.
Das passiert einmalig und nicht bei jedem Boot durch systemd wieder.

Ich bin mir bei der Argumentation von Quadlets auch nicht ganz sicher, was ich davon halten will.
Die Services könnten nicht so optimal sein, also kann der `systemd.generator` aktualisiert werden und für die `bla.container` Dateien einen besseren `bla.service` generieren.
Dabei werden aber alle CLI Argumente von Podman abstrahiert.
Sagen sie damit über sich, dass das Podman CLI zu komplex und fehleranfällig ist und abstrahiert werden sollte, um das im Laufe der Zeit zu verbessern?
Sagen sie damit, dass das Zusammenspiel mit systemd noch nicht gut genug ist und das in Zukunft optimiert werden soll, ohne dass die Nutzenden etwas davon mitbekommen brauchen?
Ansätze wie ein `podman run --as-systemd-service` Argument-Alias oder `podman lint-systemd-service` hätten wohl auch ihre Nachteile, wären aus meiner Sicht aber vermutlich nettere Wege gewesen, als zu versuchen ganze systemd files und alle CLI Argumente zu abstrahieren.

Wie auch immer, damit war dann mein Ansatz relativ klar:
Ich generiere systemd Dateien mit Ansible und Jinja2 Templates.
Diese werden dann von systemd ausgeführt und starten Podman mit CLI Argumenten, so wie ich sie für die jeweiligen Dienste für sinnvoll halte.
(Und ich inspiriere mich bei Quadlet Ergebnis, was ich vielleicht besser machen könnte.)

## Ein paar interessante Feststellungen

Während und seit dem ich immer mehr vom Swarm migriert habe, habe ich ein paar Dinge festgestellt.
Vielleicht helfen diese Erfahrungen bei ähnlichen Unterfangen weiter.

### Zu viele Ansible Variablen

Anfänglich habe ich noch mehr versucht in Variablen abzufangen und dann korrekt im Template aufzuführen.
Zum Beispiel `init: true`, welches dann zu `{% if init is defined %}--init{% endif %}` (vereinfacht) wurde.
Allerdings hat es sich mit der Zeit als komfortabler herausgestellt, Dinge, die keine Logik in Ansible brauchen, als CLI Argumente anzugeben:

```yaml
podman_systemd_run_args:
  - --init
```

Diese werden dann transparent überführt.
Was im Nachhinein betrachtet das gleiche Problem löst, welches ich auch mit Compose oder Kubernetes YAML hatte.
Und es macht das Template vergleichsweise einfach.

### Container löschen oder nicht

Podman hat [`--rm`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#rm) als Argument, um den Container, sobald dieser beendet wurde, zu löschen.
Da die Logs im journald stecken, brauche ich den Container an sich nicht mehr.
Nicht mehr laufende Container mittels [`podman container list --all`](https://docs.podman.io/en/latest/markdown/podman-ps.1.html#all-a) sehen zu können, kann aber auch nett sein.
Und da [`--replace`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#replace) bestehende Container ersetzen kann, warum nicht da lassen?

Zeitweise habe ich Container mit dem `systemd.unit` `BindTo=` verbunden, wenn sie Abhängigkeiten haben.
Eine Datenbank hinter einem Dienst zum Beispiel.
Wenn der Dienst nun via `BindTo=` beendet wird, der Container aber noch da ist, kann eine Abhängigkeit nicht mit `--replace` ersetzt werden.
Es hat also deutlich weniger Probleme gemacht, `--rm` zu verwenden.
Ich vermeide also die Abhängigkeit der Podman Container, während diese auch als systemd Service existiert.

Zwar sehe ich so nicht mehr gestoppte Container in der Liste der Container, kann Probleme aber mit `systemctl` sehen.
Wenn Services neu gestartet werden, gelten diese (noch) nicht als `failed` und befinden sich im `auto-restart`.
Tipp für `systemctl`: `systemctl --quiet --state=failed --state=auto-restart --user` zeigt sowohl `failed` als auch `auto-restart` an.

Und die Abhängigkeiten mache ich mittlerweile mit `Wants=`.
Meistens kommen die Dienste damit klar, wenn die Datenbank im Hintergrund neu gestartet wird und müssen deswegen nicht neu gestartet werden.
Ich spare mir also das neu starten und die strikten Abhängigkeiten zwischen Containern und Services.
Dafür sind gestoppte Container nicht mehr gelistet und können nicht mehr nach Fehlergründen [inspiziert](https://docs.podman.io/en/latest/markdown/podman-inspect.1.html) werden.

### Netzwerke oder Pods

Manche Container müssen miteinander reden, zum Beispiel mit einer Datenbank hinter einem Dienst.
Podman und Kubernetes haben Pods, beim Swarm gibt es Services und alle 3 Tools haben Netzwerke.
Container in einem Pod teilen sich einen Namespace, sprich wie auf einem Computer ohne Namespaces.
Dabei braucht es kein Netzwerk, die Dienste können über localhost miteinander sprechen.
Netzwerke verbinden Container in mehreren Namespaces.
Docker Swarm Services haben standardmäßig ein Netzwerk pro Service, ohne es extra konfigurieren zu müssen.

Pods haben für mich die Konfiguration verwirrender gemacht.
Will ich beispielsweise einen Port öffnen, so muss ich diesen nicht mehr am Container, sondern beim Erstellen des Pod angeben.
Die Konfiguration ist also nicht mehr ganz an dem Punkt, der sie am Ende benötigt.

Ich hatte bisher keinen Vorteil von Pods und verwende immer Netzwerke, die ich im Gegensatz zu Quadlets nicht als systemd Service, sondern mit Ansible erstelle.
(Sowohl `containers.podman.podman_network` als auch [`--network`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#network-mode-net) funktionieren ohne irgendwas in meiner Ansible Rolle, daher ist dies nicht Teil davon.)

Anfangs habe ich noch `--network=container:bla-database` verwendet.
Das war zwar ganz nett, weil ich kein Netzwerk erstellen musste, war aber nervig mit `--replace`, `--rm` und `BindTo=`.

Jetzt hab ich nur noch das (theoretische) Problem, das ein `podman system prune` das Netzwerk löschen könnte, während die Container alle am neu starten sind.

### Volumes, Bindings oder tmpfs

Ich habe mir angewöhnt für persistente Daten immer [Bindings](https://docs.podman.io/en/latest/markdown/podman-run.1.html#mount-type-type-type-specific-option) anzulegen.
Diese kann ich leichter auf einen anderen Server umziehen oder ähnliches und muss nicht erst schauen, wie ich an die Daten in einem Volume komme.

Mit dem Swarm habe ich temporäre Daten in Volumes gepackt.
Wenn ein Container den Host wechselt, dann wird das Volume auf dem neuen Host neu angelegt und nutzt dort wieder temporäre Daten.
Mit Podman und [`--tmpfs`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#tmpfs-fs) geht das ganze noch etwas entspannter.
Solange der Container existiert sind die temporären Daten im `tmpfs` und danach sind diese weg.
Überlebt zwar keinen Container Neustart, ich muss mir aber auch wenig Gedanken darum machen.

Ich hab zwar bis heute nicht herausgefunden, wie ich den Füllstand solch eines `tmpfs` sehen kann oder in welchem `tmpfs` mein RAM eigentlich verschollen ist (Ich freue mich über Hinweise), aber mit eingestellter Maximalgröße (z.B. `size=50M`) bleibt es überschaubar.

### Environment variables

Mit Tools wie `htop` lassen sich die Argumente von anderen Prozessen sehen.
Bei [`podman run --env=secret=123`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#environment) wär das unpraktisch.
Manchmal ist mir das egal, wenn es sicherheitsrelevanter Inhalt ist, nicht.
Dann benutze ich eine von der Ansible Rolle angelegte Datei, welche mit `--env-file` mitgeben wird.
Die Datei kann dann nur vom User (und `root`) gelesen werden.

### rootless: als `systemctl --system` mit `User=` oder als `systemctl --user`

Ein Teil des Unterfangens war ja auch von den `root` Prozessen wegzukommen.
Erster Ansatz war `User=` in System-Services (Wenn `systemctl` `--user` nicht als Argument bekommt, ist `--system` das Standardverhalten).
Diese System-Services können vom User aus nicht (ohne `sudo`) neu gestartet werden.
Podman bringt den `podman-auto-update.service` (und `timer`) mit, welche entweder als `--system` oder als `--user` gestartet werden.
Hier kommt dabei das Problem: `podman-auto-update` muss als User laufen, um die Container zu sehen und zu prüfen, ob diese aktualisiert werden können.
Wenn diese aktualisiert werden, startet `podman-auto-update` den Service neu.
Als User kann aber der System-Service nicht neu gestartet werden.
Daher müssen die Container Services auch als User-Service angelegt werden.

### Webserver

Einige Dienste stellen eine Weboberfläche bereit, die ich gerne nutzen würde.
Dafür gebe ich beim Container [`--publish=[::1]:hostport:containerport`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#publish-p-ip-hostport-containerport-protocol) an und konfiguriere dies in einem `reverse_proxy localhost:hostport` in einer eigenen Caddyfile in `/etc/Caddyfile.d/`, die ebenfalls von Ansible erstellt wird.
Das `[::1]` sorgt dafür, dass diese Portfreigabe nur von meinem localhost erreichbar ist, ist kürzer als `localhost` zu schreiben und ein bisschen IPv6 schadet auch nicht.
Dadurch habe ich auf allen Servern Caddy als Webserver und nicht wie zuvor entweder nginx oder Traefik.
Und Caddy ist wirklich entspannt zu konfigurieren, siehe auch [mein Blogpost dazu]({{< relref "/post/2024/02/14/nginx-to-caddy" >}}).

## Fazit

Bisher funktioniert das ganze entspannt auf meinen Servern und Raspberry Pis.
Ich habe keine als `root` laufende Container mehr.
Und `podman-auto-update` erspart mir die regelmäßigen, manuell angestoßenen Container Updates bei neuen Images.
Ich hab wohl etwas mehr Aufwand als mit Compose Files im Swarm, dafür habe ich aber auch ein gut für mich abgestimmtes System.

Für alle die einen Blick in meine Ansible Rolle werfen wollen, ich habe diese in ein eigenes Repository verfrachtet: <https://codeberg.org/AllesKaese/podman-systemd-ansible-role>.
