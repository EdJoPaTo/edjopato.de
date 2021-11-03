---
title: Rust hilft dabei, nur valide Zustände abzubilden
date: 2021-10-04T15:20:00+02:00
resources:
  - name: cover
    src: sky-mud.jpg
    title: Himmel, Schlamm und Stroh
categories:
  - open-source
tags:
  - rust
  - typescript
---
In allen Programmiersprachen werden Konstrukte gebaut, um ein Ziel zu erreichen.
Manche sind dabei besser oder schlechter lesbar und manche sind auch nur so mehr oder weniger korrekt.

<!--more-->

# Option und Result

Aus der C Welt kennt man zum Beispiel den Rückgabewert `-1`, wenn etwas schiefging, ansonsten der gewünschte Wert.
Hier muss man dann aktiv prüfen, ist das kleiner 0?
Wenn man das nicht tut, funktioniert das auch meistens, solange bis man das Ganze eben ausrollt.
"Works on my machine" ist da recht bekannt.

Wenn man jetzt zum Beispiel die Dateigröße wissen will, dann ist es nie korrekt, wenn ein vorzeichenbehafteter Integer zurückkommt.
Die Dateigröße kann niemals negativ sein.
Aus einigen Sprachen kennt man den Rückgabewert `null`, welcher auch als "Billion Dollar Mistake" bezeichnet wird.

Rusts Lösung für solche Probleme finde ich hier doch recht elegant.
`Option<Value>` und `Result<Value, Error>` werden hier benutzt.
Für die Option gibt es dann beispielsweise diese zwei Möglichkeiten: `None` und `Some(Value)`.

```rust
fn get_lamp_state() -> Option<bool> {
  …
}
```

Wenn ich beispielsweise frage, ist die Lampe an und man diesen Code sieht, dann kann man daraus bereits einige Schlüsse ziehen.
Die Methode weiß das potenziell gar nicht.
Rufe ich diese Methode auf, so bin ich vom Compiler gezwungen, diesen Fall zu betrachten.
Ich kann diesen Fall nicht übersehen, wie im `-1` Fall.

```rust
match get_lamp_state() {
  Some(true) => println!("The lamp is on"),
  Some(false) => println!("The lamp is off"),
  None => println!("There is no lamp?"),
}
// or
if let Some(state) = get_lamp_state() {
  println!("The lamp state is {}", state);
} else {
  println!("There is no lamp?");
}
```

Selbst wenn jemand früher mal eine `get_lamp_state() -> bool` geschrieben hat und diese überarbeitet, fällt dem Compiler auf, dass das nicht mehr geht.
Jemand anderes kann seinen Code korrigieren und mir hilft der Compiler dann, ebenfalls korrekten Code zu verwenden.
Ganz ohne `-1` oder `null`.

`Result<Value, Error>` ist quasi das gleiche, nur dass der andere Fall kein `None`, sondern ein `Err()` mit einer (hoffentlich) hilfreichen Meldung ist.

# Enums mit Werten

Stellen wir uns einen Fahrstuhl vor.
Die meisten Leute sind an der korrekten Implementierung von Fahrstühlen interessiert, von daher vielleicht kein schlechtes Beispiel.
Dieser Fahrstuhl hat unterschiedliche Dinge, die zu tun sind.
Zum Beispiel in ein bestimmtes Stockwerk fahren oder darauf warten, bis jemand ein bestimmtes Stockwerk angibt.
Aber jemand könnte auch den Notruf betätigen, in dem der Fahrstuhl anhalten und Hilfe rufen soll.
Oder der Fahrstuhl könnte in einen Wartungsmodus versetzt werden, in dem die Steuerung nichts tut.

Das sind schon viele unterschiedliche Zustände, die jetzt möglichst ohne ungültige Zustände abgebildet werden sollen.
Eine naive Variante wäre vielleicht so etwas:

```typescript
interface Lift {
  targetFloor: number;
  waiting: boolean;
  emergency: boolean;
  maintenance: boolean;
}
```

Kann man mit arbeiten, man muss nur immer prüfen, ob der Fahrstuhl gerade im `maintenance` oder `emergency` Fall ist, bevor eine Anweisung ausgeführt wird.
Nehmen wir mal an, jemand schreibt jetzt einen Brandmodus vor, bei dem Fahrstühle ins Erdgeschoss fahren sollen.
Dieser Fall ist neu und jemand muss überall sicherstellen, dass dieser Fall auch berücksichtigt wird.
Menschen machen Fehler, irgendwo wirds vergessen und plötzlich passieren Dinge, die nicht hätten sein sollen.

Wenn man das Ganze jetzt mit einem Enum implementiert, dann ist man schon mal gegen neue Fälle geschützt.
Nur den Sonderfall, dass der Fahrstuhl gerade einen "fahre zu Stockwerk 42" Befehl ausführt, muss man dann getrennt behandeln.

```typescript
interface Lift {
  targetFloor?: number;
  mode: Mode;
}

enum Mode {
  delivery,
  waiting,
  emergency,
  fire,
  maintenance,
}
```

Schon mal besser, allerdings resultiert das dann in solchem Code, in dem wir TypeScript erklären, was bestimmt stimmen wird:
```typescript
if (lift.mode === 'delivery') {
  // Tell TypeScript targetFloor is not undefined (with the !)
  // We are in the correct mode, it has to be defined
  const targetFloor = lift.targetFloor!;
}
```

Man kann auch in allen Fällen prüfen, ob die Variable wirklich definiert ist.
Das sorgt dann für einen weiteren Check, der zusätzlich Performance frisst.

Die aus meiner Sicht elegante Variante, die man in Rust bauen kann, sieht so aus:
```rust
enum Lift {
  Delivery(u8),
  Waiting,
  Emergency,
  Maintenance,
}
```

Das Ganze dann zu benutzen würde in etwa so aussehen:

```rust
fn do_next(current_job: Lift) {
  match current_job {
    Lift::Delivery(target_floor) => println!("move to floor {}", target_floor),
    Lift::Waiting => println!("wait for someone to enter"),
    Lift::Emergency => println!("notify emergency services"),
    Lift::Maintenance => println!("dont no anything, mentenance"),
  }
}
```

Rust weiß aus dieser Syntax heraus schon, dass `target_floor` verfügbar ist, wenn man im `Delivery` Fall ist.
Und das Ganze ist zur Kompilierzeit bekannt, es gibt also keine weiteren Laufzeit-Checks dafür, dass dem auch so ist.
Dafür reicht allein die Abfrage, in welchem Zustand man gerade ist.

Diese doch recht simple Syntax sorgt also dafür, dass unser Programm sowohl sicherer gegen menschliche Versehen ist, als auch performanter.

Wenn man das ganze jetzt noch weiter denkt, kann man auch beispielsweise einen Ort des Notfallbuttons dazu definieren.
Dieser könnte dann nur ausgelesen werden, solange man eben in dem Zustand ist, dass ein Notfallbutton gedrückt wurde.

All das kann man auch in TypeScript nach implementieren, beispielsweise in dem man dies über private Variablen und eine Klasse kapselt.
In Rust ist es aber eben Teil des Sprachkonzepts, nur valide Zustände abbildbar zu machen.
Das verhindert Fehler schon per Design und zur Kompilierzeit, nicht erst zur Laufzeit, wenn der Fahrstuhl in Flammen steht.

# Serde

Ser-wat? [Serde](https://serde.rs/) ist ein Framework zum **ser**ialisieren und **de**serialisieren.

Hat man beispielsweise JSON Daten, so kann man diese mit TypeScript einlesen und schreiben:

```typescript
const data: Data = {…};
const jsonString: string = JSON.stringify(data);
const dataAgain: Data = JSON.parse(jsonString);
```

In diesem Fall sind die Angaben von Typen in TypeScript jedoch nur "müsste das sein".

Nichts hindert mich daran, aus Versehen die falschen JSON Dateien einzulesen.
Zur Laufzeit, wenn die Inhalte gelesen werden sollen, knallt es dann, weil irgendwelche Inhalte nicht gelesen werden können.

Serde in Rust prüft jedoch, was geschrieben wird und nutzt dafür die in Rust gewohnten Typen und `struct`s.

```rust
let data = Data {…};
let json_string: String = serde_json::to_string(data)
  .expect("failed to serialize Data to JSON");
let data_again: Data = serde_json::from_str(&json_string)
  .expect("failed to deserialize Data from JSON");
```

Die Methode `expect` ist übrigens eine Methode vom `Result`.
Wenn das `Result` ein `Err` ist, dann stirbt das Programm mit der angegebenen Fehlermeldung.
Das heißt, nicht ein Fehler im Programm sorgt dafür, dass es abstürzt, sondern die Entwickler selbst sagen, dass das bei einem Fehler passieren soll.
Umgekehrt heißt das, jegliche solcher `Result`s können in Fehlerbehandlungen berücksichtigt werden.

Im Gegensatz zu TypeScript kann ich mir mit diesem Code sicher sein, dass meine JSON Daten wirklich dem entsprechen, was ich wollte.
Es kann im folgenden Code also nicht vorkommen, dass irgendwas nicht gelesen werden konnte, die Typen sind die gesamte Zeit sichergestellt.
Serde bietet so einige Möglichkeiten um das Arbeiten mit JSON (und anderen Formaten) deutlich entspannter und vor allem nicht Fehleranfällig zu gestalten.

# Fazit

Mit dem Konstrukt der Enums mit Werten schafft Rust etwas, dass ich für mächtiger halte, als ich bisher so angenommen hatte.
Genau genommen sind `Option` und `Result` auch "nur" Enums.
Eine Erkenntnis, für die ich eine Weile gebraucht habe.

```rust
enum Option<Value>        { Some(Value), None       }
enum Result<Value, Error> {   Ok(Value), Err(Error) }
```

Eine relativ einfache Syntax, die aber mächtige Konsequenzen für die Fehlerfreiheit eines Programmes hat.

Und auch mit solchen Frameworks wie Serde bietet Rust verlässliche Tools, die das Vertrauen in die eigene Software weiter stärken, dass diese auch wirklich funktionieren.
