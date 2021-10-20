---
title: MQTT Rust vs NodeJS
date: 2021-01-03T04:15:00+01:00
resources:
  - name: cover
    title: Das Ende einer Steinschlange
    src: stone-snake.jpg
categories:
  - open-source
tags:
  - nodejs
  - raspberry-pi
  - rust
  - smarthome
  - typescript
---
In meinem Netzwerk laufen eine Vielzahl von "smarten" Geräten, die über MQTT angesteuert werden.
So existiert beispielsweise ein Tool, welches LEDs an MQTT anbindet, als auch eines welches MQTT Nachrichten schlau empfängt und sendet um "smart" zu werden.
Beides war bisher in NodeJS entwickelt.

Erstes lief seit über 3 Jahren nahezu unverändert, letzteres wird regelmäßig mal angefasst um neue Spielsachen oder neue Ideen einzubauen.
Zwei tolle Spielzeuge um ein wenig mit Rust zu experimentieren.
<!--more-->

# Light Simple Pi Client

Zuerst habe ich mich dem kleineren MQTT zu LED Tool gewidmet.
Das Tool bindet LEDs über MQTT an, die über ein eigenes Protokoll eines Arbeitskollegen über Seriell angesteuert werden können.
(Da besagtes Protokoll schon closed source ist, würde sich der Quellcode meines Tools nicht als Open Source lohnen.)
In NodeJS / JavaScript habe ich da mal was kleines zusammen gedengelt und so lief dies nun seit über 3 Jahren auf einem Raspberry Pi 1B vor sich hin.

Das mit Rust nachzubauen hat natürlich länger gedauert, als es damals mit JavaScript ging, aber dazu bin ich noch zu neu in Rust und zu Erfahren in JavaScript/TypeScript.
Im Grunde ging das mit meiner bisherigen Erfahrung schon relativ gut.
Der erste Versuch hatte schon deutlich weniger RAM Verbrauch als die NodeJS Variante, allerdings war diese nicht deutlich effizienter was die CPU Zeit angeht.
Was aus meiner Sicht relativ spannend ist: Die NodeJS Variante war nicht deutlich schlechter.
Kein Wunder, wenn man ein Event based System (NodeJS) auf ein Nachrichten basiertes Problem (MQTT) wirft.
Mit einem effizienteren Ansatz der Logik konnte ich die CPU Zeit dann trotzdem auf etwa ein siebtel der NodeJS Variante reduzieren.

Die Compilezeit auf dem Raspberry Pi 1B kam dann auf ~180min, aber zur Laufzeit ist das Tool unter den normal auf einem Pi laufenden Prozessen quasi unauffällig im Mittelfeld.
Die NodeJS Variante fiel schon deutlich auf.

Fazit soweit:
Um Rust zu üben war dies definitiv cool.
Und im Vergleich zu NodeJS auch definitiv cool zu sehen, wie Ressourcensparsam das Ganze werden kann (wenn man es denn im zweiten Ansatz sinnvoll baut).
Da das Tool bisher schon quasi 3 Jahre unverändert lief, wird dies so auch lange weiter existieren können und nicht häufig angepasst werden müssen.
An dieser Stelle ist Rust vermutlich deutlich besser geeignet als NodeJS.
Allerdings war die NodeJS Variante, grade im Vergleich mit dem ersten Versuch der Rust Version nicht all zu schlecht.
Der Raspberry hat 512MB RAM, da sind 35MB RAM eines Prozesses nicht all zu schlimm.
Und die CPU war auch nie nur irgendwie ansatzweise belastet.


# Home Schedule

Das zweite Tool, welches quasi die Steuerzentrale der meisten MQTT angebundenen Geräte hier darstellt und Interaktionen ausführt, kam als nächstes an die Reihe.
Das Tool hat schon einige unterschiedliche "Mini Tools" vereint.
Als Beispiel steuert dies den Farbwechsel meines Decken LED Stripes oder solche Dinge wie morgens heller werden, abends dunkler werden.
(Mehr zu meinem "Smarthome" Geraffel vielleicht mal in einem extra Blogpost...)

Das ganze passierte auch hier bisher in einem NodeJS / TypeScript Projekt.
Das coole an dem Projekt ist, dass sich regelmäßig etwas ändert, man eine bessere Idee hat, wie etwas sein soll oder einfach mal zwischendurch extra Dinge hat (ein [LED Matrix Adventskranz](https://github.com/EdJoPaTo/esp-mqtt-neomatrix-advent) zum Beispiel).
Dann spielt man wieder damit herum.
So lernt man, wie man etwas umsetzen kann und sammelt Erfahrungen.
Das selbe möchste ich jetzt für eine Weile mit Rust haben.

Das Projekt lief bisher auf einem Pi 2, sollte aber nicht auf dem selben Pi laufen, damit ich beide Projekte relativ einfach parallel laufen lassen kann.
(Damit der quasi gleiche systemd service erhalten bleiben kann.)
Nichts, was nicht auch anders gegangen wäre.
Aber nachdem ich vorher bereits sah, wie gut Rust zur Laufzeit auf einem Raspberry Pi 1B läuft, dachte ich mir, warum nicht auch dies auf einem Pi 1B.
(Der MQTT Server läuft aus Tradition heraus auch immer noch auf diesem Raspberry Pi 1B. Reicht locker aus dafür.)

Mein Ansatz bei NodeJS war, für jeden "Task" eine Datei zu haben, die jeweils über eine `start()` Methode begonnen wird.
Dies habe ich so ähnlich für Rust übernommen.
Hier werden Topics subscribed oder Threads gestartet.
Allerdings habe ich zusätzlich im Haupt Thread eine Endlos Loop, die alle 5 Sekunden `do_loop()` Funktionen von Tasks aufruft.
Für Farbverläufe oder Lampen heller/dunkler machen über Zeit gut geeignet, dafür brauche ich dann keinen extra Thread.
Um auf Events über Channel zu warten, habe ich eigene Threads verwendet.
In Zukunft sollte ich mal schauen, hierfür eine asynchrone Umgebung (wie NodeJS sie ist ;) ) zu nehmen.
Die meisten meiner Threads machen quasi nichts außer warten, da klingt das über Threads skalieren irgendwie mäßig gut.
Das Gute: Die Anzahl der Threads steigt oder sinkt nicht und man kann die einzelnen Threads über `htop` anzeigen lassen und vergleichen.
Aktuell habe ich so 9 Threads, was im Vergleich zu den 8 Threads, die NodeJS immer zu nutzen scheint, harmlos wirkt.

Was man definitiv merkt, sind die Freiheiten, die man mit NodeJS hat.
Zum Beispiel `startInterval()` und los gehts für eine loop mit dynamischer Zeit.
Dafür muss man bei Rust mit Threads doch etwas mehr drum herum machen.
Vielleicht auch eine Eigenheit von Rust, aber Dinge wirken "teuer" was Leistung angeht.
So stelle ich mir Fragen wie "wirklich in jeder Loop `.replace()` nutzen oder einmal zu Beginn?".
In NodeJS "ist das halt so".
Im Laufe des Projekts habe ich einiges davon abgelegt und mehr "irgendwie so" Code produziert.
Dann nutzt der halt jede Loop ein `.replace()`, ist halt so.
(Trotzdem ist der Code an vielen Stellen immer noch deutlich effizienter strukturiert.)

Das ganze läuft immer noch auf dem Raspberry Pi 1B und abgesehen vom Komplilieren läuft das ganze auch echt super.
Das Kompilieren dauert so seine Minuten, auch wenn die Dependencies alle gebaut sind.
Im Grunde ist mir das kompilieren aber relativ egal:
Ich teste und probiere das eh auf meiner normalen Hardware aus.
Danach committe und pushe ich das ganze, pulle es auf dem Pi und sage "mach mal".
Das Ganze wird dann gebaut.
Wenn es fertig ist, wird das aktuell noch Laufende ausgetauscht und das neue gestartet.
Die Downtime ist damit quasi minimal und ich muss nicht zuschauen und warten.
Und zu sehen, dass ein Raspberry Pi 1B von vor X Jahren das ganze locker ausführt, hat auch seinen Charme.
(TypeScript bauen ist auch nicht all zu schnell. NodeJS auf dem Pi 1 ist dank ARM6 allerdings nervig, Rust nicht (abgesehen vom cross compilieren).)

# Vergleich TypeScript vs Rust

Grade beim letzteren Tool habe ich gemerkt, wie viel einfacher und "irgendwie so" man Dinge in NodeJS / TypeScript lösen kann.
Es ist eben eine Scriptsprache.
Allerdings kann man ohne brauchbaren Linter in TypeScript auch eine ganze Menge "irgendwie so" Murks basteln.
Da ist Rust definitiv strikter und die Fehlermeldungen / Hinweise vom Compiler / Clippy definitiv hilfreich.

Bei "schneller" bin ich aktuell noch vorsichtig.
Ja, ich wäre mit TypeScript aktuell deutlich schneller gewesen, aber ich kenne TypeScript nun auch schon eine Weile.
Rust ist da noch ungewohnter.
Auch kenne ich die Libraries im Umfeld noch nicht all zu gut.
Aber deswegen mache ich das ganze ja.

Besonders spannend finde ich immer wieder, wie viel weniger RAM und CPU Zeit die Rust Tools benötigen.
Auch haben einige Sprachelemente von Rust die Folge, dass man "vertrauenswürdigeren" Code schafft.
TypeScript mit seinen Typen ist zwar schon ganz nett, aber `Option<T>` wirkt aus meiner Sicht einfach lesbarer und sicherer als `T | undefined`.
Ein Beispiel wäre zum Beispiel ein Payload auf einem Topic.
Ja es wurde bereits ein Wert gesehen (`T`) oder nein, auf dem Topic wurde noch kein Payload gesehen (`undefined` / `None`).
Alternativ etwas wie "der string konnte nach `f64` geparst werden" oder eben nicht.
Ja, `number` in TypeScript kann sowas wie `NaN` oder wieder `undefined`, aber es fühlt sich weniger gewollt an.
Vor allem muss man sich aktiv darum kümmern, was im "anderen" Fall passieren soll.
Vor- und Nachteil von Rust:
In TypeScript ist etwas einfach irgendeine `number`.
In Rust muss ich aktiv entscheiden, dass ich den String zum Beispiel als `f32` oder `u16` lesen und interpretieren will.
Und diese Entscheidung in allen folgenden Methoden mit mir tragen.

Den `?` Operator in TypeScript finde ich für schnelleren Code hilfreicher als den in Rust.
In TypeScript kann man damit `a?.b()` machen und bekommt `undefined` wenn `a` `undefined` ist oder den Wert der `b()` Funktion zurück.
Rust hingegen prüft damit ein `Option`/`Result` of `None`/`Err` und wenn dies der Fall ist, beendet die aktuelle Funktion damit.
Etwas ähnliches wie in TypeScript lässt sich nur mit `.map()` oder `.and_then()` realisieren.
So sähe das Beispiel oben eher so aus: `a.and_then(|o| o.b())` was deutlich mehr Tipparbeit bedeutet.
Ja, man wirft deutlich weniger mit mehrschichtigen Daten durch die Gegend, aber trotzdem fühlt sich das nervig an.
Das `if let Some(something) = foobar() { … }` Konstrukt ist etwas, das ich mag.
Ein "Führe nur aus, wenn das auf der rechten Seite 'etwas' und nicht `None` ist".
Und das "etwas" ist als Variable `something` innerhalb des if nutzbar.
Quasi der Rust `?` Operator in anders herum.

# Fazit

Alles in allem kann ich nicht wirklich ein "dies" oder "das" von mir geben.
NodeJS mit TypeScript ist nicht schlecht, man kann damit vieles relativ einfach umsetzen.
Rust ist Ressourceneffizienter und vermutlich grade für etwas, das längere Zeit so bleibt, den zeitlichen Mehraufwand wohl wert.
Die beste Antwort ist wohl mal wieder "it depends".

Vielleicht muss ich mir zu Zukunft mal einen Mittelweg anschauen:
`deno` ist eine TypeScript Laufzeitumgebung, gebaut in Rust.

Erstmal werde ich auf jeden Fall schauen, wie sich meine Rust Projekte über die Zeit entwickeln.
