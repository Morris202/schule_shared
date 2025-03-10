#import "@preview/document:0.1.0": *
== Webfilter
=== Theorie
Der Web-Filter der FortiGate ist zuständig, um den Client auf gewisse Website den Zugriff zu verweigern oder zu gewähren. Man kann dabei bestimmte URLs blocken. Die Konfiguration könnte so aussehen. Dazu gehen wir in Security-Profiles auf *Webfilter*. Das folgende Beispiel blockiert Instagram und Facebook. 

#figure(
  image("webfilter.png", width: 70%),
  caption: [URL Filter]
)

Falls Clients dann versuchen auf die Website zu gelangen sehen sie Folgenden Alert.

#figure(
  image("accessblock.png", width: 70%),
  caption: [Access Block]
)

In der FortiGate kann dann unter *Log & Reports > Security Events* das Events angezeigt werden, welches durch den Alert geloggt wurde. 