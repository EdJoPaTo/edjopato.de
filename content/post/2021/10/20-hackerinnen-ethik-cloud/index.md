---
title: Hacker*Innen Ethik und die Cloud
date: 2021-10-20T02:17:00+02:00
resources:
  - name: cover
    src: beamer.jpg
    title: Eine Person sitzt zwischen Beamer und Leinwand, welche das Jugend hackt Logo zeigt
categories:
  - open-source
tags:
  - linux
  - macos
  - server
  - windows
---
Bei [Jugend hackt](https://jugendhackt.org/) gibt es am ersten Tag auf den Events meistens ein [Hacker*Innen-Ethik](https://www.ccc.de/de/hackerethik) Minispiel mit allen Teilnehmenden.
Dort werden Fragen und 3 Antwortmöglichkeiten gegeben, die sich meistens nicht eindeutig beantworten lassen.
Man ordnet sich dann den Antworten zu und es wird nach Meinungen gefragt, warum man jeweils die Antwort für sinnvoll hält.
So entstehen häufig Diskussionen zu den Themen.

Jetzt dachte ich mir, vielleicht schaue ich mal mit diesem Blick auf die Cloud, auf die ich bereits in [meinem letzten Blogartikel]({{< relref "/content/post/2021/10/18-cloud/index.md" >}}) eingegangen bin.
Natürlich wird mein Blickpunkt nie vollständig und perfekt abbilden, wie man etwas machen kann und sollte.
Deswegen lohnt sich immer ein Blick auf andere Standpunkte und fremde Philosophien.
Die Grundsätze in der Hacker*Innen-Ethik werden von vielen im Chaos-Umfeld akzeptiert und bieten damit wohl einen interessanten Blickpunkt.

# Hacker*Innen 0, 1 | 2

Um mal ein Beispiel für so eine Frage aus dem "Hacker*Innen 0, 1 | 2" zu nennen:

> Ich erstelle eine Webseite und möchte diese besonders schön machen. Google Fonts bieten mir dafür eine Möglichkeit.
>
> 0. Ich nutze diese und weise in meiner Datenschutzerklärung darauf hin.
> 1. Ich nutze diese, biete aber eine Opt-out Möglichkeit an.
> 2. Ich nutze diese nicht, um die Privatsphäre der Nutzer*Innen zu schützen.

Hier gibt es unterschiedliche Meinungen, die diskutiert werden und Einige merken an, dass man die Fonts herunterladen und selbst hosten kann, wodurch Google die Möglichkeit des Trackings verliert.
Am Ende werden dann die jeweils zur Frage relevanten Grundsätze aus der Hacker*Innen-Ethik aufgezeigt und es geht zur nächsten Frage.
Bei dieser Frage sind das "Misstraue Autoritäten – fördere Dezentralisierung" und "Öffentliche Daten nützen, private Daten schützen".

# Grundsätze der Hacker*Innen-Ethik

Im Folgenden gehe ich die Grundsätze durch, vergleiche diese mit meiner Meinung aus dem letzten Post und fasse ein paar neue Gedanken.
Natürlich überschneiden sich einige der Grundsätze und fassen ineinander.

> Der Zugang zu Computern und allem, was einem zeigen kann, wie diese Welt funktioniert, sollte unbegrenzt und vollständig sein.

In meinem letzten Post ging ich darauf ein, dass man immer erklären können sollte, wie seine eigene Lösung funktioniert.
Mein Interesse daran war jedoch nicht unbedingt die Aufklärung, sondern das Aufzeigen von Lücken.
Wenn ich den Grundsatz so lese, wäre es jedoch eine gute Idee, gut zu dokumentieren, wie die eigene Cloud Lösung so funktioniert.
So kann man selbst (und andere) verstehen, was genau dort alles passiert.
Hier hilft es dann natürlich wieder Komplexität zu vermeiden und simplere Systeme zu nutzen, diese sind einfacher zu erklären.

Ein anderer Aspekt, der in diesem Grundsatz noch mit schwingt, ist der Zugang zu Computern.
Man sollte dabei unterstützen, dass alle einen Zugang dazu finden.
Stellt man die Cloud auch Anderen zur Verfügung, dann sollten alle diese benutzen können.
Die Systeme sollten mit schwächeren Computern funktionieren, blinde Nutzer brauchen einen für sie geeigneten Zugriff und nicht so bewanderte Nutzer brauchen Anleitung an komplexe Systeme.

> Alle Informationen müssen frei sein.

Frei kann viel bedeuten.
Für alle zugänglich, kostenlos, benutzbar, in anderen Kontexten verwendbar, ….

Hierbei fällt mir das [5-Sterne-Modell](https://5stardata.info/de/) von Tim Berners-Lee ein.
Das gilt natürlich nicht nur für Daten, die zum Beispiel auf Open Data Plattformen von Städten veröffentlicht werden, sondern für alle Daten.
Es ist schon mal gut, wenn man Daten überhaupt bekommt, selbst wenn sie nur unstrukturiert (PDF) vorliegen.
Besser sind maschinenlesbare, strukturierte Daten.
Ein Freund hatte hier eine Formulierung, die mir im Kopf geblieben ist:
"Nur weil ein Mensch visuell eine Struktur erkennt, sind das noch keine strukturierten Daten."

> Misstraue Autoritäten – fördere Dezentralisierung

Autoritäten sind im Falle der Cloud Konzerne wie Apple, Google, Microsoft, GitHub und so weiter.
Ein bisschen ging ich auch darauf in meinem letzten Post ein.
Wenn ich die Cloud von so einem Anbieter gar nicht erst nutze oder Ende-zu-Ende-Verschlüsselung einsetze, dann haben diese gar nicht erst die Möglichkeiten an meine Daten zu kommen.
Meine Daten so abzulegen, dass ich unabhängig von einem Anbieter bin und einfach von einem zum Anderen wechseln kann ist ein weiterer guter Schritt.
Das Ideal sollte sein, nicht auf große Anbieter zu vertrauen, sondern dezentralisiert auf viele kleinere Anbieter zu setzen (oder selbst Anbieter meiner eigenen Plattform zu werden).
Das ist natürlich kein Entweder-oder, ich kann mich frei auf dieser Achse bewegen, eine lokale Firma ist etwas anderes als ein weltweit agierender Konzern (und alles hat seine eigenen Vor- und Nachteile, denen man sich bewusst werden sollte).

Misstraue Autoritäten heißt auch, dass nicht, weil ein Anbieter etwas sagt, dies auch stimmt.
Natürlich sagt eine Firma von sich selbst, sie sei großartig.
Man muss sich nur anschauen, was Facebook so alles gesagt hat und was danach in Gerichtsverfahren herauskam.
Wenn der erste Grundsatz beachtet wird, kann man selbst nachprüfen, ob die Aussagen stimmen und so das Misstrauen befriedigen.
Allein die Möglichkeit dazu zu haben, schafft schon Vertrauen.

Aus Sicht der Dezentralisierung ist es eine gute Idee, Daten nicht alle bei einem Anbieter liegen zu haben, sondern auf mehrere zu verteilen.
Das soll nicht heißen, dass man die Daten aus einer Problemdomäne aufsplitten sollte, sondern das man unterschiedliche Probleme getrennt voneinander behandeln können sollte.
Es ist beispielsweise besser Trello, Gitlab und Google Drive zu verwenden, statt alles als riesigen Haufen zu Microsoft zu schieben (Planner, Azure, OneDrive).
Dadurch wird man resilienter bei einzelnen Problemdomänen, statt arbeitsunfähig, wenn plötzlich alles tot ist.

Dezentralisierung muss aber nicht nur die Dienste und Orte meinen, es kann auch Verantwortung meinen.
Für die eine Problemdomäne ist jemand anders verantwortlich als für eine andere.
Einige Firmen überlassen den Teams beispielsweise sehr viele Entscheidungen, wie und wo sie ihre Projektdaten ablegen (solange bestimmte Ansprüche erfüllt sind).
Das eine Team benutzt dann eben MacBooks und Apples "Numbers" Applikation, während das Nächste mit "Collabora Online" Spreadsheets bearbeitet.

> Beurteile einen Hacker nach dem, was er tut, und nicht nach üblichen Kriterien wie Aussehen, Alter, Herkunft, Spezies, Geschlecht oder gesellschaftliche Stellung.

Da hier Clouds relevant sind, sollte man vielleicht Anbieter nach dem Beurteilen, was diese tun.
Microsoft hatte beispielsweise relativ früh Ansätze, ihre Cloud in Europa von deutschen Firmen hosten zu lassen, sodass Microsoft selbst aus den USA gar keinen Zugriff auf diese Systeme bekam.
Diese Ansätze waren mit europäischen Sicherheitsstandards konform, werden so jedoch leider nicht mehr angeboten.
Der Privacy Shield wurde mit der Begründung gekippt, die US-Geheimdienstrechte kompromittieren das europäische Verständnis von Datensicherheit.
Ein Schelm wer dabei daran denkt, warum Microsoft diese Art von Angebot nicht mehr anbietet…

Die vielen Sicherheitsprobleme, die zum Beispiel Microsoft mit Active Directory Systemen hat, fallen ebenfalls in die Bewertung, was ein Anbieter tut.
Und aus diesen Taten sollte man sich dann überlegen, wem man Vertrauen möchte.

> Man kann mit einem Computer Kunst und Schönheit schaffen.

Vielleicht ist Kunst nicht unbedingt der Punkt, der für die Clouds wichtig ist, aber der Spaß mit etwas, ist es definitiv.
Ich möchte etwas gerne machen und es soll mich nicht nerven.
Wenn die Cloud-Anwendung super träge ist oder man mit deutschem Mobilfunk im ICE sitzt, dann macht es vielleicht keinen Spaß mehr.
Für mich persönlich machen simple Lösungen mit wenig Komplexität Spaß, aber das ist für jeden unterschiedlich.

> Computer können dein Leben zum Besseren verändern.

Hier geht es wieder um die Prozesse, die wir erfüllen wollen.
Computer können uns dabei helfen, diese Prozesse leichter oder hilfreicher zu machen.
In welcher Form wir Computer dabei nutzen, bleibt natürlich uns überlassen.

Aber dafür müssen wir weiterhin wissen, was wir eigentlich wollen.
Denn diese Frage kann uns der Computer nicht beantworten.

Und nein "Ich hab da was gesehen, vielleicht wär das cool" ist keine Aussage darüber, was wir eigentlich wollen.
Das ist nur Werbung, die zu funktioniert haben scheint.

> Mülle nicht in den Daten anderer Leute.

> Öffentliche Daten nützen, private Daten schützen.

Die beiden Grundsätze haben aus meiner Sicht nicht so viel Einfluss auf die Wahl einer Cloud, die ich für meinen Anwendungsfall brauche.
Aus meiner Sicht sind das generelle Grundsätze, die jegliche Systeme bieten müssen.
Systeme müssen einen Schutz bieten, dass man nicht in Daten arbeiten kann, die einem gar nicht gehören oder gehören sollten.
Sollte mir auffallen, dass ich auf etwas Zugriff zu haben scheine, worauf ich keinen haben sollte, sollte dies verbessert werden, egal ob Cloud oder nicht.

Die im letzten Grundsatz erwähnten "öffentlichen Daten" können wieder, wie ich bereits zuvor geschrieben hatte, auch innerhalb einer Firma oder eines Vereins verstanden werden.
Wenn man beispielsweise immer nur die Aussage hört "wir müssen sparen", dann hilft es zum Beispiel, wenn der Verein offen legt, wie viel teurer die Location und wie viel weniger Geld da ist.
Dann sind alle über die Hintergründe informiert und können mit diesem Wissen im Sinne aller agieren.

# Elon Musks Effizienz

Unabhängig der Hacker*Innen-Ethik fällt mir ein Zitat von Elon Musk ein, was mir seit einiger Zeit regelmäßig durch den Kopf geht, wenn ich Dinge bewerte und hinterfrage.
"Lösche Komponenten. Wenn du keine Komponenten wieder hinzufügst, löschst du nicht genug."
Elon Musk hat aus meiner Sicht ein Talent dafür, Effizienz zu sehen und anzustreben.
Tesla und SpaceX sind Firmen, die an vielen Stellen bestehende Systeme einfach nur durch bessere Effizienz übertrumpfen.
Und dabei wird nicht nur die direkte Nutzung betrachtet, sondern das gesamte Umfeld.
Es ist effizienter eine Rakete mit stärker komprimiertem Treibstoff zu betanken, aber indirekt auch effizienter, diese wiederzuverwenden.
Elektroautos sind durch Elektromotoren und weniger Komponenten effizienter und weniger fehleranfällig.
Aber es ist eben auch effizienter, Akkus so zu bauen, dass man automatisiert wieder an das Lithium kommt um dies wiederzuverwenden (etwas das die deutschen Automobilhersteller nicht zu verstehen scheinen).

Dieser Gedanke des "Löschens" von Komponenten sollte aus meiner Sicht auch bei Clouds und den Zwecken, die diese für uns erfüllen sollen, betrachtet werden.
Brauche ich einen Schritt in meinem Prozess wirklich oder kann ich diesen herauswerfen (und damit den Clouddienst, der dahinter steht)?

# Fazit

Es ist spannend, Dinge noch mal aus anderen Blickwinkeln, wie der Hacker*Innen-Ethik zu betrachten und darüber nachzudenken.
Mir hat das definitiv ein paar Denkanstöße gegeben, die ich vorher nicht so klar hatte.
