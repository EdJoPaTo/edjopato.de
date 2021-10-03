---
background:
  name: Fahrzeuge für Spielkinder und Minderjährige auf dem 36c3
  style: url(/assets/2020/01/36c3cars.jpg)
date: 2020-01-22T16:15:00+01:00
title: Gravatar Privacy
tags:
  - gravatar
  - avatar
  - web
  - service
  - privacy
---
Wie sorgt man dafür, dass bei allen Diensten der eigene Avatar angezeigt wird?
Ganz einfach, ein Webdienst (Gravatar), der für die eigene E-Mail Adresse ein Bild bereitstellt.
So kann ein Dienst Gravatar fragen, ob zu einer E-Mail Adresse ein Avatar existiert und diesen anzeigen.
Das ganze hat aber auch eine Kehrseite.
<!--more-->

Im Grunde ist der Use Case ganz simpel.
Und etwas das Nutzer wollen.
Dann muss ich nicht überall noch mal meinen Avatar hochladen.

Von der technischen Umsetzung her auch relativ einfach.
Avatare sind static content, den kann man super cachen.
Außerdem sind sie nicht all zu groß, also auch nicht speicherintensiv.
Und man kann sie durch einen Key abrufen, der E Mail Adresse, typischer Key Value Speicher, altbekannt.

Andersherum gesehen, wenn jetzt viele Dienste Gravatar benutzen, dann bekommt Gravatar einen guten Überblick welche Nutzer wo sind.
So fragt zum Beispiel Dienst A nach Nutzer 1, 2 und 3.
Wenn jetzt ein Dienst B nach Nutzer 3 und 4 fragt, dann kann Gravatar schon etwas über Nutzer 3 aussagen: Nutzt Dienst A und B.

Viel Schlimmer: Das geht nicht nur für Gravatar Nutzer, sondern für alle.
Ein Dienst fragt nicht nur nach Gravatar Nutzern sondern fragt für alle Nutzer des Dienstes ob diese Gravatar nutzen.

Werbe Blocker unterdrücken die meisten Tracker wie Facebook Like Buttons und auch Werbung häufig schon.
Diese sind aber meist auch von den Nutzern nicht gewünscht.
Avatare hingegen sind von den Nutzern gewünscht.
Tracker in gewünschtem Content haben ist also ziemlich schlau aus Tracker Sicht.

# Viele E-Mail Adressen

Ein relativ einfacher Weg ist es, viele E-Mail Adressen zu haben.

Die meisten Nutzer verwenden eine E Mail Adresse und so werden Tracker auch einfache String vergleiche machen.
Wenn man also gravatar-privacy-spam1@edjopato.de und gravatar-privacy-spam2@edjopato.de als E-Mail Adresse verwenden würde, unterscheiden sich diese textuell und damit auch im Hash.

Personen könnten erkennen das edjopato.de meine Domain ist und damit alle E-Mail Adressen dieser Domain wohl zu einer Person gehören.
Allerdings ist dies relativ individuell.
Wenn ich unter dieser Domain jetzt meinem Bruder auch eine E-Mail gebe und er diese benutzt, dann ist dem nicht mehr so.
Das automatisiert zu erkennen ist nicht einfach.

Da nur ein kleiner Teil eigene Domains für E Mails hat und die meisten E-Mail Giganten mit eigenen Domains nutzen, werden diese vernachlässigt und dienen so zu einen (begrenzten) Schutz vor Massen-Tracking.
Individuell allerdings nicht.

# Andere Dienste nutzen

Beispielsweise Wordpress (daraus ist Gravatar entstanden) nutzt Gravatar.
Antwortet man auf einen Post, so ist die E-Mail Adresse hinterlegt und Gravatar kann diese mit dem Thema des Posts verbinden.
Klaus antwortet also gern auf Posts zum Thema Privacy.

Alternativ kann man sich Dienste suchen und benutzen, die keine Tracker wie Gravatar einbinden.
Ich zum Beispiel blogge mittels [hugo](https://gohugo.io/), da fallen HTML Dateien komplett ohne externe Verweise heraus.

# Dienstanbieter zur Änderung bewegen

Einige Dienste muss man benutzen, zum Beispiel weil es Slack heißt und die Firma es benutzt.
Nun kann man versuchen die Firma davon zu überzeugen, Slack nicht zu benutzen (auch noch aus anderen Gründen), das ist aber ein aufwendigerer Prozess.
Bei Slack ist die Integration, soweit ich weiß, vom Anbieter des Workspaces abstellbar.

Man kann auch Mails an den Dienstanbieter schrieben.
Bei Slack wohl wieder relativ aussichtslos.
Kleinere Seiten wie Wordpress Blogs respektieren diesen Wunsch aber durchaus gerne.

Ein anderer Weg ist es, Aufmerksamkeit zu schaffen, dass da grade Tracker "beobachten".
Dafür habe ich mir einen neuen Avatar erstellt, der genau dies aussagt und bei Gravatar eingestellt.
Alle Dienste, die ich benutze werden nun diesen neuen Avatar laden und anzeigen.
![My Gravatar violates Privacy Avatar](/assets/2020/01/gravatar-privacy-simple.svg)

Als weiteres Problem beinhaltet die E-Mail Adresse, zum Beispiel in meiner Firma oder der Hochschule meinen vollen Namen.
Dieser wird mit 3rd Parties geteilt und für das tracking genutzt.
Also habe ich dafür einen leicht angepassten Avatar gemacht und diesen auf die E-Mail Adressen gepackt, die meinen vollen Namen beinhalten.

![My Gravatar violates Privacy Avatar also mentioning the full name email address](/assets/2020/01/gravatar-privacy-full-name.svg)

Ich bin mal gespannt an wie vielen Stellen dieses rote Wunderwerk auftauchen wird und an wie vielen Stellen ich etwas dagegen unternehmen kann.
Ob ich dann aufhöre den Dienst zu benutzen oder ob der Dienst aufhört, Gravatar zu benutzen.
Der Rest wird wohl diesen roten Avatar bewundern müssen.

Nachmachen?
Die beiden Bilder sind hier als SVG eingebunden.
Runterladen, in Inkscape öffnen, anpassen, benutzen.
