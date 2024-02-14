---
title: Mal eben Webserver mit miniserve
date: 2024-02-12T17:31:00+01:00
categories:
  - open-source
tags:
  - command-line
  - linux
  - macos
  - server
  - web
  - website
---

Ich mag statischen Webseitencode.
Wenn ich mit Tools wie `hugo` eine Webseite bearbeite, gibt es `hugo server` um das Ergebnis lokal zu testen, bevor ich es öffentlich stelle.
Ich könnte auch lokal einen ganzen Webserver hosten, aber das ist etwas viel Aufwand.
Seit Ewigkeiten hab ich dafür `python -m http.server` benutzt und bin vor ein paar Wochen über [miniserve](https://github.com/svenstaro/miniserve) gestolpert.

<!--more-->

Mein Hauptproblem an dem Python Einzeiler waren die doch sehr spartanisch wenigen Optionen.
Ich versuche auf Webseiten möglichst gute [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) Header verwenden und auch die könnten mal getestet werden.

miniserve ist eine einzelne Executable, die (fast) ohne Abhängigkeiten auskommt (`glibc`).

```bash
miniserve . \
  --index=index.html \
  --header="Content-Security-Policy: default-src 'none'; base-uri 'none'; form-action 'none'; frame-ancestors 'none'; script-src 'none'; img-src 'self'; style-src 'self';" \
  --header="Cross-Origin-Embedder-Policy: require-corp"
```

(Leicht zu übersehen: Der Punkt deutet auf das aktuelle Verzeichnis hin)

Was ich nicht ganz nachvollziehen kann: Wenn kein `.` für das aktuelle Verzeichnis angegeben wird, gibt miniserve einen Hinweis beim Starten, was passiert, ob das gewünscht ist.
Ich persönlich will selten, dass mein Webserver zum Testen direkt im lokalen Netzwerk hängt.
Das passiert ungefragt, wird aber immerhin halbwegs offensichtlich ausgegeben.
Warum ist das eine Standardverhalten und das andere nicht?

Dafür habe ich mir eine Umgebungsvariable definiert, die ich bei Bedarf überschreiben kann:

```bash
export MINISERVE_INTERFACE=::1
```

Mein Standard Python alias war deswegen übrigens dieser hier:

```bash
alias httpserver='python -m http.server --bind localhost'
```

(Ja ich weiß, Firewalls. Ich finde es aber besser, wenn Tools gar nicht erst ungefragt Ports aufmachen. Je nach Firewall meldet die sich dann auch gleich mit freundlich nervigem Pop-up.)

Ganz nebenbei kann miniserve auch noch mehr.
Dateiübersichten, [Basic-Auth](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication), Uploads annehmen, ….
Nicht sicher, ob ich so viel für meinen Anwendungsfall wirklich brauche oder ob das schon wieder zu viel ist.

Vorteil an dem Python Einzeiler bleibt, dass quasi überall Python existiert.

Andere spannende Frage, wenn du das hier gerade liest und eine Webseite hast: Wie gut funktioniert sie mit den oben definierten Headern noch?
Wirf dabei auch gern noch mal einen Blick auf mein Post zu [Qualitätschecks von Webseiten]({{< relref "/post/2021/07/06/website-quality-checks" >}}).
