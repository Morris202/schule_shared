== Pfsense
Die Pfsense wird auf dem Standort Sanctum Sanctorum eingesetzt. Sie dient als Firewall und Router und schützt das interne Netzwerk vor unerwünschtem Datenverkehr. Die Pfsense bietet eine Vielzahl von Funktionen und kann durch zusätzliche Pakete erweitert werden. Sie wird über eine Web-Oberfläche konfiguriert und kann auch über die Kommandozeile bedient werden.

=== Platformübergreifender VPN
Zwischen dem FortiGate-HA Cluster und der Pfsense wird ein VPN-Tunnel eingerichtet. Dieser Tunnel wird über IPsec realisiert und ermöglicht eine sichere Kommunikation zwischen den beiden Standorten. Die Konfiguration erfolgt auf beiden Seiten und beinhaltet die Angabe der IP-Adressen, der Pre-Shared Key und der Verschlüsselungseinstellungen.

Zuerst werden die IP-Adressen unter *Interfaces* zugewiesen. 

#figure(
  image("ipadd.png", width: 70%),
  caption: [Interface anlegen],
)
In der nachfolgenden Abbildung sehen sie die Konfiguration des VPN-Tunnels auf der Pfsense. Dies passiert unter *VPN* -> *IPsec* -> *Tunnels*.

#figure(
  image("vpn.png", width: 80%),
  caption: [VPN Tunnel],
)

Anschließend muss noch eine Rule für den VPN erstellt werden. Diese erlaubt standardmäßig den gesamten Traffic.
#figure(
  image("rule.png", width: 80%),
  caption: [Regel festlegen],
)