#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode

= Metasploit Scan
Als zweiten Schritt soll mithilfe von Metasploit ein Scan durchgeführt werden. Zuerst erfolgt aber die Installation von Metasploit. Da Metasploit in der Regel auf Kali Linux vorinstalliert ist, verwenden wir dieses. In dem Root teminal werden folgende Befehle ausgeführt, damit Metasploit gestartet wird. Zuerst wird ein Database Server installiert damit alle ergebnisse gespeichert werden können.
#sourcecode[```bash
sudo systemctl start postgresql
sudo msfdb init
```]
Anschließend wird Metasploit gestartet mit ```bash msfconsole```.

Sobald Metasploit geladen ist, werden Sie die folgende Eingabeaufforderung in Ihrem Terminal sehen - die Startbildschirme sind zufällig, machen Sie sich also keine Sorgen, wenn Ihrer anders aussieht:

#figure(
  image("metasploit.png", width: 60%),
  caption: ["Metasploit Ausgabe"],
)

Mit dem Befehl ```bash search portscan``` wird eine Liste aller verfügbaren Portscannern zurückgeliefert. 

== Nmap Scan
Mit dem Befehl ```bash db_nmap -v -sV 192.168.50.0/24``` wird ein Nmap Scan durchgeführt. Dieser Scan zeigt alle offenen Ports und die Versionen der Dienste, die auf diesen Ports laufen.

#figure(
  image("nmapscan.png", width: 60%),
  caption: ["Metasploit nmap Scan"],
)

Der Befehl ```bash hosts``` zeigt eine Liste an aller Geräte die im Netz gefunden worden sind. 
#figure(
  image("hosts.png", width: 60%),
  caption: ["Hosts im Netz"],
)

Mit dem Befehl ```bash services``` können alle gefunden und offen Ports angezeigt werden. 

#figure(
  image("services.png", width: 50%),
  caption: ["Hosts im Netz"],
)
