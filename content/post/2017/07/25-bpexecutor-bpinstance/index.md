---
title: BPExecutor und BPInstance
date: 2017-07-25T13:08:00+02:00
resources:
  - name: cover
    title: Luhepark Winsen
    src: luhepark4.jpg
categories:
  - tti
tags:
  - bpaas-angebot
  - haw-hamburg
---

Die beiden Hauptkomponenten unseres Systems: Der BPExecutor und die BPInstance.
Diese verleihen unserem System die ausführbaren Business Prozesse.
Zudem sind diese beiden Komponenten auf unseren eigenen Ideen zur Erreichung dieses Ziels entstanden.
Da sie eng miteinander arbeiten, beschreibe ich diese auch in einem gemeinsamen Artikel.

Wofür sind diese Komponenten nun genau?
Geht man nach den Namen, muss der BPExecutor etwas Ausführungen, und die BPInstance eine Instanz aufrecht erhalten.
Und genau dem entspricht dies auch: Der BPExecutor sorgt dafür, das ein Startauftrag eines Business Prozesses entgegen genommen wird, die benötigten Daten gesammelt werden und dann an eine freie BPInstance übermittelt werden kann.
Die BPInstance kümmert sich dann für die gesamte Laufzeit des Business Prozesses um diesen und alle integrierten Services.

# BPExecutor

Der BPExecutor bekommt in einer RabbitMQ Queue Startaufträge für Business Prozesse.
Diese Startaufträge umfasst den User, der diesen ausführen will und die ID des im System hinterlegten Business Prozesses.
Mit der ID holt sich der BPExecutor aus dem Data Center die genaue Beschreibung des Business Prozess.
Diese gesammelten Informationen über einen, nun startbaren Business Prozess legt der BPExecutor in eine weitere RabbitMQ Queue.

# BPInstance

Aus der Queue kann sich nun eine freie BPInstance einen neuen Business Prozess holen.
Um mit dem ersten Service zu beginnen fragt die BPInstance auf der BaseUrl des Services den Service Anbieter nach den genauen Routen einer Service Instanz.
Mit diesen Service Instanz Routen kann die BPInstance nun seine Arbeit beginnen:
Auf der Result Route fragt die BPInstance per Long Polling nach dem Ergebnis des Services.
Auf der Data Route wird ebenfalls per Long Polling nach weiteren benötigten Daten des Services gefragt.
Diese Daten können von vorher gelaufenen Services im selben Business Prozess stammen und werden in der BPInstance gehalten.
Außerdem kann der Service eine GUI Route bereit stellen.
Diese GUI Route bietet das User Interface für den Endnutzer an.

Da das Frontend diese GUI Route benötigt, um das GUI darzustellen, stellt das Frontend anfragen für die aktuelle GUI Route eines Business Prozesses an die API.
Die API sendet dann mit einem RabbitMQ Fanout an alle laufenden BPInstances die Frage, welche Instanz gerade diesen Business Prozess ausführt und welche GUI Route diese gerade hat.
Genauer beschrieben wird das im [Blog Post](https://tti-ss2017-portfolio.jimdo.com/2017/07/08/kommunikation-api-und-bpinstance/) vom Zuständigen unseres Teams für die API.

Der Vorteil an dieser Herangehensweise ist die einfache Skalierbarkeit.
Die Anzahl der Laufenden BPInstance Docker Container bestimmt die Anzahl der maximal gleichzeitig laufenden Business Prozesse in unserem System.
