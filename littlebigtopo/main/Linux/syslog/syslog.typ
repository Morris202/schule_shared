#import "@preview/document:0.1.0": *

== Syslog Server Linux
=== Setup
Da Cisco-Router und Switches nicht kompatibel mit systemd sind verwenden wird ```syslog-ng``` als Syslog-Server. Dieser wird auf einem Linux-Server installiert.

=== Konfiguration
Zuerst wird mit mit dem Befehl ```sudo apt-get install syslog-ng``` syslog-ng installiert. Anschließend wird die Konfigurationsdatei ```/etc/syslog-ng/syslog-ng.conf``` angepasst. Hier ein Beispiel:

#figure(
  image("syslog-conf.png", width: 70%),
  caption: [Änderungen in der syslog-ng.conf]
)

Daraufhin wird der syslog-ng Service mit ```sudo systemctl restart syslog-ng``` neu gestartet. Der Router auf dem in der Zwischenzeit die Interfaces konfiguriert wurden, wird nun so konfiguriert, dass er die Syslog-Meldungen an den Syslog-Server sendet.

#figure(
  image("logging.png", width: 70%),
  caption: [Logging Cisco Router]
)

Abschließend werden die Syslog Messages an den Syslog-Server geschickt. Diese können mit dem `cat` Befehl anzeigt werden.  
#figure(
  image("logging_linux.png", width: 70%),
  caption: [Logging Linux Server]
)