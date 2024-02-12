---
title: Fusselfreier Quellcode - so nervig wie möglich bitte
date: 2021-11-02T20:10:00+01:00
categories:
  - open-source
tags:
  - deno
  - nodejs
  - rust
  - typescript
---

Beim Entwickeln baut man manchmal schrecklichen Quellcode.
Teilweise ist das ein schlechtes Architekturdesign, teilweise aber auch Sprachsyntax, die optimierungswürdig ist.
Bei Letzterem versuchen Linter (oder auch statische Analyse Tools genannt) einem zu helfen.
"Es funktioniert zwar, ginge aber besser" ist eine simple Formulierung dafür.

<!--more-->

# Beispiel

Vielleicht mal ein Beispiel, wo einem so ein Hinweis helfen kann.
Nehmen wir mal an, ich hätte folgenden JavaScript / TypeScript Quellcode:

```typescript
const stuff = ["Cat", "Dog", "Horse", "Spider"];

if (stuff.indexOf("Spider") >= 0) {
  console.log("We got a cute spider!");
}
```

Dieser Quellcode würde so laufen, es ginge aber besser.

Zum einen hat JavaScript seit ES2016 die [`Array.prototype.includes`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes) Funktion.
Wenn man diese benutzt, wird der Quellcode verständlicher und besser zu lesen.
Vielleicht benutzt man JavaScript schon länger als es ES2016 gibt oder musste vorher eine ältere Version verwenden.
Hier hilft so ein Linter einen auf neuere Syntax zu stoßen oder bessere Lesbarkeit zu erzielen.

```diff
-if (stuff.indexOf("Spider") >= 0) {
+if (stuff.includes("Spider")) {
   console.log("We got a cute spider!")
 }
```

Es könnte sich, was die Performance angeht, auch lohnen ein [`Set`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set) zu verwenden, statt wie hier, ein Array.
Es wird nur auf Existenz geprüft, das ist mit einem `Set`, vor allem wenn diese groß werden, meistens schneller.
Linter helfen also auch dabei, effizienteren und damit performanteren Code zu finden.

```diff
-const stuff = ['Cat', 'Dog', 'Horse', 'Spider'];
+const stuff = new Set(['Cat', 'Dog', 'Horse', 'Spider']);

-if (stuff.includes("Spider")) {
+if (stuff.has("Spider")) {
   console.log("We got a cute spider!")
 }
```

Und vielleicht ist es schon aufgefallen, irgendwer hat in dem Quellcode sowohl Strings mit `'` als auch mit `"` verwendet.
Auch hat nicht jede Zeile ein Semikolon am Ende (`;`).
Das merken Linter an und bieten meistens sogar eine `--fix` Variante, die den Quellcode automatisch anpasst.
Ich verwende diese automatischen Fixes jedoch ungern, da ich damit weniger lerne.
Und damit kommen wir schon zu meinem hauptsächlichen Thema.

# Linter als Lernquelle

Linter bieten, gerade dadurch das viele Menschen mit Optimierungsgedanken dort etwas beisteuern, viele hilfreiche Tipps.
Diese Tipps kann ich bekommen, ohne das eine Person mir diese geben muss, sondern kann mir diese Tipps direkt und genau dann durch ein Tool abholen, wenn sie relevant werden.
Wir Menschen lernen besser, wenn wir schnell Feedback bekommen, was wir besser machen könnten.

Aus dem Grund mag ich Linter und stelle sie mir gerne "härter" ein, sodass diese noch mehr Hinweise geben.
Einige dieser Hinweise sind dann nicht unbedingt richtig oder ich akzeptiere diese, dann kann man diese im Quellcode vermerken.
Bei ESLint (JavaScript bzw. TypeScript) schreibt man dazu einen Kommentar vor die betreffende Zeile.
Im folgenden Beispiel gibt es eine Bedingung, die immer gleich ist, also konstant (`no-constant-condition`).
Wenn dies genau das Ziel ist, ignoriere ich den angemerkten Hinweis.

```typescript
function annoyance() {
  // eslint-disable-next-line no-constant-condition
  while (true) {
    alert("be annoyed!");
  }
}
```

# Rust

Viele sagen zu Rust, man müsse schon mit dem Compiler kämpfen und ich mache das noch schlimmer?
Im Grunde gilt hier für mich derselbe Gedanke, wie auch von JavaScript zu TypeScript:
Wenn der Compiler schon sagt, da stimmt was nicht, dann wird mir das nicht mehr zu Laufzeit um die Ohren fliegen.
Und genau das macht der Rust Compiler auch, es wird eine ganze Klasse an Bugs verhindert, bevor überhaupt eine Anwendung hinten rausfällt.
Und die Lints gehen nur weiter und geben mir noch mehr Hinweise, was ich vielleicht noch bedenken könnte.

Spannend hierbei ist, dass Rust seine eigenen Linter mitbringt.
Bei Node.js ist dies nicht so, dort installiert man sich seinen eigenen.
Ich verwende hier [xo](https://github.com/xojs/xo), welcher mittlerweile auch TypeScript erkennt und unterstützt.
Deno ist quasi der Nachfolger von Node.js, in vielen Fällen Node.js weiter gedacht und in Rust entwickelt.
Deno bringt wie Rust seinen eigenen Linter mit (`deno lint`).

Rust hat mehrere Linter.
Wenn man baut (`cargo build`) können Probleme auffallen.
Diese Probleme kann man auch schon mit `cargo check` aufzeigen, was deutlich schneller ist als ein normaler Build.
Wenn man jetzt noch mehr haben will, nutzt man `cargo clippy`, inspiriert durch die fröhlich nervige Büroklammer in alten Office Versionen.
Da mir aber noch nicht langweilig genug war, gehe ich noch weiter und aktiviere noch mehr Lints: `cargo clippy -- -W clippy::pedantic`.
`-W` steht für Warnungen bei diesen Lints, sprich noch kein Error und `clippy::pedantic` sind die pedantischen Lints, die über die normalen Clippy Lints hinaus gehen.
Wenn einem dann immer noch langweilig ist, kann man auch noch `-W clippy::nursery` aktivieren und bekommt experimentelle Lints.
Für Hinweise in der `Cargo.toml` gibt es `-W clippy::cargo`.

# Bash

Spannend finde ich, dass es sogar für so etwas wie Bash Linter gibt, die immer mal hilfreiche Vorschläge machen: [ShellCheck](https://github.com/koalaman/shellcheck).

# Fazit

Das Nervige bei JavaScript / TypeScript ist die verstreute Welt von unterschiedlichen Code-Styles und unterschiedlichen Lintern.
Wenn man mal ein fremdes Projekt hat und etwas beisteuern will, muss man erst schauen, was für ein Linter verwendet wird und sich nach diesem richten.
Deno versucht dies etwas gerade zuziehen in dieser Welt.

Bei Rust ist dies einfacher, da gibts diese Lints eben schon integriert und für alle dieselben.
Vor allem arbeiten alle zusammen und steuern Lints für Clippy bei, statt wie bei Node.js zu unterschiedlichen Projekten (TSLint, ESLint, unterschiedliche ESLint Regelsatz Repositories, …).
Wenn man allerdings fremde Projekte mal mit Clippy prüft (auch schon ohne pedantisch zu sein), dann gibts es teilweise doch so einige Hinweise.
Da könnten doch schon mehr Leute mal schauen, welche hilfreichen Hinweise die Linter so zu bieten haben.

Und um noch mal auf die Überschrift einzugehen:
Je nerviger man diese einstellt, desto mehr lernt man auch dabei.
