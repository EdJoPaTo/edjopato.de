---
background:
  name: Winsen, Nachts im Regen
  style: url(/assets/2017/07/nightwetstreet.jpg)
date: 2017-07-31T23:58:00+02:00
title: TTI Fazit
categories:
  - tti
tags:
  - fazit
  - bpaas-angebot
---
Um noch ein paar abschließende Worte zur TTI Veranstaltung zu finden, will ich hier noch einmal meine Meinung und mein Fazit zu eben dieser Veranstaltung nieder schreiben.
Mir hat das Praktikum und die Herausforderung, ein BPaaS Angebot zu erstellen, im Großen und Ganzen definitiv Spaß gemacht.
Aber ich wäre nicht ich, wenn hier kein "Aber" käme und keine Verbesserungsvorschläge.

<!--more-->
**tl;dr: Nice one. 1 of 1 authors on this page can recommend. Some things could be better. Would do that again.**

# Der Beginn des Praktikums und des BPaaS Angebots

Der Aufbau des Praktikums war sehr frei, was mich im Grunde auch gefallen hat.
Man konnte sich seinen eigenen Schwerpunkt setzen, so wie unsere Gruppe sich mehr auf die Infrastruktur fokussiert hat, was andere Gruppen ebenfalls genutzt haben um ihren Schwerpunkt zu wählen.
Auch ist das Problem eines, das einem in der realen Arbeitswelt ebenfalls über den Weg läuft:
Ein "Kunde" will etwas, man muss aber erst mal herausfinden, was dieser überhaupt will, was seine Anforderungen sein könnten.
In diesem Fall in der abstrakten Form, das ein BPaaS Angebot doch cool wäre, wie genau weiß der "Kunde", in diesem Fall unsere Professorin aber noch garnicht (oder erzählt es uns als Teil der Aufgabe nicht).
(Spannend wäre auch die Rolle eines Geldgebers statt eines Kundens:
Der Geldgeber hat eine Idee, aber nicht so unbedingt den genauen Überblick.
Also kriegen wir drei Monate Zeit, dieser Idee genauer nachzugehen.)

Das was daraufhin in unserem Team am ersten Praktikumstermin passierte war etwas ernüchternd:
"Lass uns Technologien verwenden, die funktionieren alle super", aber die Frage, was überhaupt unser Ziel ist und die Frage an möglicherweise wissende Personen, was überhaupt hilfreich im Falle eines BPaaS Angebots wäre, blieb komplett außen vor.
Dabei blieben meine Fragen, was wir überhaupt erreichen wollen und das die Technologien aktuell noch egal seien wurden ignoriert, weshalb ich die Diskussion in der Gruppe genervt aufgab.
(Was hilft uns, dass Docker super für Abstraktionen ist und man mit RabbitMQ super skalieren kann, wenn wir noch nicht mal wissen, was wir abstrahieren wollen und was skalieren können soll?
Sobald wir das wissen, können wir entscheiden, ob eine Technologie auch unsere Anforderungen erfüllt.)
Ich fragte unsere einzige Wirtschaftsinformatikerin der Gruppe, ob sie mir nach dem Praktikumstermin vielleicht mal mehr über die Business Prozesse erzählen könnte, worum es hier ja schließlich gehen sollen würde.
Danach hörte ich dann nur noch mit einem Ohr dem Rest der Gruppe zu und unterhielt mich dann mit einem Kommilitonen einer anderen Gruppe digital über das Debakel. (Schönen Gruß, wenn du das liest :) )

Gegen Ende des Praktikums wurde die wilde Technologiediskussion von unserer Professorin gestoppt und die Gruppe wurde in die Richtung gedrängt, doch erst mal herauszufinden, wo wir überhaupt hin wollen könnten und was besagte Business Prozesse überhaupt sind.
Daraufhin beantwortete besagte Wirtschaftsinformatikerin uns diese, vor mir bereits zuvor gestellte Frage.
(Oh Wunder, der Rest der Gruppe bemerkte daraufhin, das bisher überlegte Architekturgedanken ja damit teilweise überflüssig waren.)

Wie gesagt, ich finde diese sehr freie Art des Praktikums sehr gut und würde eine ähnliche Aufgabe auch definitiv gerne wieder angehen, finde es nur etwas ernüchternd, das unsere Gruppe doch spektakulär scheiternd an diese, meiner Meinung doch realitätsnahe Aufgabe mit Unwissenheit über genaue Aufgabeneigenheiten, heran ging.
Ich würde diese Art der Aufgabenstellung ungern ändern wollen, nur anscheinend sind die Studenten wohl nicht vorbereitet genug auf diese Art der Aufgabenstellung (oder des Real World Szenarios).
Vielleicht wäre es an dieser Stelle hilfreich gewesen, klarer zu machen, das wir in der Pflicht sind, das herauszufinden, was überhaupt hilfreich wäre.
Das wir quasi ein Startup (oder whatever) sind, die Potenzial in einem BPaaS Angebot sehen, aber (noch!) gar nicht so genau wissen, was den realen Menschen da draußen überhaupt wirklich daran helfen kann.
Also müssen wir genau dies erst einmal herausfinden.

In der Vorlesung haben wir Szenarien von möglichen Anwendern solch einer Plattform von unserer Professorin bekommen, was, wie ich vermute, genau ein Schritt in diese Richtung sein sollte.
Ich würde mir aber noch mehr dergleichen wünschen, bzw. noch mehr in Richtung des "Das müsst ihr erst mal herausfinden, was sinnvoll sein könnte".

# Das weiterführende Praktikum

Nachdem unsere Gruppe eine grobe Richtung fand und diese anging, wurde über die Ausführung geredet.
Glücklicherweise haben wir uns zur Kommunikation schnell auf Slack geeinigt und zur Verwaltung von Quellcode auf das HAW eigene Gitlab.
Auch ein wöchentliches Meeting wurde von Anfang an beibehalten.
Außerdem konnte ich das Angehen eines möglichst simplen Prototyps als erstes Ziel setzen, was uns in einem früheren Projekt im fünften Semester definitiv gefehlt hatte.
Dort haben wir viel zu spät mögliche Schwierigkeiten oder nicht miteinander zusammenspielende Komponenten festgestellt, was in dieser Praktikumsgruppe mit dem ersten Prototypen deutlich besser lief.

Zum nächsten Praktikumstermin war der Prototyp fast fertig, das Ziel, mögliche Probleme abschätzen zu können definitiv erfüllt.
Allerdings war die Meinung im Team, wir hätten uns definitiv übernommen, wir sollten mal ein wenig entspannter an das ganze herangehen.
Außerdem waren wir als die Erste von drei Gruppen ein bzw. zwei Wochen vor den anderen beiden Gruppen und so auch weiter als die anderen, was die Gruppe in vermeintlicher Sicherheit hat wiegen lassen.
Außerdem fehlten mögliche Abgabebedingungen, was mindestens erreicht werden sollte.
Wenn wir also schon deutlich weiter als die anderen beiden Gruppen sind, warum sollen wir noch etwas tun, wir sind ja sicherlich sowieso durch.
Das führte dann dazu, das wir quasi den minimalen Prototypen ohne wirklich weitere Features, mit dem Herausstreichen der Komponente des Monitors, am Ende abgeben haben.
Etwas, das meiner Meinung nach etwas ernüchternd für das Master Niveau ist, auf dem wir nachher landen wollen.

Hier hätte ich mir vielleicht auch etwas mehr Anforderungen gewünscht.
Nicht speziell, was wir erreichen wollen, aber solche Dinge wie zum Beispiel die Planung von Meilensteinen.
Wenn wir dort dann Meilensteine sehr klein definieren, müssen wir uns gegenüber der Praktikumsbetreuung rechtfertigen, warum wir das so geplant haben.
Oder auch wenn wir Meilensteine nicht erreicht haben, sollten wir uns gegenüber einer Praktikumsbetreuung rechtfertigen müssen, so wie wir es auch gegenüber eines möglichen Geldgebers hätten tun müssen.

So ist dies im SE2 Praktikum im vierten Semester der technischen Informatik passiert, außer das die Aufgabenstellung noch genauer vorgegeben wurde.
Aber wir mussten uns rechtfertigen, wie wir unseren Zeitplan legen und was wir abliefern (und warum etwas vielleicht noch nicht geklappt hat).
Wenn wir das nicht ordentlich gemacht haben, haben wir einen auf den Deckel gekriegt.
Und genau so wäre es im Real World Szenario auch.
Die Idee war cool und vielleicht lohnt es sich nicht, der Idee länger als 3 Monate nachzugehen, aber wenn man die 3 Monate, um genau dies herauszufinden, verdaddelt, gibt's auf den Deckel.

# Verbesserungstipps für die Einzelnen

Kurz vor dem dritten Praktikum habe ich mich mit dem Professor, bei dem ich im fünften Semester besagtes Projekt hatte ([Thomas Lehmann](//www.haw-hamburg.de/beschaeftigte/detailansicht/name/thomas-lehmann.html)), zusammengesetzt.
Mit ihm habe ich in dem Projekt bereits über das Verbessern von Teamarbeit gesprochen und habe derartige Gedanken zur Verbesserung des aktuellen TTI Teams mit ihm fortgesetzt und mir Tipps geben lassen.
Dort habe ich eine Reihe an Tipps mitgenommen und auch konkreteres Verhalten zu Dingen durchgesprochen.
Die meiner Meinung nach wichtigsten, generellen Tipps dabei waren zum einen ein Tipp zu unseren wöchentlichen Meetings und das Vermeiden von Fingerpointing.

In unseren Meetings hatten wir bis dahin zu Beginn immer eine Runde mit der Frage "Was hast du letzte Woche gemacht?" an jeden.
Sein Tipp dazu war, dies auf "Wie hast du das Team voran gebracht?" zu ändern.
Damit sind nicht hilfreiche Aktivitäten wie "Ich hab mir mal angeguckt, was ihr da gemacht habt" direkt disqualifiziert.

Der andere Tipp war das Fingerpointing zu vermeiden.
Wenn X Schuld ist, dann hör nicht wegen X auf zu arbeiten, sondern mach dir Gedanken wie du voran kommst.
"Ja, wir haben ein Problem und es ist egal, wer und wieso es zustande kam, wir müssen das jetzt lösen."

Interessant in einem Projekt wie TTI, finde ich, wären auch derartige Tipps für den Einzelnen.
In meinem Fall habe ich dafür einen anderen Professor als unsere TTI Professorin befragt, dies liegt aber auch daran, das ich bei besagtem Professor meine BA geschrieben habe.
Außerdem bin ich mir bewusst, das in unserem Projekt im fünften Semester nur ein Team statt drei Teams waren, das deutlich häufiger Meetings mit dem Professor gemeinsam hatte, weshalb sich der Professor in dem Projekt ein deutlicheres Bild zu den jeweiligen Studenten machen konnte.
Für die vierfache Menge an Studenten mit nur einem Drittel der Termine persönliche Tipps zu geben, ist sicherlich nicht einfach.
Ich habe hierfür leider keinen guten Vortrag zur Lösung, würde mir aber dennoch etwas in diese Richtung wünschen, da zumindest ich nach der persönlichen Verbesserung strebe.
(Keine konstruktive Kritik, shame on you Edgar 😔)

Für mich war dieses Gespräch mit besagtem Prof. zur Verbesserung der Teamarbeit einer der hilfreichsten Dinge an unserem TTI BPaaS Projekt und in diesem Semester.

# Die Vorlesung

Zur Vorlesung an sich kann ich relativ wenig sagen.
Ich habe einen Teil der Themen bereits in Veranstaltungen in meinem Bachelorstudium gehört, fand aber die größere Auswahl an Themen mit jeweils nur einem groben Einblick einen guten Ansatz, um einen Überblick zu bekommen.
Was ich definitiv gut fand, waren die Gastvorträge von Firmen, die uns ihre Ansätze für ihre ~~Probleme~~ Herausforderungen schildern konnten.

# Blog (ePortfolio) statt Klausur oder (normaler) Hausarbeit

Den Ansatz, die Hausarbeit im Fach TTI, welches sich um Technik und Technologien verteilter Informationssysteme handelt, ist eine willkommene Abwechselung und passt sehr gut zum Vorlesungsthema.
Ich habe jetzt auch schon ein paar Blogeinträge zu Themen, die eher privaterer Natur sind, als zu TTI selbst, aber definitiv etwas mit dem Thema von TTI zu tun haben.
Vielleicht führe ich diesen Blog für derartige Einträge weiter, mal schauen.
Ansätze, Ideen und Tools, die man für etwas nutzt oder entwickelt hat, zu teilen, ist zumindest eine gute Grundidee.
Mal sehen, was die Zukunft bringt…

# Fazit vom Fazit

Mir hat TTI definitiv Spaß gemacht.
(Danke an mein Team dafür!)

Die Idee des realitätsnahen Praktikums, ein Problem zu bekommen, für das wir erst einmal herausfinden müssen, was eigentlich zu tun ist und was dem "Kunden" helfen würde, finde ich definitiv gut.
(Danke an die Professorin dafür!)
Ich hoffe, das folgende Masterstudenten an der HAW mit dieser Art von Praktikum ein wenig mehr unterstützt werden, um dies erfolgreicher angehen zu können.
Und dann macht es sicher noch mehr Spaß.
