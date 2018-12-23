---
background:
  name: Luhepark Winsen
  style: url(/assets/backgrounds/luhepark3.jpg)
categories:
- tti
date: 2017-07-15T21:30:00+02:00
lastmod: 2017-07-24T08:50:00+02:00
tags:
- bpaas-angebot
- docker
- docker-swarm
- infrastruktur
- portainer
title: Die Infrastruktur
aliases:
- /blog/tti/2017/07/15/infrastruktur.html
---

Für unser BPaaS Angebot haben wir uns, da wir als Team größtenteils aus technischen Informatikern bestehen, dafür entschieden, eine eigene Lösung für das Hosting zu nutzen, statt eine Fremde zu adaptieren.
Dafür bot sich eine Container basierte Infrastruktur an, wofür Docker, genauer Docker Swarm, gewählt wurde.

Ein Vorteil, der zu dieser Entscheidung führte, ist die Abstraktion, mit welcher Programmiersprache und Umgebung die Ziele der jeweiligen Komponente erfüllt werden.
(Eine Übersicht über alle Komponenten gibt es [hier]({{< relref "2017-07-15-architektur.md" >}}).)
Die Nutzung vieler unterschiedlicher Programmiersprachen sorgt zwar für eine schlechtere Wartbarkeit, da nicht jeder jede Komponente warten kann, wurde innerhalb dieser Aufgabenstellung jedoch in Kauf genommen.
Außerdem ist die Nutzung eines Systems wie Docker Swarm gegenüber Kubernetes vergleichsweise einfach, da Docker Swarm Bestandteil von Docker ist und mit jeder (neueren) Docker Installation genutzt werden kann.

Zur Verwaltung unserer Docker Swarm Umgebung wurde ein Frontend genutzt, welches in unserem Fall das eher simple Frontend [Portainer](//portainer.io) wurde.
Alternativen dazu wären [Shipyard](//shipyard-project.com/) oder [Rancher](//rancher.com/rancher/) gewesen, jedoch wurden diese für komplexere Anwendungsfälle geschaffen und würden unsere simplen Nutzungsanforderungen sprengen (oder den Versuch, diese zu installieren, ohne Jahre zu brauchen).

![Portainer](/assets/2017/07/portainer.png)
Ein Blick auf unsere Portainer Installation und die dort laufenden Services im Docker Swarm.

Da wir unsere Docker Swarm Installation auf Servern der HAW Hamburg laufen haben, haben wir auch die dort geltenden Firewall Regeln, es stehen uns von außen also nur sehr wenige Ports zur Verfügung.
Aufgrund dessen haben wir einen [Nginx](//nginx.org/) Reverse Proxy auf unsere internen HTTP Komponenten eingerichtet, damit diese von außen erreichbar sind.
So konnten auch alle Dienste über ein gemeinsames [Let's Encrypt Zertifikat](//letsencrypt.org/) absichert und über HTTPS angeboten werden.

Für die jeweiligen Kommunikationsarten innerhalb unseres Netzwerks wurden Docker Netzwerke eingerichtet.
So kommunizieren beispielsweise alle Docker Container mit [RabbitMQ](//rabbitmq.com) Kommunikation über das RabbitMQ Netzwerk.

Um unsere Docker Container bereit zu stellen wurden die Container automatisch mit der [GitLab CI](//about.gitlab.com/features/gitlab-ci-cd/) gebaut und (wenn man erzählt bekommen hat, das und wie dies geht) automatisch in unserem Produktivsystem deployed.

Mit Hilfe dieser Infrastruktur konnten die einzelnen Komponenten entspannt entwickelt und getestet werden.
