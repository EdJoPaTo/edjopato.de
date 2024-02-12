---
title: Webcam Blur und Backgrounds - Eine riesige, dezentrale Energieverschwendung
date: 2021-10-07T19:25:00+02:00
categories:
  - open-source
tags:
  - desktop
  - environment
  - linux
  - macos
  - secrets
  - windows
---

Videokonferenzlösungen haben häufig Features, um die Webcam mit einem Blur oder einem anderen Hintergrund auszustatten.
Das demnächst erscheinende [BigBlueButton 2.4 bringt dieses Feature](https://docs.bigbluebutton.org/2.4/new.html#webcam-background-blur) auch mit, was ich mal als Anlass für einen kleinen Rant nehme.
Aus meiner Sicht ist das nicht mehr als eine riesige, dezentrale Energieverschwendung.
Und aus meiner Sicht finde ich diese auch noch nerviger als welchen Hintergrund auch immer eine Person natürlicherweise hat.

<!--more-->

# Was genau tut dieses Feature?

Eine Person hält einen Kopf in die Kamera.
Irgendein Algorithmus oder irgendein mehr oder weniger gut trainiertes Netz versuchen diesen Kopf und dessen Konturen zu erkennen.
Der erkannte Kopf soll dann weiterhin zu sehen sein, alles andere soll entweder unscharf gemacht werden oder mit einem Bild überlagert werden, damit es so aussieht, als wäre man dort.

Bleiben wir mal bei dem Algorithmus und verstehen mal, was die Aufgabe dessen sein wird.
So ein Algorithmus wird tausende von Pixeln miteinander Vergleichen um beispielsweise Kantenerkennung zu machen oder mit vorherigen Bildern Bewegungen erkennen.
Rechen-Operationen auf vielen Tausend Werten klingt nach einer ganzen Menge Arbeit.
Und die Webcam macht nicht nur ein Bild, es sind so einige pro Sekunde.
Wie lange dauert so ein Meeting?
Unvorstellbare Mengen an Berechnungen werden dafür in einem Meeting genutzt.

Und die kosten Energie.
Für eine Person mag das relativ wenig sein, wird die CPU halt ein wenig wärmer und das Gerät pustet ein wenig mehr.
Überlegt man sich aber, wie viel solche Features genutzt werden, kommen da gewaltige Mengen an Energie zusammen.

Ironischerweise meckern vermutlich dieselben Personen auch über die Windkraftanlagen, die sie nicht sehen wollen…
Ein Freund meinte gestern zu mir: "Entweder Leben oder [Umweltsünde hier eintragen] und unsere Welt [schneller] zerstören. Siehst ja was die Menschen wählen."
Bei manchen Themen, so wie bei diesem, ist es aber so einfach die Umweltsünde sein zu lassen.

# Ist es der Blur Effekt Wert?

Nehmen wir an, ich sitze jetzt in so einem Meeting und mir gegenüber sitzt so eine Person mit aktiviertem, falschen Hintergrund.
Schickes 300. Stockwerk Chefsessel Büro, meinetwegen.
Was mich dann jedoch die ganze Zeit ablenkt, ist die schlechte Kantenerkennung.
Und durch die Lücken zwischen falschem Chefsessel und Kopf kann man im Laufe eines Meetings so ziemlich alles im Raum sehen, was auch immer da so ist.

Nun haben Menschen diesen Nachteil, dass sie Haare auf dem Kopf haben, Bärte tragen, Brillen aufhaben usw.
Das alles sind keine klaren Kanten und teilweise lichtdurchlässig.
Wir kennen die Bokeh Bilder von Smartphones, welche in einem einzigen Bild schon Fehler machen, Haare in den Hintergrund deuten oder Brillen absägen.
Hier fällt es häufig nicht so auf, weil es eine sanfte Unschärfe hat, keinen starken Blur oder gar ein kompletter Austausch des Bildes entlang dieser Kante.
Und hinzu kommt noch, das wir dafür hoch angepasste Chips mit guten Kamerasensoren einsetzen, um ein einziges Bild zu generieren, auf das wir auch gerne ein paar Sekunden warten.
Webcams machen mindestens 10 Bilder pro Sekunde, normalerweise deutlich mehr und das ganze mit meistens kleinen und damit schlechten Sensoren, die Laptop Monitore sollen ja flach sein.

Vielleicht sollten sich alle Menschen die Köpfe rasieren, damit wir mehr klare Kanten haben?

Ich habe auch schon ein Interview gesehen, bei dem vermutlich auch aus rechtlichen Gründen ein Poster im Hintergrund nicht gewollt war.
Das automatische Blur wird es schon regeln.
Innerhalb der Stunde Interview konnte ich mehrfach Teile oder das gesamte Plakat sehen und wusste genau, warum es ein wenig ironisch für dieses Interview war.
Hätte man definitiv vermeiden können und es wäre so einfach gewesen.

Um wieder zurück zum Thema zu kommen.
Egal was da im Hintergrund ist, im Laufe eines Meetings kann ich es eh sehen.
Mit Blur statt irgendeinem Bild ist es zwar besser, aber es nervt ungemein, weil es die ganze Zeit am Flackern ist.
Und dafür werfen wir kollektiv Energie zum Fenster raus.

"Aber ich hab doch Solar-Panel!"
Stimmt, aber du könntest es sinnvoller einsetzen.

# Es geht auch besser

Wenn man wirklich einen schicken Hintergrund haben will, dann geht es sowohl besser, als auch effizienter.
Ich kenne mehrere, die mit Greenscreens und ihren Webcams herumspielen.
Grüner Pulli, Greenscreen und ein Kopf schwebt im Meeting.
Greenscreens sind durch klare Kontraste und einheitliche Farben leicht zu erkennen.
Ein Computer kann also sehr einfach Grün gegen etwas anderes austauschen und muss dafür nicht komplexe Algorithmen oder irgendwelches Maschine-Learning Zeugs anwenden.

Natürlich wird das nicht beim ersten Versuch gut klappen, vielleicht stimmt die Ausleuchtung noch nicht oder was auch immer, aber man lernt auch noch etwas dabei.
Das Ganze braucht keine übertriebenen Mengen Energie und sieht auch noch gut aus, weil es rein technisch schon kein Problem mit der Kantenerkennung hat.

Auch eine spiegellose Kamera mit einem passenden Objektiv, welches man genau auf den Abstand seines Kopfes einstellt, ist möglich als Webcam.
So wird nur der eigene Kopf scharf gestellt und alles andere wird rein durch Optik und Lichtumlenkung unscharf.
Das kostet keinen Strom und erzeugt das beste Unschärfe-Ergebnis.

Oder die energieeffizienteste und billigste Variante, aufräumen, abhängen oder eine andere Kameraperspektive.
