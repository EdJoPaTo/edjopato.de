---
categories:
- tti
date: 2017-04-09T04:20:00+02:00
tags:
- bpaas-angebot
- praktikum
title: Das erste Praktikum
aliases:
- /blog/tti/2017/04/09/praktikum1.html
---

Letzten Mittwoch fand das Erste von vier Praktika in TTI statt.
Dieser Termin soll vor allem zum Organisieren der Praktikumsgruppe dienen und um den Anfang der Entwicklung des BPaaS Angebots zu planen.

Als grundlegende Frage stellte sich mir, was eigentlich das ist, was wir umsetzen wollen und welche Anforderungen überhaupt existieren.
In diesem Fall also die Frage, was Business Prozesse sind und wie man sie in Anbetracht der begrenzten Zeit effektiv in unser BPaaS Angebot umsetzen kann.
Darauf basierend wird dann eine Architektur benötigt, die einerseits die Stakeholder zufrieden stellt, skalierend funktioniert und in unserer begrenzten Zeit gut umgesetzt werden kann.

Außerdem bestand die Überlegung, ob die 3 Praktikumsgruppen gemeinsam an einem BPaaS Angebot arbeiten wollen oder ob die einzelnen Gruppen jeweils eigene Lösungen entwickeln wollen.
Vor dem Praktika wurde abgestimmt, dass wir doch gerne alle einmal das erste Praktika haben wollen, um uns klarer zu sein, was wir da eigentlich entscheiden.

# Teilnehmer der Praktikumsgruppe

Da im Master Informatik an der HAW Studenten aus mehreren Bachelor Informatik Studiengängen sind, haben natürlich auch die einzelnen Personen in der Praktikumsgruppe unterschiedliche Interessenschwerpunkte.
Unsere Praktikumsgruppe besteht aus 9 Studenten: 5x Technische Informatik (ich gehöre ebenfalls dazu), 2x Media Systems, 1x European Computer Science (nah an der Technischen Informatik) und 1x Wirtschaftsinformatik.
Das Problem daran ist, dass unsere Gruppe damit niemanden aus der Angewandten Informatik hat, der sich um gröbere Architekturfragen kümmern könnte.
Dafür ist die Hardware-nahe Seite der performanten und skalierenden Durchführung durchaus gut abgedeckt, da fast ⅔ der Studenten aus der Richtung kommen.

![Anteile der Studenten in meiner Praktikumsgruppe](/assets/2017/04/anteile-studenten.svg)

# Der Ablauf

Das Praktikum begann damit, dass erst über eine grundlegende Architektur geredet wurde.
Spannenderweise kam dabei der Konsens auf etwas ähnliches, was bereits in meinem [letzten Post]({{< relref "../2017/04-03-requirements-stakeholder.md" >}}) als Überlegung entstanden ist (warum auch immer das noch mal erdacht werden musste).
Danach ging die Diskussion weiter, welche Personen wo in der Architektur Aufgaben übernehmen, dass Docker sich super dafür eignet und das Publish Subscribe Messaging Pattern dafür sorgen können, dass keine Nachrichten verloren gehen werden.
Das mag ja auch alles schön sein, hat nur meine Eingangsfrage, was wir überhaupt bauen müssen und was unsere Requirements an das System überhaupt sind, überhaupt nicht beantwortet.
Geschweige denn, dass ich auch, bis auf ein kurzes Mal googeln, wenig Ahnung davon habe, was ein Business Process überhaupt ist.
Nach etwas mehr als 2 Stunden (von 3 Stunden Praktika) haben auch die Laborbetreuung und die Professorin bemerkt, dass die Gruppe ganz leicht in die falsche Richtung rennt und das Ganze gebremst.

Zuvor war meine Annahme zu Business Prozessen, dass es eine Verschaltung von mehreren Diensten ist, die jeweils einmal Eingangswerte erhalten und dann ihren Job erfüllen.
Dafür können sie verteilt laufen, Ressourcen wie Rechenleistung, RAM oder Festplattenplatz benötigen, die später abgerechnet werden müssen.
Ausgaben der einzelnen Dienste werden dann als Eingangsdaten für weitere Dienste benutzt oder um Entscheidungen zu treffen, welche folgenden Dienste eingesetzt werden.
Die Ausgangsdaten am Ende des Prozesses sind dann die Daten, die der Nutzer als Ergebnis erhält.

# BPMN in einem einfachen Beispiel

Da unsere Professorin bereits in den Vorlesungen erkannt hat, dass die Aufgabenstellung noch nicht präzise genug für uns zu sein scheint, hat sie 2 Tage vor unserem Praktikum zwei Anwendungsbeispiele für uns bereit gestellt.
Diese haben zumindest mir noch einmal mehr verdeutlicht, wie viel Umfang eigentlich hinter dem Projekt des BPaaS Angebots steckt.

In einem der Anwendungsbeispiele war davon die Rede, dass der Ersteller von Business Prozessen gerne BPMN oder eEPK benutzen würde, bevorzugt jedoch BPMN2.0\.
Das hat mir als technischer Informatiker, der sich vorher noch nie damit befasst hat, relativ wenig bis gar nichts gesagt.
Nachdem unsere Professorin die Diskussion im Praktikum stoppte, hat unsere Wirtschaftsinformatikerin uns an einem [spontan gefundenem Beispiel](https://www.heise.de/developer/meldung/BPMN-2-0-fuer-eine-bessere-Zusammenarbeit-zwischen-Fachabteilung-und-IT-1175099.html) erläutert, was BPMN2.0 beschreibt.

![BPMN 2.0 Beispiel](/assets/2017/04/beispiel-bpmn20.png)

Bild Quelle: [Heise Developer](https://www.heise.de/developer/meldung/BPMN-2-0-fuer-eine-bessere-Zusammenarbeit-zwischen-Fachabteilung-und-IT-1175099.html)

Meine folgende Beschreibung ist nur das, was ich im Praktikum aus der Erklärung verstanden habe und sollte nicht als vertrauenswürdige Quelle dienen.
Korrigiert mich gerne, wenn ich falsch liege!

Im Grunde genommen treten Events (als Kreise dargestellt) auf, die einen Prozess starten.
Dann werden die einzelnen Prozessschritte (abgerundete Rechtecke) durchlaufen.
Wie im ersten Prozessschritt zu sehen, können und müssen teilweise innerhalb eines Prozessschrittes User-Interaktionen auftreten.
Die Prozessschritte sind in einzelne Zeilen für die Akteure im System unterteilt.
Zwischen den Prozessen gibt es Elemente wie Verzweigungen, Wartezeiten oder erhaltenen Nachrichten.
Zusätzlich gibt es Nachrichten, wie den Bezahlvorgang, der von einem Prozess an einen Aktor gebunden ist.

Vor allem für letzteres sehe ich aktuell keine simple Lösung, wie dies in unserem BPaaS Angebot umgesetzt werden könnte.
Unter anderem deswegen wäre es für mich also denkbar, nur einen Teil einer beschreibenden Sprache wie BPMN für uns zu verwenden oder mit einer Abstraktion davon zu arbeiten.
Womit man wieder bei meiner Anfangsfrage ist: Was wollen wir eigentlich und was sind unsere Anforderungen, die wir erfüllen wollen.

Nach der Vorstellung von BPMN haben wir vergleichsweise kurz über die neue Architektur, die sich aus den jetzt bekannteren Anforderungen ergeben könnte, diskutiert und löste sich relativ schnell mit Ende der vorgesehenen Praktikumszeit auf.

# Optimierung des Praktikumsablaufes in unserem Team

Da der erste Praktikumstermin für mich eher ein großes Durcheinander und zu ⅔ eher eine Zeitverschwendung war (weil versucht wurde, auf ein unbekanntes Ziel hin zu arbeiten, bis wir uns mal angeguckt haben, was ein BP überhaupt ist), hoffe ich, dass sich der nächste Termin verbessern lässt.
Unter anderem auch deswegen, weil es bereits unser Zweiter von vier Terminen ist.

Beispielsweise könnte man mit Hilfe eins Gesprächsmoderators die Themen zielgerichteter diskutieren und hoffentlich auch mehr Meinungen einfließen lassen, bzw.
Diskussionen in Untergruppen verlagern (es haben nie wirklich alle zu einem Diskussionspunkt Meinungen geäußert).
Zu Beginn können Themen gesammelt werden, über die man sprechen will.
Diese können danach priorisiert werden, welche Themen besonders wichtig sind, um angesprochen zu werden.
Die Themen werden dann einzeln und zeitlich begrenzt diskutiert, um zu einem Ergebnis zu kommen.
Wenn dies innerhalb einer gewissen Zeit nicht möglich ist, muss eine Untergruppe definiert werden, die unter sich die Diskussion fortsetzt und eine Entscheidung beim nächsten Termin vorstellt.
Kommen während der Diskussion andere Themen hoch, müssen diese vom Moderator "verhindert" werden, aber auf die Liste der zu besprechenden Themen gesetzt werden.
Möglicherweise wird dann nach dem Diskussionspunkt die Liste neu priorisiert.

Das Ganze ist natürlich nur ein Vorschlag und ich bin natürlich auch für andere Ideen offen, um in Zukunft eine effektivere Diskussionsrunde zu schaffen.
