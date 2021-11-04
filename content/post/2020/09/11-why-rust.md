---
title: Was macht Rust für mich spannend?
date: 2020-09-11T22:50:00+02:00
background:
  name: Rasensprenger im Garten
  style: url(/assets/2020/09/wl-lawn-sprinkler.jpg)
categories:
  - open-source
tags:
  - csharp
  - rust
  - typescript
---

Rust ist eine relativ junge Programmiersprache von Mozilla, welche einige interessante Konzepte beinhaltet.
Single Binaries und geringer Ressourcenverbrauch sind außerdem spannend.
Einige Ansätze von Rust will ich hier etwas beleuchten.
<!--more-->

Angefangen hat das ganze sicherlich mit [Blog Artikeln wie diesem hier](https://www.heise.de/hintergrund/Entwicklung-Warum-Rust-die-Antwort-auf-miese-Software-und-Programmierfehler-ist-4879795.html) (Hallo Felix von Leitner aka Fefe), hier soll es allerdings mehr um meine persönlichen Feststellungen nach etwas Rust Kontakt gehen.
Dieser Blog Artikel ist also stark von dem geprägt, was ich als interessant ansehe im Vergleich zu dem, was ich gewohnt bin.
Dabei habe ich selbst aktuell viel strict TypeScript Erfahrung und Lintern mit dem Versuch, möglichst stabilen und guten Code zu erzeugen.

Ein Konzept sind die [Lifetimes](https://doc.rust-lang.org/rust-by-example/scope/lifetime.html).
So kommt die Sprache ohne Garbage Collection aus und trotzdem muss man sich nicht um die Speicherverwaltung kümmern.
Alle Variablen haben auch immer eine Lifetime, meist wird diese nicht explizit geschrieben und vom Compiler gewählt.
So endet beispielsweise die Lifetime einer Variable in einer Funktion, sobald man diese Funktion verlässt.
Übergibt man eine Variable an eine Sub Funktion, so borgt man die Variable an diese.
Die Sub Funktion kann darauf zugreifen, solange die leihende Funktion nicht verlassen wurde.
Damit ist immer klar, wer den Speicher grade benutzt, keine zwei Funktionen können diesen gleichzeitig benutzen und der Speicher kann beim Ende der Lifetime freigegeben werden.

Auch ist die Fehlerbehandlung interessant gelöst.
Häufig geben Funktionen `Result<Success, Error>` zurück.
Man muss dann, um an den Inhalt zu kommen, also immer auch den Fehlerfall explizit bedenken.
Das sorgt für mehr durchdachtes Scheitern als "ein try catch drum herum regelt das schon".

Das Semikolon hat, im Gegensatz zu Sprachen wie C# oder JavaScript, wo es nur ein Statement beendet oder sogar weg gelassen werden kann, auch eine Bedeutung.
In anderen Sprachen fühlt sich das Semikolon ein wenig wie ein Füllwort "ähm" an.
Menschen benutzen es, aber es macht den Satz nicht aussagekräftiger.
In Rust wird der Wert "nach außen" gegeben, wenn eine Zeile nicht mit einem `;` endet.
Gut erklären kann man das vermutlich mit dem `if` oder `match` (eher bekannt als `switch` `case` in anderen Sprachen), welche dadurch interessant einsetzbar sind.
```rust
let result = if string.is_empty() {
  "default value"
} else {
  string.to_lower()
};
```

In diesem Beispiel ist das Semikolon ganz am Ende, hinter dem if.
Je nach dem, welchen Fall das if/else nutzt, wird die Variable befüllt.
Das sorgt mit dem `match` dafür, dass ich Dinge kürzer schreiben kann, für die ich in TypeScript beispielsweise eine extra Funktion bräuchte.

```rust
fn main() {
  …
  let result = match number {
    1 => "eins",
    2 => "zwei",
    _ => "viel"
  };
  …
}

```

Und hier die vergleichbare Nutzung in TypeScript.

```ts
function main() {
  …
  let result = numberString(number);
  …
}

function numberString(number: number): string {
  switch (number) {
    case 1:
      return "eins";
    case 2:
      return "zwei";
    default:
      return "viel";
  }
}
```
Man könnte auch eine Variable anlegen und diese aus dem Switch Case heraus setzen, immutable Variablen haben aber auch ihren Charme.
In Rust muss man mutable (= veränderliche) Variablen zusätzlich kennzeichnen und der Compiler warnt bei nicht genutzter mutable Markierung, also einen Schritt besser als `const`/`let` in JavaScript und TypeScript.
Generell helfen der Compiler und Clippy (quasi ein Linter) bei vielen Problemen und "dummen" Herangehensweisen.
Häufig gibt es auch gleich einen Vorschlag, wie man das Problem lösen kann.

Das `match` ist auch nett für die Fehlerbehandlung:
```rust
match some_function() {
  Ok(result) => println!("result contains the successful return value: {}", result),
  Err(err) => println!("err contains the error which happened: {}", err),
}
```

Hinzu kommt, dass immer eine einzelne Binary gebaut wird, die direkt ausgeführt werden kann.
Man hat keine herum liegenden DLLs (C#) oder einen riesigen node_modules Ordner (Node.js).
Container sind super um große Haufen von seltsamen Dependencies jeweils weg zu sperren, mit Rust (oder Go) aber nicht mehr so wichtig.
Mit Node.js hatte ich es immer mal, dass beispielsweise die installierte Node.js Version zu neu für etwas wurde oder Dependencies kaputt waren.
Ist die Rust Binary einmal gebaut, passiert so etwas nicht mehr.

Außerdem ist Rust auch ressourceneffizienter als andere Sprachen.
Programme gebaut in Rust verbrauchen wenig CPU / RAM.
TypeScript / JavaScript laufen in Node.js, quasi einem Chromium Browser.
Dass das nicht immer ganz effizient sein kann, war mir bewusst.
Aber auch [der Umbau des Kalenderbot Backends von C# zu Rust]({{< relref "/content/post/2020/09/11-calendarbot-rust.md#ressourcenauslastung" >}}) hat mir gezeigt, dass auch C# nicht annähernd so effizient arbeitet.

Ein paar Projekte sind aktuell mit Rust in Arbeit, mal schauen, hoffentlich landet davon auch etwas im Blog.
