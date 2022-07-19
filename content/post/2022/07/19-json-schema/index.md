---
title: JSON Daten überprüfen mit JSON Schema
date: 2022-07-19T18:19:00+02:00
categories:
  - open-source
tags:
  - calendarbot
  - data
  - deno
  - nodejs
  - typescript
  - web
---
Bei meinem Kalenderbot können zusätzliche Veranstaltungen, wie Tutorien, hinzugefügt werden.
Das passiert über JSON Dateien in einem [öffentlichen Git Repository](https://github.com/HAWHHCalendarBot/AdditionalEvents), auf das alle Pull Requests stellen können.
Das Download Tool holt sich dann regelmäßig die aktuellen JSON Dateien und pflegt diese mit in die Kalenderdateien vom Kalenderbot ein.
Um sicherzustellen, dass diese Daten auch im richtigen Format vorliegen, habe ich JSON Schema verwendet.
<!--more-->

JSON Schema beschreibt das Format von JSON Dateien.
Damit werden dann beliebig viele JSON Daten geprüft, in meinem Fall alle zusätzlichen Kalendereinträge.

Als Beispiel eine typische Veranstaltung, danach das JSON Schema, welches die Veranstaltung verifiziert.

```json
{
  "year": 2022,
  "month": 7,
  "date": 14,
  "name": "CaDS-JourFixe",
  "starttime": "12:00",
  "endtime": "12:30",
  "room": "287"
}
```

```typescript
const eventSchema = {
  type: "object",
  properties: {
    name: { type: "string" },
    room: { type: "string" },
    starttime: { type: "string", pattern: "^[12]?\\d:\\d\\d" },
    endtime: { type: "string", pattern: "^[12]?\\d:\\d\\d" },
    date: { type: "integer", minimum: 1, maximum: 31 },
    month: { type: "integer", minimum: 1, maximum: 12 },
    year: { type: "integer", minimum: 2015, maximum: 2100 },
  },
  required: ["name", "room", "starttime", "endtime", "date", "month", "year"],
  additionalProperties: false,
};
```

Das fertige JSON Schema ist relativ selbsterklärend.
In diesem Fall ist es ein JSON `object`.
In diesem Objekt stehen `properties`, welche Keys mit ebenfalls wieder JSON Typen enthalten.
Ein einfacher Typ ist der Wert von `name`, welches irgendein `string` ist.
Spannender wird die `starttime` und `endtime`, welche ein `pattern`, also einen regulären Ausdruck, erfüllen müssen.
Zuletzt kommen Tag, Monat und Jahr, welches Ganzzahlen mit `minimum` und `maximum` sind.
Alle Keys sind `required` und es darf keine zusätzlichen `properties` geben.

Das Ganze habe ich mittels [Deno](https://deno.land/) und TypeScript und [`ajv`](https://github.com/ajv-validator/ajv.git) zum Validieren umgesetzt.
Ein kurzer Vergleich zwischen Node.js und Deno führte dazu, dass Deno in der CI deutlich schneller als Node.js fertig war und so nutze ich für dieses relativ einfache Script Deno.

Nun werden bei jedem Push die JSON Dateien geprüft und ich kann mir sicher sein, dass diese später korrekt gelesen werden können.
