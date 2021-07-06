---
background:
  name: Luhebrücke
  style: url(/assets/2021/07/bridge.jpg)
date: 2021-07-06T22:40:00+02:00
lastmod: 2021-07-06T22:40:00+02:00
title: Qualitätschecks von Webseiten
tags:
  - browser
  - chrome
  - firefox
  - mozilla
  - privacy
  - safari
  - web
  - website
---
Webseiten können eine gute Struktur haben und gut benutzbar sein.
Sie können schnell laden und sichere Verbindungen nutzen.
Nur weiß man nicht immer alles und Tools können einem dabei helfen, Probleme aufzudecken.
Ich habe ein paar davon benutzt, um meine Webseiten zu verbessern.
Diese möchte ich kurz vorstellen.
<!--more-->

# Ziele oder auch Warum das Ganze

Webseiten werden von vielen benutzt.
Die am weitesten verbreiteten, "normalen" (= langweiligen) Menschen, (teilweise) Blinden, Menschen mit schlechtem Internet und auch Bots zur Indizierung für Suchmaschinen.

Die meisten Menschen scheint eine schlechte Webseite nicht zu stören.
Es gibt genug langsame Webseiten, mit denen beispielsweise Blinde oder Menschen mit schlechtem Internet nicht gut klarkommen.
Menschen mit einer Sehschwäche verlassen sich auf eine gute Struktur von Webseiten.
Inhalte sind klar gegliedert, Bilder haben eine Textbeschreibung und Icons, welche nicht vorgelesen werden müssen, sind auch dementsprechend gekennzeichnet.
Damit lassen sich Webseiten gut für eben diese Zielgruppe benutzen.
Ganz nebenbei: Indizierung durch Bots für Suchmaschinen profitiert auch genau davon, eine gute Struktur zu haben.

Menschen mit langsamem Internet (beispielsweise Menschen aus Deutschland) haben vor allem ein Interesse an kleinen Bildern und wenig zusätzlich geladenem Inhalt.
Stylesheets kann man meistens zusammenfassen und minified bereitstellen.
Bilder müssen nicht riesig sein und Bildkomprimierung kann einiges an Bandbreite sparen.
Zeichensätze (Fonts) kann man meistens auch weglassen.
Caching hilft zusätzlich, denn dann weiß der Browser, dass beispielsweise das Stylesheet noch aktuell ist und nicht nochmal geladen werden muss.

Inhalt steht im Fokus.
Wenn dieser in einer guten Struktur bereitgestellt wird, kann mit Stylesteets relativ einfach auch eine ansprechende Form dargestellt werden.
Große CSS Frameworks machen das Ganze aus meiner Sicht nur komplexer.
Auch JavaScript ist dafür meistens schlichtweg nicht nötig und auch das spart wieder Bandbreite.

Als letzten Punkt auf meiner Liste der Ziele ist die Sicherheit.
Dank Let's Encrypt ist es zu einfach, dies anzubieten.
Allerdings gibt es im Laufe der Zeit neue Erkenntnisse zur Verschlüsselung, neue Versionen der Protokolle erscheinen und alte Versionen werden nicht mehr empfohlen oder sind bekannt unsicher.

Über all diese Themen kann und muss man nicht unbedingt bis ins letzte Detail informiert sein.
Dafür gibt es Tools, die nach aktuellem Stand des Wissens Probleme analysieren und aufzeigen.
Und um eben diese soll es nun gehen.

# Tools

Im Folgenden ein kurzer Überblick über die Tools, die mir geholfen haben.
Dabei will ich gar nicht zu sehr in die Tiefe gehen, da diese selbst viele Dinge können, die ich gar nicht alle im Detail betrachten könnte.
Meistens beschäftigt man sich dann auch mit den passenden Details, sobald man da einen Hinweis zu sieht.
Und diese sind von anderen schon viel besser beschrieben.
Die Tools, die mir solche Hinweise geben, will ich hier empfehlen und kurz verlinken.

## Browser Dev Tools

Die Developer Tools in den Browsern sind schon ein erstes, mächtiges Werkzeug.
Diese bieten Beispielsweise schon Überprüfungen auf guten Kontrast oder fehlende Beschreibungen von Bildern.
Im Firefox findet man diese unter Accessibility → (oben links) Check for Issues → All Issues.

Die Console verrät ebenfalls einige Fehler.
Auch Einige, die man beim Verbessern im Laufe des Benutzens der folgenden Tools macht ;)

## Nu Html Checker

Der Nu Html Checker prüft den Inhalt und die Struktur der HTML.
Invalide HTML Elemente, fehlende Attribute, …
Hier lohnt es sich auch Unterseiten zu betrachten und nicht nur die Hauptseite, da jede Seite ihr eigenes HTML mit ihren eigenen potenziellen Fehlern hat.

https://validator.w3.org/nu/?showoutline=yes&showimagereport=yes&doc=https%3A%2F%2Fedjopato.de

## SSL Labs

SSL Labs betrachtet die Übertragungsverschlüsselung, die im Webserver eingestellt wird.
https://www.ssllabs.com/ssltest/analyze.html?d=edjopato.de

Ein Tool zum Erstellen von guten SSL Konfigurationen für viele Webserver bietet Mozilla:
https://ssl-config.mozilla.org

## Mozilla Observatory

Details der Webserver Konfiguration überprüft das Observatory von Mozilla.

https://observatory.mozilla.org/analyze/edjopato.de

## CSP Evaluator

Ein Detail dabei sind die "Content Security Policies".
Diese werden auch schon vom Observatory überprüft, beim Erstellen dieser hilft jedoch das dafür geschaffene Tool ein wenig mehr:
https://csp-evaluator.withgoogle.com/

Ein wenig veraltet ist der https://cspscanner.com, aber trotzdem hilfreich zum Verstehen von selbstgeschriebenen CSP Regeln.

Hier will ich auch noch mal auf die Console der Browser Dev Tools hinweisen.
Hier sieht man direkt, wenn Dinge dank einer CSP nicht mehr geladen werden.
Hier hilft es natürlich nicht, wenn die CSP alles untersagen und die Tools glücklich sind, aber die Webseite unbenutzbar wird.

Ich muss dazu sagen, dass ich noch lange nicht auf allen meinen Webseiten eine gute CSP habe.
Diese sind relativ spezifisch auf die Webseiten abzustimmen.
Mit einer guten CSP für beispielsweise Jitsi, welche dann auch mit allen modernen Browsern funktioniert, haben sich schon schlauere Leute als ich ihre Zeit vertrieben.
Was natürlich nicht heißen soll, dass man nicht danach streben sollte.

# Fazit

Vielleicht verhelfen diese Tools ja auch bei dir zu besseren Webseiten.
Auch, wenn es nur ein bisschen ist.

Im Observatory sieht man beispielsweise die Vergangenheit meiner Webseitenbewertung.
Anfang Juni habe ich mit 25 Punkten angefangen und Anfang Juli kam ich dann bei 110 an.
Immer mal wieder ein Stückchen besser.
