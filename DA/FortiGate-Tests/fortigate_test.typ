#import "@preview/document:0.1.0": *
#import "@preview/codelst:2.0.2": sourcecode
#show: doc => conf(
  doc,
  title: [Fortigate-Tests],
  subtitle: none,
  authors: ("Morris Tichy",),
  fach: "SvalinnCore",
  thema: "Fortigate Tests",
  create-outline: true,
  enumerate: true
)

= Fortigate-Tests
== Theorie
=== Denail of Service (DoS)
Ein Denial of Service (DoS) Angriff zielt darauf ab, die Verfügbarkeit eines Netzwerkdienstes zu beeinträchtigen. Dabei wird versucht, die Ressourcen des Ziels zu überlasten, um den Dienst unerreichbar zu machen. Ein DoS-Angriff kann durch verschiedene Methoden durchgeführt werden, wie z.B. SYN-Flooding, Ping of Death oder Smurf-Attacken.

=== IPv4 Dos Policies
Auf der FortiGate können genau aus diesem Grund extra Policies erstellt werden, um DoS-Angriffe zu verhindern. Diese Policies können auf der FortiGate konfiguriert werden, um den Traffic zu überwachen und zu filtern. Dabei können verschiedene Parameter wie z.B. die Anzahl der SYN-Pakete, die Anzahl der ICMP-Pakete oder die Anzahl der UDP-Pakete festgelegt werden.

== Konfiguration
=== DoS Policy erstellen
Die folgenden Konfigurationschritte werden in der GUI gezeigt, können aber auch über die CLI durchgeführt werden. Unter *Policy & Objects > Dos Policy > Create New* kann eine neue DoS Policy erstellt werden. Wir legen Namen, Incoming Interface, Source und Destination fest. Anschließend können die DoS-Parameter wie z.B. die Anzahl der SYN-Pakete oder die Anzahl der ICMP-Pakete festgelegt werden

#figure(
  image("dos1.png", width: 70%),
  caption: [DoS Policy erstellen]
)

#figure(
  image("dos2.png", width: 70%),
  caption: [DoS Parameter festlegen]
)

=== Scan von offenen Ports
Ein Portscan ist eine Methode, um offene Ports auf einem Host zu identifizieren. Dabei wird versucht, alle Ports eines Hosts zu scannen, um Schwachstellen zu identifizieren. Ein Portscan kann durch verschiedene Methoden durchgeführt werden, wie z.B. SYN-Scanning, TCP-Scanning oder UDP-Scanning. In unserem Fall wird auf einer Kali Linux Maschine, die sich im gleichen Netzwerk wie die FortiGate befindet, ein Portscan durchgeführt.

#sourcecode[```bash
hping3 --scan 1-65535 103.152.127.1 -S
```]
Nach der Eingabe dieses Befehls wird ein SYN-Scan auf alle Ports des Hosts durchgeführt. 

#figure(
  image("scan.png", width: 70%),
  caption: [Portscan auf FortiGate]
)
=== Flood
Durch die bekannt gewordenen offenen Ports kann die FortiGate jetzt zum Beispiel unter *Port 80* geflooded werden.

#figure(
  image("flood.png", width: 70%),
  caption: [Portscan auf FortiGate]
)

=== ICMP Flood
Ein ICMP-Flood-Angriff zielt darauf ab, die Ressourcen des Ziels zu überlasten, indem eine große Anzahl von ICMP-Paketen an das Ziel gesendet wird.

Mithilfe des Befehls:
#sourcecode[```bash
hping3 -1 --faster 103.152.127.1
```]
werden an die FortiGate in der Sekunde mehrere 100 icmp Pakete gesendet.

== Erkennen von DoS-Angriffen
Es ist nun möglich diese Angriff zu erkennen und zu blockieren. Die Logs können entweder in der FortiGate angeschaut werden oder auch im FortiAnalyzer. Im FortiAnalyzer sehen wir unter den *Top Threats* das die Angriffe erkannt worden sind und von der Policy geblockt wurden.

#figure(
  image("topthreats.png", width: 70%),
  caption: [Top Threats im FortiAnalyzer]
)

== Brute Force Attack
Eine Brute-Force-Attacke ist ein Angriff, bei dem ein Angreifer versucht, ein Passwort oder eine Verschlüsselung durch systematisches Ausprobieren aller möglichen Kombinationen zu knacken. In unserem Fall wird ein Brute
Force Angriff auf die FortiGate durchgeführt.

Da wir wissen das der port 22 offen ist, können wir mit dem Befehl:
#sourcecode[```bash
hydra -l admin -P /usr/share/wordlists/word.txt ssh://103.152.127.1
```]
einen Brute Force Angriff auf die FortiGate durchführen.

#figure(
  image("bruteforce.png", width: 70%),
  caption: [Brute Force Angriff auf FortiGate]
)
Der Screenshot zeigt, dass der Brute Force Angriff erfolgreich war und das Passwort *admin* war.