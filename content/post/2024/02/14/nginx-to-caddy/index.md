---
title: Statische Webseiten von nginx zu Caddy
date: 2024-02-14T23:00:00+01:00
categories:
  - open-source
tags:
  - ansible
  - linux
  - server
  - web
  - website
---

Ich mag Webseiten mit statischem Quellcode.
Wenn möglich baue ich meine Webseiten so, zum Beispiel diesen Blog.
Um diese Webseiten dann auszuliefern braucht es einen Webserver.
Bis vor ein paar Wochen war das jahrelang nginx, jetzt bin ich zu Caddy gewechselt.

<!--more-->

## Warum der Wechsel?

Ich war mit nginx nicht komplett unglücklich.
nginx funktionierte gut und ist in Benchmarks auch mit einer der besten Webserver.
nginx ist auch weit verbreitet, es lassen sich viele Beispiele im Internet finden, die Doku ist brauchbar.
Allerdings ist mir die Konfiguration etwas gesprächig und die Zertifikate (für HTTPS) etwas lästig zu handhaben.
Habe ich alles mit Ansible automatisiert, geht also, aber warum muss ich etwas automatisieren, was alle anderen genauso automatisiert brauchen?
Sollte der Webserver das nicht schon selbst können?
Ich war also nicht komplett unzufrieden, sondern eher auf der Suche nach "noch besser" und "einfacher".

## Bisheriges Setup mit nginx und Ansible

Für nginx habe ich die Hauptkonfigurationsdatei (`/etc/nginx/nginx.conf`), zusätzliche generische Einstellungen, die jeweils in die Webseiten via `include` eingebunden wurden und die Webseiten selbst (`/etc/nginx/sites-available/`).
Außerdem sind unter `/etc/letsencrypt/live/` die vom [`certbot`](https://certbot.eff.org/) verwalteten Zertifikate, die einmal erstellt und danach vom `certbot` automatisiert aktualisiert werden.

Das habe ich dann alles mit Ansible Tasks und Templates abgebildet, zum Beispiel zum Erstellen des Zertifikats.

```yaml
- name: Generate certificate with LetsEncrypt for {{ domain }}
  notify: Reload nginx
  ansible.builtin.command:
    cmd: certbot certonly --non-interactive --nginx --agree-tos --email redacted --domain {{ domain }}
    creates: /etc/letsencrypt/live/{{ domain }}/fullchain.pem
```

Was mir dabei immer mal auf die Füße fiel, waren die Zertifikate vom certbot.
Wenn ich eine Webseite herausgenommen habe, habe ich irgendwann später mal festgestellt, dass der certbot immer wieder scheiterte, das Zertifikat für den nicht mehr vorhandenen DNS Eintrag zu aktualisieren.
Das Entfernen habe ich nie automatisiert, habe ich so hingenommen, auch wenn es über die Jahre mehrfach passierte.
Aus meiner Sicht einer der Dinge, die ein Webserver für mich machen sollte, da sollte ich nicht selber hinterher müssen.

Eine Domain, die weiterleitet, ist (im Vergleich zu Proxy oder statischem Ausliefern) der einfachste Fall für nginx, dafür kam folgendes Template zum Einsatz.
Auch das ist schon vergleichsweise lang, für meinen Geschmack zu lang.

```nginx
server {
  listen 80;
  listen [::]:80;
  listen 443 http2 ssl;
  listen [::]:443 http2 ssl;

  server_name {{ domain }};

  access_log off; # /var/log/nginx/{{ domain }}.access.log;
  error_log /var/log/nginx/{{ domain }}.error.log;

  ssl_certificate /etc/letsencrypt/live/{{ domain }}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{{ domain }}/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/{{ domain }}/chain.pem;

  include /etc/nginx/basics/security.conf;

  location / {
    include /etc/nginx/basics/security-header.conf;
    return 302 {{ target }};
  }
}
```

Was mich etwas genervt hat: `add_header` überschreibt andere `add_header` in anderen Kontexten der Konfiguration.
Wenn ich also in `security.conf` `add_header` verwende und dann in `location /` noch mal Header setzen will, ist das ein anderer Kontext und würde die Security Header überschreiben.
Ich musste den Security Part also zweiteilen, damit die immer generisch funktionieren.
(`security.conf` beinhaltet so Dinge wie `.dotfiles` blockieren (außer `.well-known`), `security-header.conf` setzt Header wie `Referrer-Policy`.)

Witzig wurde es dann mit den Templates für Proxys oder statische Webseiten.
Brauche ich [CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS) Header?
[`Cache-Control`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control)?
Was ist jeweils die [`Content-Security-Policy`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy)?
Es braucht eine HTTP → HTTPS Weiterleitung.
Ist es eine Single-Page-Application, also welche Art von `try_files` wird benötigt?

Es gab also eine gewisse Menge an Entscheidungen und Variablen in den Templates.

Für das Befüllen dieser Variablen fand ich die YAML Syntax für mehrzeilige Inhalte in Kombination mit der `Content-Security-Policy` nett.
Dabei wird `>-` automatisch auf eine Zeile zusammengefasst, getrennt durch Leerzeichen.
Ich habe den CSP also relativ leicht lesbar dokumentiert und wird automatisch im Template als eine lange Zeile benutzt.

```yaml
- ansible.builtin.include_tasks: tasks/nginx/www.yml
  vars:
    domain: edjopato.de
    csp: >-
      default-src 'none';
      base-uri 'none';
      form-action 'none';
      img-src 'self';
      manifest-src 'self';
      script-src 'self';
      style-src 'self';
```

Was dabei auch auffällt: `frame-ancestors 'none';` fehlt im CSP.
Bei nginx fügt `add_header` weitere Header hinzu.
Ich habe also generelle CSP generell in `security-header.conf` ausgelagert und nginx setzt alle Header, die Browser setzen die dann zusammen.
Dieser Ansatz hat sich bei Caddy als unpraktisch erwiesen, dazu später mehr.

Durch dieses Wunderwerk kamen dann neben den Playbooks 15 Dateien in meinem Ansible Ordner zusammen, dessen Job es war, meine nginx Webseiten glücklich zu halten.
War schon cool wie das alles funktionierte, aber auch etwas übertrieben.

## Wie funktioniert es mit Caddy

Meine erste Erwartung beim Ausprobieren mit Caddy war auch wieder Templates zu brauchen, wenn auch hoffentlich weniger komplexe.
Aber ich benutze Ansible jetzt wirklich nur noch zum durch die Gegend Kopieren von Dateien, ohne Logik oder Verzweigungen durch Ansible.
Die Logik bleibt rein in den Caddyfiles, den Konfigurationsdateien von Caddy, was das ganze auch wieder unabhängiger von Ansible macht.

Wie genau arbeitet Caddy?
Caddy hat intern eine große JSON Konfiguration, die dynamisch zu Laufzeit angepasst werden kann.
Statische Konfiguration erfolgt über Caddyfiles, die beim Laden in besagtes JSON umgewandelt werden, davon bekommt eins beim Benutzen aber nicht viel mit.

Die dynamische Konfiguration, ähnlich wie ich sie [von traefik kenne]({{< relref "/post/2024/02/11/traefik-minimal-config" >}}), habe ich relativ schnell ignoriert.
Sie passt nicht zu meinem Anwendungsfall.
Ich weiß was auf meinen Servern läuft und wenn sich etwas ändert, dann weiß ich danach auch wieder, welcher Zustand gegeben sein soll.

Caddyfiles benutzen eine eigene Syntax und können, wie auch nginx das kann, mit `import` andere Dateien einbeziehen.
Ein spannendes Konzept sind dabei die Snippets, welche ohne eigene Datei auch so definiert und mittels `import` benutzt werden können.
So habe ich die zusätzlichen Dateien, die ich bei nginx übergreifend brauchte, als Snippets mit in die Haupt-Caddyfile geschrieben.
Aus dem nginx `include <path>/security.conf` wurde also `import security`.

Bei nginx habe ich die Weiterleitung als Beispiel gezeigt, wie sieht diese bei Caddy aus?

```Caddyfile
rain-brain.de, rain-brains.de {
	import security
	redir https://rain-brainz.de{uri}
}
```

Zertifikate werden automatisch erstellt (vor allem mit sicheren Standardeinstellungen, ich muss da nichts zusätzlich, wie bei nginx (oder traefik), explizit einstellen).
HTTP zu HTTPS Weiterleitung gibt es ebenfalls automatisch.
HTTPS, HTTP2 und HTTP3 werden automatisch angenommen und müssen nicht nochmal definiert werden.
Für all das wird keine extra Konfiguration benötigt, der Großteil der oben gezeigten nginx Konfiguration funktioniert also von selbst.

(Ein Nachteil: Vorher wurde auch ein HTTP Aufruf schon weitergeleitet. Mit Caddy wird jetzt erst HTTPS und dann die Weiterleitung gemacht.)

Und auch eine statische Webseite ist deutlich einfacher.

```Caddyfile
edjopato.de {
	import basewww
	import hugocache
	root * /var/www/edjopato.de
	header Content-Security-Policy "default-src 'none'; base-uri 'none'; form-action 'none'; frame-ancestors 'none'; img-src 'self'; manifest-src 'self'; script-src 'self'; style-src 'self'; upgrade-insecure-requests;"
}
```

Hier habe ich mir wieder die Snippets zunutze gemacht.
Ich habe mehrere mit Hugo erstellte Seiten, die brauchen alle die gleiche Cache-Logik, habe ich also gruppiert.
Was früher mein `www` Template war, ist jetzt quasi das `basewww` Snippet.

Alle meine Webseiten brauchen die Security Dinge, Fehlermeldungsseiten (403, 404, 500, …) und sollen die Dateien aus ihrem Verzeichnis (`file_server`) komprimiert (`encode`) ausliefern.

```Caddyfile
(basewww) {
	import errorpage
	import security
	encode zstd gzip
	file_server
}
```

### Header

Ich hatte es beim nginx Teil schon erwähnt, dort habe ich `add_header` verwendet und mache das mit Caddy etwas anders.
Das spannende hier ist die Header Syntax mit einem `?` vor dem Header Namen.
Das Fragezeichen bedeutet, dass der Header erst nach dem Abarbeiten des Requests geprüft und angehängt wird, wenn dieser dann noch nicht existiert.
Es ist also quasi ein Standardwert, falls dieser nicht anders gesetzt wird.
Mein Security-Snippet beinhaltet diese Zeile:

```Caddyfile
header ?Content-Security-Policy "frame-ancestors 'none'; upgrade-insecure-requests"
```

Im Beispiel von `edjopato.de` wird dieser Header gesetzt, existiert also und wird nicht (nochmal) gesetzt.
Ein anderer Eintrag hat aber vielleicht keinen CSP, dort wird also der Standardwert genutzt.
Mal schauen, vielleicht verwende ich da in Zukunft auch einen noch strikteren CSP als Standardwert.

Noch eindrucksvoller ist das bei `header ?Cross-Origin-Embedder-Policy "require-corp"`.
Meistens will ich genau das haben, außer in Ausnahmen, wenn ich wirklich einen anderen Wert für diesen Header brauche.
Die meisten Einträge setzen hier also keinen anderen Wert.
Wenn ich mir keine Gedanken darum mache, ist es sinnvoll, ich muss explizit handeln, um mit dieser Konfiguration etwas Unsichereres zu bekommen.
Vermutlich geht das etwas auf die Performance vom Webserver, aber es macht die Konfiguration so viel entspannter.

### Fallstricke

Bei meinen ersten Experimenten mit Caddy bin ich über ein paar Dinge gestolpert, die ich hier einmal kurz anreißen will.

Mehrere Header können gruppiert werden.
Das ist im Caddyfile ganz nett, sieht etwas einfacher aus, funktioniert aber mit dem `?` nicht wie erwartet.
Steht auch in der Doku, hab ich aber erst realisiert, nachdem ich mich darüber gewundert hatte, was da passiert.
(Persönliche Meinung: Ist verwirrend, sollte deprecated werden, ansonsten stolpern da noch mehr Menschen¹ genau wie ich drüber. Und spart wirklich nicht viele Zeichen.)

```diff
-header {
-  ?Content-Security-Policy "frame-ancestors 'none'; upgrade-insecure-requests"
-  ?Cross-Origin-Embedder-Policy "require-corp"
-}
+header ?Content-Security-Policy "frame-ancestors 'none'; upgrade-insecure-requests"
+header ?Cross-Origin-Embedder-Policy "require-corp"
```

Caddyfiles unterstützen mehrzeilige Werte.
Auch bei Headern.
Firefox auch.
Chromium nicht.
Etwas schade, hatte gehofft wieder mehrzeilige CSP benutzen zu können.

```diff
-header Content-Security-Policy "frame-ancestors 'none';
-upgrade-insecure-requests"
+header Content-Security-Policy "frame-ancestors 'none'; upgrade-insecure-requests"
```

Caddy kann auch eine `<<heredoc` Syntax, aber erst ab 2.7.
Hab immer fröhlich die Caddyfiles lokal auf meinem Arch Linux validiert und dann auf Debian / Alma Linux ausprobiert.
Letztere haben noch 2.6, da kam ich damit nicht weit.
Geht aus der Doku leider nicht so klar hervor, dafür musste ich Changelog lesen.

Die Anordnung der Directives im Caddyfile ist nicht unbedingt die Reihenfolge, in der diese abgearbeitet werden.
Die Reihenfolge unterschiedlicher Directives zueinander ist [dokumentiert](https://caddyserver.com/docs/caddyfile/directives#directive-order).
Unter gleichen Directives sind die [request matchers](https://caddyserver.com/docs/caddyfile/matchers) relevant, auf die ich hier bisher gar nicht erwähnt habe. Wird gleich noch mal im folgenden Beispiel relevant und ist am Beispiel erklärt.

## Spezialseite ip.edjopato.de

Ich habe eine Seite, die exakt nur die öffentlich sichtbare IP des aufrufenden Clients zurückgibt.
[ipv4.edjopato.de](https://ipv4.edjopato.de) und [ipv6.edjopato.de](https://ipv6.edjopato.de) tun ebenfalls das erwartete, jeweils über DNS Einträge, die nur einen `A` oder `AAAA` Eintrag haben.
Das habe ich ohne irgendwelche externen Dinge wie PHP in nginx gelöst und wollte das eigentlich auch genauso wieder in Caddy haben.
Und auch das geht mit Caddy.

nginx:

```nginx
location = / {
  default_type "text/plain; charset=utf-8";
  return 200 "$remote_addr\n";
}

location / {
  return 301 /;
}
```

Caddy:

```Caddyfile
route {
  respond / "{http.request.remote.host}
"
  redir * / permanent
}
```

Relevant ist hier ein Punkt, den ich schon in den [Fallstricken](#fallstricke) erwähnt habe.
Bei nginx gibts zwei `location` Einträge, einer mit `= /` welcher präziser ist als der andere.
Also wird bei exaktem Treffer zuerst der `= /` verwendet.
Das funktioniert bei Caddy ähnlich aber anders.
Zwar ist `/` präziser als `*`, aber `redir` wird vor `respond` angewendet.
Es muss also mit `route` eine Reihenfolge erzwungen werden.

Hat einen Moment gebraucht mich an diese Logik zu gewöhnen, hat aber Vorteile, gerade in Verbindung mit Snippets.
Egal wo das Snippet eingebunden wird, es funktioniert, da die Reihenfolge keine Relevanz hat.

## Fazit

Für mich fühlt sich Caddy deutlich robuster an, was die Konfiguration angeht.
Im Gegensatz zu nginx definiere ich nicht alles (via Template) für jede Domain wieder, sondern habe sinnvolle Standardwerte, die ich bei Bedarf überschreibe.
Das funktioniert so in der Form mit nginx `add_header` oder unterschiedlichen Werten für Pfade (Zertifikate) nicht.

Ich habe eine Basis Caddyfile, die auf allen Servern exakt gleich ist.
Alles Weitere ist in vergleichsweise kurzen Unter-Caddyfiles konfiguriert, meistens viele gemeinsam in einer Datei.
Dort werden dann nur noch existierende Snippets verwendet, zusätzlich die Spezialfälle der jeweiligen Seite.
Ansible kopiert diese nur noch an die jeweilige Position auf dem Server.

Perfekt ist Caddy definitiv (noch?) nicht.
Ich hatte mehrfach die Situation, das Dinge unerwartet waren, auch wenn ich `caddy validate` benutzt habe.
Änderungen an der großen Config sollten weiterhin getestet werden (mit jeder Browser Engine).
Derartige Änderungen mache ich nach dem ersten Einrichten aber vermutlich auch nicht häufig.

Aber einen Eintrag hinzufügen oder entfernen, der wie die anderen Einträge auch meine Standard-Snippets benutzt, funktioniert wirklich entspannt und problemfrei.
Und genau der Part fühlt sich so viel besser an, als es das mit der ganzen Ansible Logik und Templates mit nginx tat.
Ich brauche kein weiteres Tool mehr, um das Tool zu bedienen.
