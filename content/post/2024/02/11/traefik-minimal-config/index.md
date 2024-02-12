---
title: Minimale Traefik Konfiguration
date: 2024-02-11T11:13:00+01:00
categories:
  - open-source
tags:
  - container
  - server
  - web
aliases:
  - /post/2024/02/10-traefik-minimal-config
---
Ich habe seit Jahren einen Docker Swarm am Laufen, für den ein Traefik als Reverse Proxy, Edge Router, Ingress oder wie auch immer eins das nennen möchte, läuft.
Ich bin gerade dabei Traefik und den Docker Swarm abzulösen (dazu kommt auch noch ein Blogpost).
Die Traefik Doku und Nutzung war mir über die Jahre nicht gut genug, als das ich explizit bei Traefik bleiben wollen würde.
Jetzt beim Rauswerfen fiel mir auf, das meine bisherige Traefik Konfiguration vergleichsweise nett ist und mal verewigt werden könnte.
Dann haben vielleicht andere noch etwas davon.

<!--more-->

Meine Konfiguration besteht aus statischer Konfiguration mittels Kommandozeilenargumenten, einer Konfigurationsdatei (für den "file provider") und Labels an den jeweiligen Services, die freigegeben werden sollen.

Im Gegensatz zu anderen Beispielen, die ich (damals?) so fand, macht mein Setup eine automatische HTTPS Weiterleitung, ohne dass das an jedem Service wieder aktiviert werden muss.

Hinweis zu Traefik v3:
Diese Konfiguration ist für Traefik v2.10.
Sobald Traefik v3 veröffentlicht wird, wird es [ein paar Änderungen](https://doc.traefik.io/traefik/v3.0/migration/v2-to-v3/) brauchen.
Leider bleibt v3 vergleichsweise umständlich, was mit ein Grund für mich ist, traefik in Zukunft nicht weiterzuverwenden.

## `traefik.yml` (compose file)

Auskommentiert sind ein paar Optionen, die zum Testen hilfreich sind.

```yaml
version: "3.7"

networks:
  net:

configs:
  dynamic:
    file: ./secrets/traefik_dynamic.yml

volumes:
  letsencrypt:

services:
  reverse-proxy:
    image: docker.io/library/traefik:v2.10
    command:
      # - --api.insecure=true # Web UI on port 8080
      # - --log.level=DEBUG
      # - --certificatesresolvers.myhttpchallenge.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory
      - --certificatesresolvers.myhttpchallenge.acme.email=…
      - --certificatesresolvers.myhttpchallenge.acme.httpchallenge.entrypoint=web
      - --certificatesresolvers.myhttpchallenge.acme.storage=/letsencrypt/acme.json
      - --entrypoints.web.address=:80
      - --entrypoints.web.http.redirections.entryPoint.scheme=https
      - --entrypoints.web.http.redirections.entryPoint.to=websecure
      - --entrypoints.websecure.address=:443
      - --entrypoints.websecure.http.middlewares=secure-headers@file
      - --entrypoints.websecure.http.tls.certResolver=myhttpchallenge
      - --entrypoints.websecure.http3
      - --experimental.http3
      - --providers.docker
      - --providers.docker.exposedbydefault=false
      - --providers.docker.network=traefik_net
      - --providers.docker.swarmMode=true
      - --providers.file.filename=/etc/traefik/dynamic.yml
    configs:
      - source: dynamic
        target: /etc/traefik/dynamic.yml
    ports:
      - target: 80
        published: 80
        protocol: tcp
        mode: host
      - target: 443
        published: 443
        protocol: tcp
        mode: host
      - target: 443
        published: 443
        protocol: udp
        mode: host
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - letsencrypt:/letsencrypt:rw
    networks:
      - net
    deploy:
      placement:
        constraints:
          - node.role == manager
```

## `dynamic.yml`

Hier werden hier die TLS Chiffren begrenzt und Security Header gesetzt.
Siehe mein Post zu [Qualitätschecks von Webseiten]({{< relref "/post/2021/07/06/website-quality-checks" >}}).
Diese werden dann bei allen Diensten hinter dem `entrypoint.websecure` verwendet (via CLI konfiguriert).

```yaml
tls:
  options:
    default:
      cipherSuites:
        - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
        - TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305

http:
  middlewares:
    secure-headers:
      headers:
        # https://doc.traefik.io/traefik/v2.9/middlewares/http/headers/
        browserXssFilter: true
        contentTypeNosniff: true
        frameDeny: true
        referrerPolicy: no-referrer
        stsIncludeSubdomains: true
        stsSeconds: 31536000
```

## pro Service

Dieser Schritt passiert am häufigsten und fast jedes Mal habe ich irgendetwas vergessen.
Der Service ist nicht im `traefik_net` oder `uniquename` war noch der von vor dem von irgendwo kopieren.
Schon etwas unnötig nervig.
Für das vergessene `traefik_net` kann Traefik nichts.
Für die etwas umständlichen Label schon.

```yaml
networks:
  traefik_net:
    external: true

services:
  bla:
    image: …
    networks:
      - default
      - traefik_net
    deploy:
      labels:
        - traefik.enable=true
        - traefik.http.services.uniquename.loadbalancer.server.port=8080
        - traefik.http.routers.uniquename.rule=Host(`….edjopato.de`)
```
