---
date: 2021-07-18T17:12:00+02:00
lastmod: 2021-07-18T17:12:00+02:00
title: Gedanken zu effizienter Software
tags:
  - browser
  - c
  - csharp
  - efficiency
  - environment
  - rust
  - typescript
  - web
---
Ich entwickle und nutze Software.
Diese ist teilweise schnell und effizient, teilweise aber auch langsam, verbraucht viele Ressourcen und macht Dinge, die ich gar nicht brauche.
Wenn nur ich etwas nutze und es "etwas mehr" verbraucht, dann ist es den Aufwand, dies zu optimieren, wohl nicht Wert.
Da aber Software teilweise von sehr Vielen genutzt wird, macht sich dies als Summe schon bemerkbar.
Ich will hier auch gar nicht auf Bitcoin oder so eingehen, sondern genereller auf jegliche Software.
Beispielsweise die Textverarbeitung, die häufig genutzt wird, auch wenn vieles davon gar nicht gebraucht werden würde.

# Gar nicht Benötigtes

Ein häufiges Beispiel an nutzloser Ressourcenverschwendung sind für mich Ladeanzeiger.
Ja, es ist schön zu wissen, dass da gerade etwas passiert, aber muss der Kringel auf der Webseite einen gesamten CPU Kern fressen?
Ich habe mir mittlerweile angewöhnt, beispielsweise die GitHub Actions in einem Hintergrund Tab zu haben und nur kurz darauf zu schauen.
Die "läuft gerade" Animation frisst genug Ressourcen, sodass der CPU Lüfter entscheidet, anzugehen.
Hier tut ein Clouddienst etwas für mich, sodass ich meine Ressourcen eigentlich nicht benötigen sollte.
Stattdessen freut sich die CPU über den Ladekringel.

Mein Trick hier: uBlock Origin kann Inhalte blockieren und damit gar nicht erst laden.
Werbung beispielsweise wird gar nicht erst geladen und verbraucht weniger Ressourcen, sowohl bei mir, als auch unterwegs zu mir.
Aber ich kann auch weitere Elemente blockieren.
Nervige Ladekringel zum Beispiel.

Ein Weg ganz ohne Erweiterung: Einfach völlig überladene Software nicht benutzen und schauen, ob man bessere Alternativen findet.
Die Webseite [Alternativeto](https://alternativeto.net/software/openoffice/) hilft relativ gut dabei, erstmal von Alternativen zu erfahren, ist aus meiner Sicht aber relativ schlecht dazu geeignet, diese wirklich zu vergleichen.
Eine gute Idee kann man so aber bereits bekommen.

# Effiziente Ansätze und Reduktion von Komplexität

Ein anderer Punkt, in dem Ressourcen stecken bleiben, ist das Nutzen von zu vielen Abstraktionsschichten, die nicht mehr überdacht werden.
Das schöne "3 Layers of Framework", bei denen häufig schon die verstorben sind, die sich mal mit der Untersten auskannten.
Typischerweise hat da mal jemand etwas zusammen gedengelt und nun wird versucht, etwas völlig anderes damit zu bewerkstelligen.
Abstraktion ist meistens gut um Dinge greifbarer zu machen.
Trotzdem sollte man sich seiner Komponenten und Abstraktionen bewusst sein, diese effizient einsetzen und vor allem optimieren oder austauschen, wenn sich der Einsatzzweck wandelt.

Persönlich habe ich einige Node.js Packages und Projekte, bei denen ich immer versuche, möglichst wenig Komponenten und Abhängigkeiten zu verwenden.
Jede weitere Abhängigkeit bringt weitere Logik mit sich, die ich vielleicht gar nicht unbedingt brauche.
Frameworks können helfen, bringen vielleicht aber möglicherweise auch viel zu viel Komplexität mit.
Beispielsweise verwendete ich für meine Telegram Bots ein Framework (Telegraf bzw. den quasi Nachfolger grammY), welches dabei unterstützt einfacher zu arbeiten und Dinge abnimmt.

Meine [hawhh.de](https://hawhh.de) Webseite war damals mit AngularJS (Angular 1) entstanden, einfach, weil ich damit auch mal herumspielen wollte.
Durch die Frontend-Logik von Angular 1 wurden hier Elemente nacheinander geladen, welche aufeinander aufbauen.
Dies hat beispielsweise auch für lange Ladezeiten gesorgt, da die Wartezeiten bis zur Antwort vom Webserver sich natürlich immer aufsummierten.
Auch die [Optimierung der Webseite]({{< relref "../2021/07-06-website-quality-checks.md" >}}) war so schwer möglich.
An der Stelle habe ich mich dann dazu entschieden, diese Webseite als statischen Content neu zu bauen.
Dieser wird nicht jedes Mal bei dem Nutzer zusammengebaut, sondern einmalig und dann dem Webserver bereitgestellt.
Das häufige, das Aufrufen der Webseite, hat nun also minimale Komplexität: Simple HTML Dateien anzeigen.
Das Zusammenbauen passiert nun nur noch einmalig bei mir, wenn ich die Webseite aktualisiere.

Genereller formuliert: Die Dinge, die häufig passieren, sollten minimale Komplexität haben.
Komplexität sollte einmalig in der Vorbereitung stecken.

# Effiziente Programmiersprachen

Seit Jahren verwende ich relativ viel Node.js mit JavaScript und später TypeScript.
TypeScript wird ebenfalls einmalig in JavaScript gewandelt und letzteres wird dann vom Interpreter ausgeführt.
Weiterhin ist JavaScript jedoch eine interpretierte Sprache, auch wenn TypeScript nicht direkt ausgeführt wird.
Dies war [einer der Gründe]({{< relref "../2020/09-11-why-rust.md" >}}), warum ich mir eine komplierte Programmiersprache ansehen wollte und so irgendwann mal bei Rust gelandet bin.
Dort habe ich dann beispielsweise ein Teil des Kalenderbots, welcher bis dahin in C#, einer VM basierten Programmiersprache entstanden war, in Rust [neu entwickelt]({{< relref "../2020/09-11-calendarbot-rust.md" >}}).
Das führte zu so einigen Laufzeitverbesserungen.
Ja, Rust zu kompilieren dauert relativ lange und ist ressourcenintensiv, aber einige meiner, letztes Jahr entstandenen Tools habe ich seither nicht anfassen müssen.
Und zu Laufzeit sind diese sehr effizient.

Jetzt bin ich letztens über eine wissenschaftlich fundiertere Analyse von Energieverbrauch und Programmiersprachen gestoßen: [Energy Efficiency across Programming Languages](https://sites.google.com/view/energy-efficiency-languages/results#h.p_nggWE5Z-iDZ0) ([Quellcode](https://github.com/greensoftwarelab/Energy-Languages)).
Hierfür wurden einige Beispielprogramme, inspiriert durch das ["Benchmarks Game"](https://benchmarksgame-team.pages.debian.net/benchmarksgame/), in etlichen Programmiersprachen entwickelt.
Diese wurden dann auf Energieverbrauch, Zeitbedarf und RAM-Verbrauch betrachtet.
Die detaillierten Beispiele sind definitiv interessant, auch in welchen Bereichen einige Programmiersprachen besonders gut sind und andere nicht, aber für den kurzen Überblick werfe ich hier nur einen kurzer Blick auf die normalisierten Gesamtergebnisse.
Dafür wird das beste Ergebnis als Faktor 1.00 angenommen und alle anderen Programmiersprachen werden als vielfacher Faktor dazu angegeben.
Im Energieverbrauch verbraucht Rust beispielsweise 3% (Faktor 1.03) mehr im Vergleich zu C, dem besten hier.
C# ist bei dem dreifachen Energieverbrauch, JavaScript beim 4.5-fachen.
TypeScript hat das 21.5-fache, was ich persönlich aber infrage stelle, da TypeScript eigentlich einmalig in JavaScript kompiliert wird.
Müsste man sich mal genauer anschauen.

Auch im Zeitbedarf ist Rust nur knapp schlechter als Spitzenreiter C.
C# ist wieder beim 3-fachen, JavaScript beim 6-fachen.
Spannend sowohl beim Energieverbrauch als auch Zeitbedarf: Python geht gegen Schlusslicht.
Wie ein Freund mal sagte: Man kann alles mit Python machen, aber eben alles nur am Zweitbesten.
Sprich: Es wird immer eine bessere Lösung geben, als die mit Python.
Dafür geht aber eben auch alles.
Die Aussage scheint sich immer mal wieder zu bewahrheiten.

Anders sieht der RAM Verbrauch hier aus.
Was mir hier bei den detaillierten Ergebnissen schon häufiger aufgefallen war, ist der geringe RAM Verbrauch von Go.
Beim Energieverbrauch und der Laufzeit ist Go bei 3.23 bzw. 2.83 nicht sonderlich gut.
Allerdings ist Go im RAM Verbrauch nahezu Vorreiter, noch vor C.
Rust ist mit 1.54 relativ gut dabei, C# wieder etwa beim 3-fachen und JavaScript wieder beim 4.5-fachen.

Man muss hier aber auch dazu sagen, dass es sich hier um Laborergebnisse handelt und keine reale Welt Probleme verwendet wurden.
Zum einen muss man auch noch andere Aspekte betrachten, zum Beispiel wie gut die Programmiersprache etabliert ist oder wie viele sich damit auskennen.
Zum anderen bauen wir unsere Konstrukte definitiv nicht perfekt.
Wenn ich eine schrecklich ineffiziente Implementierung in Rust baue und eine gute Implementierung in Java, dann ist trotz der schlechten Basis Java trotzdem besser.
Hier sehe ich aber auch große Vorteile von beispielsweise Rust im Speicherverbrauch.
Durch das Konzept der Lifetime und der quasi Garbage Collection zu Compile Zeit ist es viel einfacher für Entwickler Programme zu bauen, die wenig Speicherverbrauch haben.
Ja, C beispielsweise war besser, aber eben auch nicht so einfach.

# Brauche ich das wirklich?

Etwas, was mir immer häufiger auffällt:
Menschen wissen nicht, was sie wirklich brauchen und holen sich eine eierlegende Wollmilchsau.
Häufig vermischen diese alle möglichen Aufgaben zu einer zähflüssigen Matsche und können zwar alles, aber nichts besonders gut.

Wenn ich mir beispielsweise ein Tabellenkalkulationsprogramm wie LibreOffice Calc anschaue, dann vermischt dieses einige Aufgaben.
Daten, Logik und Formatierung.
Ein einfacheres Beispiel ist vermutlich eine Textsatzsoftware wie LibreOffice Writer, mit der man sowohl Text schreibt, als auch diesen strukturiert, als auch formatiert.

Die Formatierung von Text ist aber eine ganz andere Aufgabe und der Inhalt hat erstmal nichts mit der Formatierung zu tun.
Text muss sinnvoll gegliedert sein und Inhalt enthalten.
Hinterher kann man sich immer noch überlegen, welche Schriftart man dafür verwenden möchte und mit welcher Textgröße die wenigsten Leser Probleme haben werden, diesen dann auch zu lesen.

Im Web haben wir hier beispielsweise schon seit Jahren eine gute Trennung:
HTML beschreibt die Daten, den Text, CSS formatiert diese und JavaScript beinhaltet Logik.
Wenn ich beispielsweise älter werde und kleineren Text nicht mehr so gut lesen kann, dann reicht es, eine andere Formatierung zu verwenden, alles andere funktioniert weiterhin.
Möchte ich mehr Daten hinzufügen, die genauso aussehen wie der Rest, dann wird die bestehende Formatierung dies einfach so weiter machen, ohne das ich mir irgendeinen Kopf darum machen muss.

Wenn ich Text und Formatierung habe, dann klingt für mich LaTeX eigentlich immer nach der einfacheren Lösung, als Writer das wäre.
Trotzdem verwenden sehr viele Menschen noch dieses Mischmasch an Aufgaben.
Im Zeitalter von Schreibmaschinen kann ich das ja verstehen, da ging das halt nicht wirklich anders, aber jetzt haben wir so viele bessere und effizientere Möglichkeiten.
Wir sollten sie nutzen.


# Rebound Effekt

> Was einfacher wird, wird mehr benutzt.

Dies wird als [Rebound Effekt](https://de.wikipedia.org/wiki/Rebound-Effekt_(%C3%96konomie)) oder als [Jevons Paradoxon](https://de.wikipedia.org/wiki/Jevons-Paradoxon) beschrieben.
Letzteres ist im Grunde die Feststellung, dass bei der Effizienzsteigerung der Dampfmaschine, die plötzlich mit weniger Kohle mehr Dampf produzieren konnte, die Dampfmaschine beliebter wurde und so mehr Maschinen insgesamt doch mehr Kohle verbraucht haben, als die Effizienzsteigerung eingespart hatte.

Der Nachteil des Ganzen: Wir Menschen neigen dazu, einfaches zu machen.
Was einfach geht, können wir auch mehr machen.
Ich persönlich habe beispielsweise angefangen, einige Continuous Integration Dinge mit GitHub Actions zu machen.
Rust Anwendungen für unterschiedliche Plattformen und Betriebssysteme testen und bauen.
Weil es geht.
Und weil es wohl auch Spaß machte, dies herauszufinden und umzusetzen.
Beispielsweise meine Experimente mit Rust Containern über Docker buildx brauchen teilweise eine knappe Stunde, bis diese gebaut sind.
Hier kann man zwar wieder sagen, sobald diese gebaut sind, funktionieren diese doch ohne großen Aufwand, aber auf der anderen Seite frisst da irgendein Rechenzentrum eine Stunde lang Ressourcen, nur um irgendeinen Container für irgendeinen Push zu erzeugen.
Da sollte sich schon die Frage stellen: Ist es das wert?

Das sollte aber definitiv nicht dazu führen, dass wir aufhören sollten, Dinge auszuprobieren.
Wir sollten weiterhin lernen und experimentieren.
Aber es sollte am Ende auch immer die Frage im Raum stehen "Ist es das Wert?".

Ich weiß, das Menschen Dinge von mir auf GitHub anschauen und nachmachen bzw. benutzen.
Von kleinen Ausschnitten im Quellcode über Art und Weisen, wie ich Dinge umgesetzt habe, auch zu Continuous Integration Umsetzungen.
Nicht ohne Grund stelle ich meine Sachen online, damit sie angeschaut werden, ich verüble dies also auch nicht.
Trotzdem muss ich mir dann auch bewusst sein: Wenn ich meinem Tool beibringe, einen Container eine Stunde lang bei jedem Push zu erzeugen, wird jemand kommen und sich dies abschauen und auch tun.
Dann kommt wieder die Frage: Ist es das Wert? Habe ich genug Benefit davon, dass das Ding eine Stunde vor sich hin baut?

Man darf den Vorteil des Ganzen aber nicht außer Acht lassen.
Menschen tun, was einfach ist.
Wenn das hochkomplexe, ineffiziente Framework einfach zu benutzen ist, werden Menschen dies benutzen.
Wenn wir etwas Simples und Effizientes bauen und dies so dokumentieren und bereitstellen, dass es einfach zu benutzen ist, werden mehr Menschen den simpleren Weg nehmen.
Wir können uns diese Eigenschaft also auch zunutze machen.

# Weiteres, was nirgendwo richtig passte

Dieser Blogpost fasst schon Einiges zusammen, aber es gibt noch mehr Dinge, die nur so halb hier reinpassten, trotzdem aber spannend sind.

Eine Sache ist die Feststellung, dass die Programmiersprachen Effizienz Webseite, auf die ich zuvor eingegangen bin, sämtliche Ergebnistabellen als Bilder auf die Webseite gestellt hat.
HTML Tabellen oder SVGs wären so viel energieeffizienter und schneller gewesen.

Ein weiterer Fund sind die [Ethical Web Principles](https://www.w3.org/2001/tag/doc/ethical-web-principles/) vom W3C, welche unter anderem von "The web must be an environmentally sustainable platform" sprechen.
Aber auch sonst sind dort so einige Punkte aufgeführt, die echt gut sind, aber nicht in diesen Blogpost passen.

# Pareto

Abschließen möchte ich mit der 80-20-Regel oder auch dem [Paretoprinzip](https://de.wikipedia.org/wiki/Paretoprinzip).
Dies besagt, dass 80 % der Ergebnisse mit 20 % des Gesamtaufwandes erreicht werden können.

Ja, das ist alles nicht einfach.
Wir werden nicht von jetzt auf gleich perfekt.
Aber wir können mit relativ wenig Aufwand schon eine ganze Menge schaffen.
Und, wenn es nur das Betrachten der Möglichkeiten ist.

Und das gilt für mich nicht nur in der Software Entwicklung, sondern quasi in allen Bereichen.
Ich könnte mich entscheiden, zu 100 % auf Tierprodukte zu verzichten.
Mich stattdessen aber dazu zu entscheiden, auf 80 % der Tierprodukte zu verzichten ist hingegen deutlich einfacher.
Natürlich könnte ich mich dazu entscheiden, 100 % auf proprietäre Software und Betriebssysteme zu verzichten, aber 80 % der Zeit bedeutet auch schon eine ganze Menge.
Natürlich kann man sich dazu entscheiden, 100 % auf ein Auto zu verzichten, aber meistens ohne Auto zu leben und sich immer mal eines zu leihen, bringt auch schon eine ganze Menge.
Natürlich kann ich mich dazu entscheiden, 100 % Plastikmüll zu vermeiden, aber einer statt fünf gelbe Säcke bringt auch schon eine ganze Menge.

Wir sollten seltener gleich in Extreme verfallen.
Wandel ist nicht einfach und Schritte in eine gute Richtung sind alleine auch schon viel Wert.

Und das ist wohl auch mein Hauptaugenmerk:
Mal darüber nachdenken.
Perfekt wirds nicht, aber mit vergleichsweise wenig Aufwand kann man an einigen Stellen schon so einiges Bewirken.
